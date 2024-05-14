libraries/mtl_PACKAGE = mtl
libraries/mtl_dist-install_GROUP = libraries
$(if $(filter mtl,$(PACKAGES_STAGE0)),$(eval $(call build-package,libraries/mtl,dist-boot,0)))
$(if $(filter mtl,$(PACKAGES_STAGE1)),$(eval $(call build-package,libraries/mtl,dist-install,1)))
$(if $(filter mtl,$(PACKAGES_STAGE2)),$(eval $(call build-package,libraries/mtl,dist-install,2)))
