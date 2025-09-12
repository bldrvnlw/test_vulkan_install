cmake_minimum_required(VERSION 3.22)

# Make sure vcpkg toolchain is picked up (or pass -DCMAKE_TOOLCHAIN_FILE=...)
# Example: cmake .. -DCMAKE_TOOLCHAIN_FILE=[vcpkg-root]/scripts/buildsystems/vcpkg.cmake
set(VCPKG_OVERLAY_PORTS "${CMAKE_CURRENT_LIST_DIR}/vcpkg-overlays/kompute")

if(WIN32 AND NOT DEFINED VCPKG_LIBRARY_LINKAGE)
    set(VCPKG_HOST_TRIPLET "x64-windows-static-md" CACHE STRING "")
    set(VCPKG_TARGET_TRIPLET "x64-windows-static-md" CACHE STRING "")
    set(VCPKG_LIBRARY_LINKAGE "static" CACHE STRING "")
endif()

project(my_vulkan_app LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(fmt CONFIG REQUIRED)
find_package(kompute CONFIG REQUIRED)

# Validation layers are only useful in debug/dev builds
#if (VulkanValidationLayers_FOUND)
#    target_link_libraries(my_vulkan_app PRIVATE Vulkan::ValidationLayers)
#endif()

add_subdirectory(shader)
add_subdirectory(src)