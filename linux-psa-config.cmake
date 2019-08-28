# global defines and configuration goes here...
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/../)

SET(SA_PV_OS_NAME "linux")
SET(CMAKE_C_FLAGS "-std=c99")
OPTION(USE_CRYPTO_SUBMODULE "Build and use libmbedcrypto from the crypto submodule." ON)

SET(PAL_TLS_BSP_DIR ${NEW_CMAKE_SOURCE_DIR}/mbed-cloud-client/mbed-client-pal/Configs/mbedTLS)

add_definitions(
    -DMBED_CONF_MBED_TRACE_ENABLE=1
    -DMBEDTLS_CONFIG_FILE="\\"${PAL_TLS_BSP_DIR}/mbedTLSConfig_${OS_BRAND}.h"\\"
    -DPAL_USER_DEFINED_CONFIGURATION="\\"source/pal_config_linux.h"\\"
    -DMBED_CLIENT_USER_CONFIG_FILE="\\"source/mbed_cloud_client_user_config.h"\\"
    -DMBED_CLOUD_CLIENT_USER_CONFIG_FILE="\\"source/mbed_cloud_client_user_config.h"\\"
    -DFCE_ETHERNET_INTERFACE
    -DCRYPTO_STORAGE_FILE_LOCATION="\\"pal/BACKUP/"\\"
    -DMBED_CONF_MBED_CLOUD_CLIENT_PSA_SUPPORT
)

# MBEDTLS PSA Crypto
add_definitions(
    -DMBEDTLS_USE_PSA_CRYPTO
    -DMBEDTLS_PSA_CRYPTO_C
    -DMBEDTLS_PSA_CRYPTO_STORAGE_C
    -DMBEDTLS_PSA_CRYPTO_STORAGE_FILE_C
    -DMBEDTLS_FS_IO
    -DMBEDTLS_PSA_ITS_FILE_C
)