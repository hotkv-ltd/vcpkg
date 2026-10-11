vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO hotkv-ltd/hotkv-c-client
    REF "v${VERSION}"
    SHA512 39c6784d4a80c2affe7fd979d3ca9ebfd0fc457f5d5461f8d04552debdfef7c00e38a879287d4fd9e4ed9ac1784ac59044a5f281da38b4f8f0d863f070b43c92
    HEAD_REF main
)

vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
        tls HOTKV_USE_SSL
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        ${FEATURE_OPTIONS}
        -DHOTKV_BUILD_TESTS=OFF
        -DHOTKV_BUILD_EXAMPLES=OFF
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(PACKAGE_NAME hotkv CONFIG_PATH lib/cmake/hotkv)
vcpkg_fixup_pkgconfig()

file(REMOVE_RECURSE
    "${CURRENT_PACKAGES_DIR}/debug/include"
    "${CURRENT_PACKAGES_DIR}/debug/share"
    "${CURRENT_PACKAGES_DIR}/share/doc"
)

file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/usage" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
