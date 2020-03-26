cmake_minimum_required(VERSION 3.12)

project(Photon-v2-ThirdParty)

set(THIRD_PARTY_OUTPUT_DIR "${PROJECT_BINARY_DIR}/ThirdParty/")

# Set install prefix if not provided by the user; it is suggested to set cmake
# install prefix *after* project() call, 
# see https://stackoverflow.com/questions/39481958
# (HACK: note however subdirectories can have their own project() calls... 
# what's the effect on them?)
if(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
    set(CMAKE_INSTALL_PREFIX ${THIRD_PARTY_OUTPUT_DIR} CACHE PATH
        "Folder for storing built third-party libraries." FORCE)
endif()

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

set(BUILD_TESTING
    OFF CACHE BOOL 
    "Build the testing tree.")

if(WIN32)
    add_subdirectory("./StackWalker/")
endif()

add_subdirectory("./stb/")
add_subdirectory("./googletest/")
add_subdirectory("./Asio/")

# Using a copied repository of zlib since zlib may modify its own source
# during configuration stage (which pollutes the source tree as changes will 
# be reflected in next commit and may not be reconfigured next time since the 
# original zonf.h has already gone/renamed to zconf.h.included).
set(ZLIB_COPIED_REPO_SRC_DIR "${PROJECT_BINARY_DIR}/zlib_copied_repo/")
set(ZLIB_COPIED_REPO_BIN_DIR "${PROJECT_BINARY_DIR}/zlib_copied_repo_build/")
file(COPY
    "./zlib/"
    DESTINATION ${ZLIB_COPIED_REPO_SRC_DIR})
add_subdirectory(${ZLIB_COPIED_REPO_SRC_DIR} ${ZLIB_COPIED_REPO_BIN_DIR})

# set(ZLIB_INCLUDE_DIR
#     ${THIRD_PARTY_OUTPUT_DIR}/zlib/include/ CACHE STRING 
#     "Path to zlib's include directory.")

# TODO: are lib paths to the actual lib file?
# TODO: consider to use an external script to build zlib first?

# set(ZLIB_LIBRARY_DEBUG
#     ${THIRD_PARTY_OUTPUT_DIR}/zlib/lib/ CACHE STRING 
#     "Path to zlib's (debug) library directory.")

# set(ZLIB_LIBRARY_RELEASE
#     ${THIRD_PARTY_OUTPUT_DIR}/zlib/lib/ CACHE STRING 
#     "Path to zlib's (release) library directory.")

set(PYILMBASE_ENABLE
    OFF CACHE BOOL 
    "Enables configuration of the PyIlmBase module.")

set(PYILMBASE_ENABLE
    OFF CACHE BOOL 
    "Enables configuration of the PyIlmBase module.")

set(OPENEXR_BUILD_UTILS
    OFF CACHE BOOL 
    "Enables building of utility programs.")

set(OPENEXR_VIEWERS_ENABLE
    OFF CACHE BOOL 
    "Enables configuration of the viewers module.")

set(ILMBASE_OUTPUT_SUBDIR
    "" CACHE STRING 
    "Destination sub-folder of the include path for install.")

set(OPENEXR_OUTPUT_SUBDIR
    "" CACHE STRING 
    "Destination sub-folder of the include path for install.")

set(ILMBASE_LIB_SUFFIX
    "" CACHE STRING 
    "String added to the end of all the libraries.")

set(OPENEXR_LIB_SUFFIX
    "" CACHE STRING 
    "String added to the end of all the libraries.")

add_subdirectory("./OpenEXR/")

# add_dependencies(IlmImf
#     zlib zlibstatic)
