-- | Implements a selective lambda lifter, running late in the optimisation
-- pipeline.
--
-- The transformation itself is implemented in "StgLiftLams.Transformation".
-- If you are interested in the cost model that is employed to decide whether
-- to lift a binding or not, look at "StgLiftLams.Analysis".
-- "StgLiftLams.LiftM" contains the transformation monad that hides away some
-- plumbing of the transformation.
module StgLiftLams (
    -- * Late lambda lifting in STG
    -- $note
    Transformation.stgLiftLams
  ) where

import qualified StgLiftLams.Transformation as Transformation

-- Note [Late lambda lifting in STG]
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- $note
-- See also the <https://ghc.haskell.org/trac/ghc/wiki/LateLamLift wiki page>
-- and Trac #9476.
--
-- The basic idea behind lambda lifting is to turn locally defined functions
-- into top-level functions. Free variables are then passed as additional
-- arguments at *call sites* instead of having a closure allocated for them at
-- *definition site*. Example:
--
-- @
--    let x = ...; y = ... in
--    let f = {x y} \a -> a + x + y in
--    let g = {f x} \b -> f b + x in
--    g 5
-- @
--
-- Lambda lifting @f@ would
--
--   1. Turn @f@'s free variables into formal parameters
--   2. Update @f@'s call site within @g@ to @f x y b@
--   3. Update @g@'s closure: Add @y@ as an additional free variable, while
--      removing @f@, because @f@ no longer allocates and can be floated to
--      top-level.
--   4. Actually float the binding of @f@ to top-level, eliminating the @let@
--      in the process.
--
-- This results in the following program (with free var annotations):
--
-- @
--    f x y a = a + x + y;
--    let x = ...; y = ... in
--    let g = {x y} \b -> f x y b + x in
--    g 5
-- @
--
-- This optimisation is all about lifting only when it is beneficial to do so.
-- The above seems like a worthwhile lift, judging from heap allocation:
-- We eliminate @f@'s closure, saving to allocate a closure with 2 words, while
-- not changing the size of @g@'s closure.
--
-- You can probably sense that there's some kind of cost model at play here.
-- And you are right! But we also employ a couple of other heuristics for the
-- lifting decision which are outlined in "StgLiftLams.Analysis#when".
--
-- The transformation is done in "StgLiftLams.Transformation", which calls out
-- to 'StgLiftLams.Analysis.goodToLift' for its lifting decision.
-- It relies on "StgLiftLams.LiftM", which abstracts some subtle STG invariants
-- into a monadic substrate.
--
-- Suffice to say: We trade heap allocation for stack allocation.
-- The additional arguments have to passed on the stack (or in registers,
-- depending on architecture) every time we call the function to save a single
-- heap allocation when entering the let binding. Nofib suggests a mean
-- improvement of about 1% for this pass, so it seems like a worthwhile thing to
-- do. Compile-times went up by 0.6%, so all in all a very modest change.
--
-- For a concrete example, look at @spectral/atom@. There's a call to 'zipWith'
-- that is ultimately compiled to something like this
-- (module desugaring/lowering to actual STG):
--
-- @
--    propagate dt = ...;
--    runExperiment ... =
--      let xs = ... in
--      let ys = ... in
--      let go = {dt go} \xs ys -> case (xs, ys) of
--            ([], []) -> []
--            (x:xs', y:ys') -> propagate dt x y : go xs' ys'
--      in go xs ys
-- @
--
-- This will lambda lift @go@ to top-level, speeding up the resulting program
-- by roughly one percent:
--
-- @
--    propagate dt = ...;
--    go dt xs ys = case (xs, ys) of
--      ([], []) -> []
--      (x:xs', y:ys') -> propagate dt x y : go dt xs' ys'
--    runExperiment ... =
--      let xs = ... in
--      let ys = ... in
--      in go dt xs ys
-- @
