cmake_minimum_required(VERSION 3.10...3.28)

set(COVERAGE OFF CACHE BOOL "Coverage")
set(CMAKE_CXX_COMPILER "/usr/bin/g++")

project(TestRunning)

add_subdirectory("${CMAKE_CURRENT_SOURCE_DIR}/googletest" "gtest")
add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/banking)

add_executable(RunTest ${CMAKE_CURRENT_SOURCE_DIR}/tests/test.cpp)

if(COVERAGE)
    target_compile_options(RunTest PRIVATE --coverage)
    target_link_libraries(RunTest PRIVATE --coverage)
endif()

target_include_directories(RunTest PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/banking)
target_link_libraries(RunTest PRIVATE gtest gtest_main gmock_main banking)

include(InstallRequiredSystemLibraries)
set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_SOURCE_DIR}/LICENSE")
set(CPACK_PACKAGE_VERSION_MAJOR "1")
set(CPACK_PACKAGE_VERSION_MINOR "0")
set(CPACK_PACKAGE_VERSION_PATCH "0")
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "Banking application")
set(CPACK_PACKAGE_VENDOR "Pety")
set(CPACK_PACKAGE_CONTACT "ps.obukhov@gmail.com")
set(CPACK_GENERATOR "NSIS")
include(CPack)
