cmake_minimum_required(VERSION 3.22)
message(STATUS "In shader CMAKE")

if(USE_VULKAN_KOMPUTE)
    vulkan_compile_shader(
        INFILE shader.comp
        OUTFILE shader.hpp
        NAMESPACE "shader"
    )
else()
    file(WRITE shader.hpp "#pragma once\n")
endif()

add_custom_target(compile_shaders DEPENDS shader.hpp)

add_library(shader INTERFACE)
set_target_properties(shader PROPERTIES LINKER_LANGUAGE CXX)
target_include_directories(shader INTERFACE $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>)
add_dependencies(shader compile_shaders)