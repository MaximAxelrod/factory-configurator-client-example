cmake_minimum_required(VERSION 3.5)

project(factory-configurator-client-example)

# This is needed for compiling and linking SW.
add_subdirectory("${CMAKE_CURRENT_SOURCE_DIR}/source/platform")

# mbed-cloud-client-platform-common
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/source/platform/include)

if (CMAKE_BUILD_TYPE MATCHES Debug)
	add_definitions(-DMBED_TRACE_MAX_LEVEL=TRACE_LEVEL_INFO -DPAL_NUMBER_OF_PARTITIONS=1 -DPAL_PRIMARY_PARTITION_PRIVATE=0 -DPAL_SECONDARY_PARTITION_PRIVATE=0)
else()
	add_definitions(-DMBED_TRACE_MAX_LEVEL=TRACE_LEVEL_ERROR -DPAL_NUMBER_OF_PARTITIONS=1 -DPAL_PRIMARY_PARTITION_PRIVATE=0 -DPAL_SECONDARY_PARTITION_PRIVATE=0)
endif()

# example source files
SET(
	factory-configurator-client-example
	${CMAKE_CURRENT_SOURCE_DIR}/source/factory_client_example.cpp
	${CMAKE_CURRENT_SOURCE_DIR}/source/fce_${SA_PV_OS_NAME}_socket_helper.cpp
	${CMAKE_CURRENT_SOURCE_DIR}/source/fce_common_helper.h
)

message ("*********************************************************************")
message ("factory-configurator-client-example = [[${factory-configurator-client-example}]]")
message ("*********************************************************************")

# On Linux, we might find different names for the network interface
# so we have to find it, and pass to the code, however, this may NOT work
# when building on one machine and running on a different one!
execute_process(COMMAND ip -o -4 route show to default
						COMMAND awk "{print $5}"
						COMMAND head -n1
						OUTPUT_STRIP_TRAILING_WHITESPACE
						OUTPUT_VARIABLE  ETHNAME)
set(TMPD \"${ETHNAME}\")
add_definitions(-DETHERNET_LINUX_IFACE_NAME=${TMPD})
message("ETHERNET_LINUX_IFACE_NAME=${ETHNAME}")

CREATE_TEST_LIBRARY(factory-configurator-client-example "${factory-configurator-client-example}" "")
ADDSUBDIRS()
