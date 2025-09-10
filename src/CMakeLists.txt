cmake_minimum_required(VERSION 3.22)
message(STATUS "In source CMAKE")
add_executable(my_vulkan_app main.cpp)
target_link_libraries(my_vulkan_app PRIVATE shader kompute::kompute)

