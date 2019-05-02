# ------------------------------------------------------------------------------
#   Build Options
# ------------------------------------------------------------------------------

set( EXECUTABLE_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/bin )

# Set rpath for all targets, so that they work out of the box (libgenesis.so in parent directory),
# as well as when relocating with the lib being in the same directory.
# Also, we need to set two versions of ORIGIN here (one and two dollar signs).
# This is because on some systems it seems to be escaped, on some not...
# See https://cmake.org/pipermail/cmake/2008-January/019290.html
# and https://cmake.org/Wiki/CMake_RPATH_handling for details.
# Tipp: Use `ldd binary` and `readelf -d binary` to check RPATH settings.
set( CMAKE_INSTALL_RPATH "$ORIGIN/..:$$ORIGIN/..:$ORIGIN:$$ORIGIN" )
set( CMAKE_BUILD_WITH_INSTALL_RPATH TRUE )

# ------------------------------------------------------------------------------
#   Sources
# ------------------------------------------------------------------------------

# Find all source files in this directory and compile them into individual binaries, each
# linked to the shared lib. All files should thus contain their own main function.
file( GLOB libpll_apps_sources ${PROJECT_SOURCE_DIR}/src/*.cpp )

include_directories( ${PROJECT_SOURCE_DIR}/lib )

# ------------------------------------------------------------------------------
#   Build Applications
# ------------------------------------------------------------------------------

if( libpll_apps_sources )

    message( STATUS "${ColorBlue}Building applications:${ColorEnd}" )
    foreach( app_src ${libpll_apps_sources} )
        get_filename_component( app_name ${app_src} NAME_WE )
        message( STATUS "  ${ColorBlue}${app_name}${ColorEnd}" )

        add_executable( ${app_name} ${app_src} )

        # Link against any external libraries, e.g. Pthreads.
        target_link_libraries (${app_name} ${PLLMODULES_LIBRARIES})
        target_link_libraries (${app_name} m)

    endforeach()

else()

    message( STATUS "No libpll applications found" )

endif()

# find all subdirs with CMakelists in them and add them
file( GLOB_RECURSE libpll_apps_subdirs */CMakeLists.txt )
foreach( sub_dir_cmake ${libpll_apps_subdirs} )
    get_filename_component( sub_dir ${sub_dir_cmake} DIRECTORY )
    get_filename_component( sub_dir_name ${sub_dir} NAME )
    message( STATUS "${ColorBlue}Building sub-apps: ${sub_dir_name}${ColorEnd}" )
    add_subdirectory(${sub_dir})
endforeach()
