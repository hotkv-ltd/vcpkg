vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO hotkv-ltd/hotkv-cpp-client
    REF "v${VERSION}"
    SHA512 35699cf1d57b9bd6618007218b24782df764a7720a361427f650023fc7c25ecbd14184518ade95f9d854ab9152ba0748a7ce4ce0208167afe118253330e8e09d
    HEAD_REF main
)

vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
        tls HOTKV_CPP_WITH_TLS
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        ${FEATURE_OPTIONS}
        -DHOTKV_CPP_BUILD_TESTS=OFF
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(PACKAGE_NAME hotkv-cpp CONFIG_PATH lib/cmake/hotkv-cpp)
vcpkg_fixup_pkgconfig()

file(REMOVE_RECURSE
    "${CURRENT_PACKAGES_DIR}/debug/include"
    "${CURRENT_PACKAGES_DIR}/debug/share"
)

file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/usage" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
