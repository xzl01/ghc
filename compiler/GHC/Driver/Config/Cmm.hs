module GHC.Driver.Config.Cmm
  ( initCmmConfig
  ) where

import GHC.Cmm.Config
import GHC.Cmm.Switch (backendSupportsSwitch)

import GHC.Driver.Session
import GHC.Driver.Backend

import GHC.Platform

import GHC.Prelude

initCmmConfig :: DynFlags -> CmmConfig
initCmmConfig dflags = CmmConfig
  { cmmProfile             = targetProfile                dflags
  , cmmOptControlFlow      = gopt Opt_CmmControlFlow      dflags
  , cmmDoLinting           = gopt Opt_DoCmmLinting        dflags
  , cmmOptElimCommonBlks   = gopt Opt_CmmElimCommonBlocks dflags
  , cmmOptSink             = gopt Opt_CmmSink             dflags
  , cmmGenStackUnwindInstr = debugLevel dflags > 0
  , cmmExternalDynamicRefs = gopt Opt_ExternalDynamicRefs dflags
  , cmmDoCmmSwitchPlans    = not . backendSupportsSwitch . backend $ dflags
  , cmmSplitProcPoints     = (backend dflags /= NCG)
                             || not (platformTablesNextToCode platform)
                             || usingInconsistentPicReg
  }
  where platform                = targetPlatform dflags
        usingInconsistentPicReg =
          case (platformArch platform, platformOS platform, positionIndependent dflags)
          of   (ArchX86, OSDarwin, pic) -> pic
               _                        -> False
