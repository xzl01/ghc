SRC_HC_OPTS        = -O -H64m
GhcStage1HcOpts    = -O
GhcStage2HcOpts    = -O0 -fllvm
GhcLibHcOpts       = -O2 -fllvm
BUILD_PROF_LIBS    = NO
SplitSections      = NO
HADDOCK_DOCS       = NO
BUILD_SPHINX_HTML  = NO
BUILD_SPHINX_PDF   = NO
BUILD_MAN          = NO
WITH_TERMINFO      = NO

BIGNUM_BACKEND       = native
Stage1Only           = YES
DYNAMIC_GHC_PROGRAMS = NO
