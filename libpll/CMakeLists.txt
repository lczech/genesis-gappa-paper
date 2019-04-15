cmake_minimum_required (VERSION 2.8.7 FATAL_ERROR)

set (WARN_FLAGS               "-Wall -Wextra")
set (CMAKE_CXX_FLAGS          "-std=c++14 ${WARN_FLAGS}")

set (CMAKE_CXX_FLAGS_DEBUG    "-O0 -g -ggdb3 -DDEBUG -D_GLIBCXX_DEBUG")
set (CMAKE_CXX_FLAGS_RELEASE  "-O3 -DNDEBUG")

set( BUILD_PLLMODULES_STATIC ON   CACHE BOOL "Passing BUILD_PLLMODULES_STATIC=ON to pll-modules" )
set( BUILD_PLLMODULES_SHARED OFF  CACHE BOOL "Passing BUILD_PLLMODULES_SHARED=OFF to pll-modules" )

add_subdirectory( ${PROJECT_SOURCE_DIR}/pll-modules )

include_directories(${PLLMOD_EXPORTED_INCLUDE_PATH})

add_subdirectory(${PROJECT_SOURCE_DIR}/src)