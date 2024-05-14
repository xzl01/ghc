libraries/exceptions_PACKAGE = exceptions
libraries/exceptions_dist-install_GROUP = libraries
$(if $(filter exceptions,$(PACKAGES_STAGE0)),$(eval $(call build-package,libraries/exceptions,dist-boot,0)))
$(if $(filter exceptions,$(PACKAGES_STAGE1)),$(eval $(call build-package,libraries/exceptions,dist-install,1)))
$(if $(filter exceptions,$(PACKAGES_STAGE2)),$(eval $(call build-package,libraries/exceptions,dist-install,2)))
