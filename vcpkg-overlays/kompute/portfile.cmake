vcpkg_download_distfile(
    INCLUDE_FMT_PATCH
    URLS "https://github.com/KomputeProject/kompute/commit/e7985da9950bf75f00799f73b0e1d4ea7c24f0b2.patch?full_index=1"
    FILENAME "fix-fmt-include.patch"
    SHA512 ddcd290cb79b0c7a850525b0da73f760c519357a21bca6f18a9df692888507b231c500466602c363b04c942a5aed76d2241e7f5d58045c65339ca5392952f093
)

vcpkg_download_distfile(
    INSTALL_COMPILE_SHADER_PATCH
    URLS "https://github.com/KomputeProject/kompute/commit/48a954e2c7090a1d2bc5a127a97737fcd53f09d6.patch?full_index=1"
    FILENAME "install_compile_shader.patch"
    SHA512 b377784fb06f64b9bcaeed4b7640aad964d20853885f507e72e55843f44a1ab36e8db1cfb030cf5357e4128aad1ee363c3889dc82ba7b701dddc598a83a17822
)

vcpkg_download_distfile(
    SHADER_COMPILATION_INTERFACE_PATCH_1
    URLS "https://github.com/KomputeProject/kompute/commit/204783f9f538e84b557f3b744ddb2091a11c4559.patch?full_index=1"
    FILENAME "shader_compilation_interface_1.patch"
    SHA512 9f14ede35312fc016e3ee90a11fb536cff8c7df85e501c3fbf67ed158f14a961ac317011b7609fc0638655929815be21f8cb42deafe5ddd77121f7624f24b013
)

vcpkg_download_distfile(
    SHADER_COMPILATION_INTERFACE_PATCH_2
    URLS "https://github.com/KomputeProject/kompute/commit/afdc35c2058c1ae009eec1765ce565a4586f5f98.patch?full_index=1"
    FILENAME "shader_compilation_interface_2.patch"
    SHA512 ba7c3b4f32f543ae6e977ac35d362b93341e08fdd171766b37ca4380fbc63bd2c2fdfe8ec31595be9d22738952c1973c989b8f0e5dc1f8bc6ff2576b9ff35e6a
)

vcpkg_download_distfile(
    SHADER_COMPILATION_INTERFACE_PATCH_3
    URLS "https://github.com/KomputeProject/kompute/commit/ee041905ee16fb4e6e6397b3ac74291a6cc5d3d6.patch?full_index=1"
    FILENAME "shader_compilation_interface_3.patch"
    SHA512 81b11052cbfcaf86956a79d6b694de9ebcbf2da7893abb3dc94038ab368999c33343b840939f4fa2b1a55c41cc31875642e282dd6e2c92fb9907d1dabed3b464
)

vcpkg_download_distfile(
    SHADER_COMPILATION_INTERFACE_PATCH_4
    URLS "https://github.com/KomputeProject/kompute/commit/a2429292b77eb4fd184cc90361daac6b205237bb.patch?full_index=1"
    FILENAME "shader_compilation_interface_4.patch"
    SHA512 acb6a4658c48f60d63b1587fb117a0dca3ad43c01410b3846916b14bb22336ff5309c88132893932be2f6ac929efffbbd8e51dbb9dd3643d568794e9ebd1873f
)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO KomputeProject/kompute
    REF "v${VERSION}"
    SHA512 6ab912697bf78066497762d69901362595f6e212809a28a5d542bae83e0a31cd1c40877d4799de594df70fe98de1d0cb029023c3f9f4374baccc8788bbb64263
    HEAD_REF master
    PATCHES 
        "${INCLUDE_FMT_PATCH}"
        "${INSTALL_COMPILE_SHADER_PATCH}"
        "${SHADER_COMPILATION_INTERFACE_PATCH_1}"
        "${SHADER_COMPILATION_INTERFACE_PATCH_2}"
        "${SHADER_COMPILATION_INTERFACE_PATCH_3}"
        "${SHADER_COMPILATION_INTERFACE_PATCH_4}"
)
vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DKOMPUTE_OPT_BUILD_TESTS=OFF
        -DKOMPUTE_OPT_CODE_COVERAGE=OFF
        -DKOMPUTE_OPT_BUILD_DOCS=OFF
        -DKOMPUTE_OPT_INSTALL=ON
        -DKOMPUTE_OPT_BUILD_PYTHON=OFF
        -DKOMPUTE_OPT_LOG_LEVEL="Default"
        -DKOMPUTE_OPT_USE_SPDLOG=OFF
        -DKOMPUTE_OPT_ANDROID_BUILD=OFF
        -DKOMPUTE_OPT_DISABLE_VK_DEBUG_LAYERS=OFF
        -DKOMPUTE_OPT_BUILD_SHADERS=OFF              # Requires glslangValidator, i.e. glslang[tools]
        -DKOMPUTE_OPT_USE_BUILT_IN_SPDLOG=OFF
        -DKOMPUTE_OPT_SPDLOG_ASYNC_MODE=OFF
        -DKOMPUTE_OPT_USE_BUILT_IN_FMT=OFF
        -DKOMPUTE_OPT_USE_BUILT_IN_GOOGLE_TEST=OFF
        -DKOMPUTE_OPT_USE_BUILT_IN_PYBIND11=OFF
        -DKOMPUTE_OPT_USE_BUILT_IN_VULKAN_HEADER=OFF
        -DVulkan_GLSLC_EXECUTABLE="${CURRENT_HOST_INSTALLED_DIR}/tools/shaderc/glslc${VCPKG_HOST_EXECUTABLE_SUFFIX}"
)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/kompute)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/usage" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
