cmake_minimum_required(VERSION 3.22)
project(my_vulkan_app LANGUAGES CXX)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
list(APPEND CMAKE_MODULE_PATH "${kompute_SOURCE_DIR}/cmake")

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Make sure vcpkg toolchain is picked up (or pass -DCMAKE_TOOLCHAIN_FILE=...)
# Example: cmake .. -DCMAKE_TOOLCHAIN_FILE=[vcpkg-root]/scripts/buildsystems/vcpkg.cmake

# Using kompute built in vulkan header
# find_package(VulkanHeaders CONFIG REQUIRED)
find_package(VulkanLoader CONFIG REQUIRED)
find_package(glslang CONFIG REQUIRED)              # for shader compilation
# To use validationlayers manually add the vcpkg path
# "<vcpkg_installed>/bin" to the environment variable VK_ADD_LAYER_PATH
#find_package(VulkanValidationLayers CONFIG QUIET)  # optional in dev

include(get_cpm)
CPMAddPackage(
  NAME Kompute
  GITHUB_REPOSITORY KomputeProject/kompute
  GIT_TAG v0.9.0
)

# Validation layers are only useful in debug/dev builds
#if (VulkanValidationLayers_FOUND)
#    target_link_libraries(my_vulkan_app PRIVATE Vulkan::ValidationLayers)
#endif()
add_subdirectory(shader)
add_subdirectory(src)