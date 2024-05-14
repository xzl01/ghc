libraries/containers/containers_PACKAGE = containers
libraries/containers/containers_dist-install_GROUP = libraries
$(if $(filter containers/containers,$(PACKAGES_STAGE0)),$(eval $(call build-package,libraries/containers/containers,dist-boot,0)))
$(if $(filter containers/containers,$(PACKAGES_STAGE1)),$(eval $(call build-package,libraries/containers/containers,dist-install,1)))
$(if $(filter containers/containers,$(PACKAGES_STAGE2)),$(eval $(call build-package,libraries/containers/containers,dist-install,2)))
