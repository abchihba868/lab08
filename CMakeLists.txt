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
if(WIN32)
  set(CPACK_GENERATOR "WIX")
  set(CPACK_WIX_UPGRADE_GUID "A3B4C5D6-7890-1234-5678-EF9012345678")
  set(CPACK_WIX_LICENSE_RTF "${CMAKE_SOURCE_DIR}/LICENSE.rtf")
  set(CPACK_WIX_PRODUCT_ICON "${CMAKE_SOURCE_DIR}/assets/icon.ico")
  set(CPACK_WIX_UI_BANNER "${CMAKE_SOURCE_DIR}/assets/banner.bmp")
  set(CPACK_WIX_UI_DIALOG "${CMAKE_SOURCE_DIR}/assets/dialog.bmp")
endif()
include(CPack)
