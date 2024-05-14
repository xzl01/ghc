libraries/ghc-heap_PACKAGE = ghc-heap
libraries/ghc-heap_dist-install_GROUP = libraries
$(if $(filter ghc-heap,$(PACKAGES_STAGE0)),$(eval $(call build-package,libraries/ghc-heap,dist-boot,0)))
$(if $(filter ghc-heap,$(PACKAGES_STAGE1)),$(eval $(call build-package,libraries/ghc-heap,dist-install,1)))
$(if $(filter ghc-heap,$(PACKAGES_STAGE2)),$(eval $(call build-package,libraries/ghc-heap,dist-install,2)))
