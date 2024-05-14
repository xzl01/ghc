libraries/ghc-bignum_PACKAGE = ghc-bignum
libraries/ghc-bignum_dist-install_GROUP = libraries
$(if $(filter ghc-bignum,$(PACKAGES_STAGE0)),$(eval $(call build-package,libraries/ghc-bignum,dist-boot,0)))
$(if $(filter ghc-bignum,$(PACKAGES_STAGE1)),$(eval $(call build-package,libraries/ghc-bignum,dist-install,1)))
$(if $(filter ghc-bignum,$(PACKAGES_STAGE2)),$(eval $(call build-package,libraries/ghc-bignum,dist-install,2)))
