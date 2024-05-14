libraries/text_PACKAGE = text
libraries/text_dist-install_GROUP = libraries
$(if $(filter text,$(PACKAGES_STAGE0)),$(eval $(call build-package,libraries/text,dist-boot,0)))
$(if $(filter text,$(PACKAGES_STAGE1)),$(eval $(call build-package,libraries/text,dist-install,1)))
$(if $(filter text,$(PACKAGES_STAGE2)),$(eval $(call build-package,libraries/text,dist-install,2)))
