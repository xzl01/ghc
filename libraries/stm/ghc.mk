libraries/stm_PACKAGE = stm
libraries/stm_dist-install_GROUP = libraries
$(if $(filter stm,$(PACKAGES_STAGE0)),$(eval $(call build-package,libraries/stm,dist-boot,0)))
$(if $(filter stm,$(PACKAGES_STAGE1)),$(eval $(call build-package,libraries/stm,dist-install,1)))
$(if $(filter stm,$(PACKAGES_STAGE2)),$(eval $(call build-package,libraries/stm,dist-install,2)))
