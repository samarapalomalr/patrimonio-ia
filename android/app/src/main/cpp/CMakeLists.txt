cmake_minimum_required(VERSION 3.22.1)

project(edgeimpulse)

set(CMAKE_CXX_STANDARD 14)

add_library(
    edgeimpulse
    SHARED
    edge_impulse_jni.cpp
)

target_include_directories(edgeimpulse PRIVATE
    edge_impulse
)

file(GLOB_RECURSE EI_SOURCES
    edge_impulse/edge-impulse-sdk/*.cpp
)

target_sources(edgeimpulse PRIVATE ${EI_SOURCES})

find_library(log-lib log)

target_link_libraries(
    edgeimpulse
    ${log-lib}
)
