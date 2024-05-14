libraries/parsec_PACKAGE = parsec
libraries/parsec_dist-install_GROUP = libraries
$(if $(filter parsec,$(PACKAGES_STAGE0)),$(eval $(call build-package,libraries/parsec,dist-boot,0)))
$(if $(filter parsec,$(PACKAGES_STAGE1)),$(eval $(call build-package,libraries/parsec,dist-install,1)))
$(if $(filter parsec,$(PACKAGES_STAGE2)),$(eval $(call build-package,libraries/parsec,dist-install,2)))
