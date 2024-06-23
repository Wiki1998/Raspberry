cmake_minimum_required(VERSION 3.10.2)
project(RASP)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/bin)

add_executable(RASP
    main.cpp
)

set(CMAKE_CXX_FLAGS " -pthread " )


add_subdirectory(dependencies/TAL)


target_link_libraries(RASP TAL)

