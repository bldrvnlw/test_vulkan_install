## Building

Prerequisite: vcpkg is installed at `<VCPKG_INSTALL_DIR>`

1. Make a `build` dir under the source for testing
2. `cd build`
3. To configure pass your `<VCPKG_INSTALL_DIR>/vcpkg/scripts/buildsystems/vcpkg.cmake` as CMAKE_TOOLCHAIN_FILE (I think this is needed)
    `cmake .. -DCMAKE_TOOLCHAIN_FILE=<VCPKG_INSTALL_DIR>/vcpkg/scripts/buildsystems/vcpkg.cmake`
5. Build in Visual Studio or other.
6. Run the app it should output the result of an array multiplication

The first run of cmake will take sometime as the Vulkan SDK components are installed and built.
In this setup SPRV files are converted to .hpp and included in the .cpp for looding
