cmake_minimum_required(VERSION 3.12)

project(Photon-v2-ThirdParty)

set(THIRD_PARTY_OUTPUT_DIR ${PROJECT_BINARY_DIR}/ThirdParty/)

# Set install prefix if not provided by the user; it is suggested to set cmake
# install prefix *after* project() call, 
# see https://stackoverflow.com/questions/39481958
# (HACK: note however subdirectories can have their own project() calls... 
# what's the effect on them?)
if(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
    set(CMAKE_INSTALL_PREFIX ${THIRD_PARTY_OUTPUT_DIR} CACHE PATH
        "Folder for storing built third-party libraries." FORCE)
endif()

# set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${THIRD_PARTY_OUTPUT_DIR})
# set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${THIRD_PARTY_OUTPUT_DIR})
# set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${THIRD_PARTY_OUTPUT_DIR})

# # To eliminate extra "Release" folder on MSVC
# set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELEASE ${THIRD_PARTY_OUTPUT_DIR})
# set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELEASE ${THIRD_PARTY_OUTPUT_DIR})
# set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE ${THIRD_PARTY_OUTPUT_DIR})

# Compile with C++17 standard enabled
set(CMAKE_CXX_STANDARD          17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# TODO: option for switching between static and dynamic linking
# TODO: add g++/clang MT MD equivalent flags?

# Using MSVC
if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC")

    # use C++17 (VS usually do not pick up previous requests)
    set(CMAKE_CXX_FLAGS         "${CMAKE_CXX_FLAGS} /std:c++17")

    # use PDB files for debugging, which also provides potential optimizations
    set(CMAKE_CXX_FLAGS         "${CMAKE_CXX_FLAGS} /Zi")

    # use multithreaded compilation
    set(CMAKE_CXX_FLAGS         "${CMAKE_CXX_FLAGS} /MP")

    # statically link runtime lib to ensure 
    set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} /MT")
    set(CMAKE_CXX_FLAGS_DEBUG   "${CMAKE_CXX_FLAGS_DEBUG} /MTd")

# Using GCC
elseif("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")

    set(THIRD_PARTY_PLATFORM "linux")

    # as a fallback when CMake version < 3.8.0 or for whatever reasons
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++17")

# Using regular Clang or AppleClang
elseif(CMAKE_CXX_COMPILER_ID MATCHES "Clang")
    
    set(THIRD_PARTY_PLATFORM "osx")

    # TODO: enforce C++17 if previous requests have no use

endif()

if(WIN32)
    add_subdirectory("./StackWalker/")
endif()

add_subdirectory("./stb/")
add_subdirectory("./googletest/")
add_subdirectory("./Asio/")
