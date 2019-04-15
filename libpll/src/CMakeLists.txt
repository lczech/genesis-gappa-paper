include_directories (${PROJECT_SOURCE_DIR}/src)

file (GLOB_RECURSE testapp_sources ${PROJECT_SOURCE_DIR}/src/*.cpp)

set (EXECUTABLE_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/bin)

add_executable        (testapp_module ${testapp_sources})

target_link_libraries (testapp_module ${PLLMODULES_LIBRARIES})
target_link_libraries (testapp_module m)

set_target_properties (testapp_module PROPERTIES OUTPUT_NAME read-newick)
set_target_properties (testapp_module PROPERTIES PREFIX "")