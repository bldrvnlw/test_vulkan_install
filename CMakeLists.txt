cmake_minimum_required(VERSION 3.22)

option(USE_VULKAN_KOMPUTE "Build the repo using the Vulkan kompute library - by default ON" ON)

if(USE_VULKAN_KOMPUTE)
    list(APPEND VCPKG_MANIFEST_FEATURES "kompute")

    # Make sure vcpkg toolchain is picked up (or pass -DCMAKE_TOOLCHAIN_FILE=...)
    # Example: cmake .. -DCMAKE_TOOLCHAIN_FILE=[vcpkg-root]/scripts/buildsystems/vcpkg.cmake
    set(VCPKG_OVERLAY_PORTS "${CMAKE_CURRENT_LIST_DIR}/vcpkg-overlays/kompute")

    if(WIN32 AND NOT DEFINED VCPKG_LIBRARY_LINKAGE)
        set(VCPKG_HOST_TRIPLET "x64-windows-static-md" CACHE STRING "")
        set(VCPKG_TARGET_TRIPLET "x64-windows-static-md" CACHE STRING "")
        set(VCPKG_LIBRARY_LINKAGE "static" CACHE STRING "")
    endif()
endif()

project(my_vulkan_app LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

if (USE_VULKAN_KOMPUTE)
    find_package(fmt CONFIG REQUIRED)
    find_package(kompute CONFIG REQUIRED)
endif()

# Validation layers are only useful in debug/dev builds
#if (VulkanValidationLayers_FOUND)
#    target_link_libraries(my_vulkan_app PRIVATE Vulkan::ValidationLayers)
#endif()

add_subdirectory(shader)
add_subdirectory(src)