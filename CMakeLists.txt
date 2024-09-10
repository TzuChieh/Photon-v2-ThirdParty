cmake_minimum_required(VERSION 3.20)

# Just a meta project to drive compilation of libraries
project(Photon-v2-ThirdParty)

set(THIRD_PARTY_INSTALL_DIR "${PROJECT_BINARY_DIR}/ThirdParty")

# Set install prefix if not provided by the user; it is suggested to set cmake
# install prefix *after* project() call, 
# see https://stackoverflow.com/questions/39481958
# (HACK: note however subdirectories can have their own project() calls... 
# what's the effect on them?)
if(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
    set(CMAKE_INSTALL_PREFIX ${THIRD_PARTY_INSTALL_DIR} CACHE PATH
        "Folder for storing built third-party libraries." FORCE)
endif()

option(BUILD_SHARED_LIBS "Build as shared libraries if applicable." ON)

# Compile with C++23 standard enabled
set(CMAKE_CXX_STANDARD          23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

#------------------------------------------------------------------------------
# Set suitable CMAKE_CXX_FLAGS
#------------------------------------------------------------------------------

# Using MSVC
if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC")

    # Use C++23
    # set(CMAKE_CXX_FLAGS         "${CMAKE_CXX_FLAGS} /std:c++23")
    # Use `/std:c++latest` as VS does not fully support all C++23 features on VS 2022 v17.10.1)
    set(CMAKE_CXX_FLAGS         "${CMAKE_CXX_FLAGS} /std:c++latest")

    # Use PDB files for debugging, which also provides potential optimizations
    set(CMAKE_CXX_FLAGS         "${CMAKE_CXX_FLAGS} /Zi")

    # Use multithreaded compilation
    set(CMAKE_CXX_FLAGS         "${CMAKE_CXX_FLAGS} /MP")

# Using GCC
elseif("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")

    # Use C++23
    # set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++23")
    # Use `-std=c++2b` as g++ 13.2.0 does not fully support all C++23 features
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++2b")

# Using regular Clang or AppleClang
elseif(CMAKE_CXX_COMPILER_ID MATCHES "Clang")

    # Use C++23
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++23")

endif()

if(WIN32)
    set(WINDOWS_SDK_VERSION "10.0" CACHE STRING 
        "The windows SDK version to use. (10.0 = latest)")
    
    set(CMAKE_SYSTEM_VERSION ${WINDOWS_SDK_VERSION} CACHE INTERNAL
        "The version of the operating system for which CMake is to build." FORCE)
    message(STATUS
        "Third-party libraries will build with Windows SDK version ${CMAKE_SYSTEM_VERSION} (10.0 = latest)")
endif()

include(ExternalProject)
include(GNUInstallDirs)

set(STB_LIBRARY_NAME             "stb")
set(ASIO_LIBRARY_NAME            "Asio")
set(GOOGLETEST_LIBRARY_NAME      "googletest")
set(OPENEXR_LIBRARY_NAME         "OpenEXR")
set(GLFW_LIBRARY_NAME            "glfw")
set(GLAD_LIBRARY_NAME            "glad")
set(IMGUI_LIBRARIES_NAME         "ImGui")
set(CONCURRENTQUEUE_LIBRARY_NAME "concurrentqueue")
set(JSON_LIBRARY_NAME            "json")
set(TRACY_LIBRARY_NAME           "tracy")

# The following sections are configuring CMake settings for third-party libraries.
# If a library depends on another library, use `ExternalProject_Add()`'s `DEPENDS`
# option to specify inter dependencies.

#------------------------------------------------------------------------------
# stb (header-only)
#------------------------------------------------------------------------------
ExternalProject_Add(${STB_LIBRARY_NAME}
    PREFIX         "${PROJECT_BINARY_DIR}/${STB_LIBRARY_NAME}"
    BUILD_ALWAYS   ON
    SOURCE_DIR     "${PROJECT_SOURCE_DIR}/${STB_LIBRARY_NAME}"
    BINARY_DIR     "${PROJECT_BINARY_DIR}/${STB_LIBRARY_NAME}"
    INSTALL_DIR    "${THIRD_PARTY_INSTALL_DIR}/${STB_LIBRARY_NAME}"
    
    CMAKE_CACHE_ARGS
        -DBUILD_TESTING:BOOL=OFF
        -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
        
    INSTALL_COMMAND ${CMAKE_COMMAND} --install <BINARY_DIR> --config $<CONFIG> --prefix <INSTALL_DIR>)

#------------------------------------------------------------------------------
# googletest
#------------------------------------------------------------------------------
ExternalProject_Add(${GOOGLETEST_LIBRARY_NAME}
    PREFIX         "${PROJECT_BINARY_DIR}/${GOOGLETEST_LIBRARY_NAME}"
    BUILD_ALWAYS   ON
    SOURCE_DIR     "${PROJECT_SOURCE_DIR}/${GOOGLETEST_LIBRARY_NAME}"
    BINARY_DIR     "${PROJECT_BINARY_DIR}/${GOOGLETEST_LIBRARY_NAME}"
    INSTALL_DIR    "${THIRD_PARTY_INSTALL_DIR}/${GOOGLETEST_LIBRARY_NAME}"
    
    CMAKE_CACHE_ARGS
        -DBUILD_TESTING:BOOL=OFF
        -DBUILD_SHARED_LIBS:BOOL=ON
        -DCMAKE_CXX_STANDARD:STRING=${CMAKE_CXX_STANDARD}
        -DCMAKE_CXX_STANDARD_REQUIRED:BOOL=ON
        -DCMAKE_CXX_FLAGS:STRING=${CMAKE_CXX_FLAGS}

        # May not be set to empty, possibly related https://github.com/google/googletest/pull/3732
        -DCMAKE_DEBUG_POSTFIX:STRING=_d

        -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
        -DCMAKE_SYSTEM_VERSION:INTERNAL=${CMAKE_SYSTEM_VERSION}
        -Dgtest_force_shared_crt:BOOL=ON
        
    INSTALL_COMMAND ${CMAKE_COMMAND} --install <BINARY_DIR> --config $<CONFIG> --prefix <INSTALL_DIR>)

#------------------------------------------------------------------------------
# Asio (header-only)
#------------------------------------------------------------------------------
ExternalProject_Add(${ASIO_LIBRARY_NAME}
    PREFIX         "${PROJECT_BINARY_DIR}/${ASIO_LIBRARY_NAME}"
    BUILD_ALWAYS   ON
    SOURCE_DIR     "${PROJECT_SOURCE_DIR}/${ASIO_LIBRARY_NAME}"
    BINARY_DIR     "${PROJECT_BINARY_DIR}/${ASIO_LIBRARY_NAME}"
    INSTALL_DIR    "${THIRD_PARTY_INSTALL_DIR}/${ASIO_LIBRARY_NAME}"
    
    CMAKE_CACHE_ARGS
        -DBUILD_TESTING:BOOL=OFF
        -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
        
    INSTALL_COMMAND ${CMAKE_COMMAND} --install <BINARY_DIR> --config $<CONFIG> --prefix <INSTALL_DIR>)

#------------------------------------------------------------------------------
# OpenEXR
#------------------------------------------------------------------------------
ExternalProject_Add(${OPENEXR_LIBRARY_NAME}
    PREFIX         "${PROJECT_BINARY_DIR}/${OPENEXR_LIBRARY_NAME}"
    BUILD_ALWAYS   ON
    SOURCE_DIR     "${PROJECT_SOURCE_DIR}/${OPENEXR_LIBRARY_NAME}"
    BINARY_DIR     "${PROJECT_BINARY_DIR}/${OPENEXR_LIBRARY_NAME}"
    INSTALL_DIR    "${THIRD_PARTY_INSTALL_DIR}/${OPENEXR_LIBRARY_NAME}"
    
    CMAKE_CACHE_ARGS
        -DBUILD_TESTING:BOOL=OFF
        -DOPENEXR_BUILD_TOOLS:BOOL=OFF
        -DOPENEXR_BUILD_EXAMPLES:BOOL=OFF
        -DBUILD_SHARED_LIBS:BOOL=ON
        -DCMAKE_CXX_STANDARD:STRING=${CMAKE_CXX_STANDARD}
        -DCMAKE_CXX_STANDARD_REQUIRED:BOOL=ON
        -DCMAKE_CXX_FLAGS:STRING=${CMAKE_CXX_FLAGS}
        -DCMAKE_SYSTEM_VERSION:INTERNAL=${CMAKE_SYSTEM_VERSION}
        -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
        -DIMATH_INSTALL_PKG_CONFIG:BOOL=ON
        -DOPENEXR_INSTALL_PKG_CONFIG:BOOL=ON
        -DOPENEXR_OUTPUT_SUBDIR:STRING=
        -DOPENEXR_LIB_SUFFIX:STRING=
        
    INSTALL_COMMAND ${CMAKE_COMMAND} --install <BINARY_DIR> --config $<CONFIG> --prefix <INSTALL_DIR>)

#------------------------------------------------------------------------------
# glfw
#------------------------------------------------------------------------------
ExternalProject_Add(${GLFW_LIBRARY_NAME}
    PREFIX         "${PROJECT_BINARY_DIR}/${GLFW_LIBRARY_NAME}"
    BUILD_ALWAYS   ON
    SOURCE_DIR     "${PROJECT_SOURCE_DIR}/${GLFW_LIBRARY_NAME}"
    BINARY_DIR     "${PROJECT_BINARY_DIR}/${GLFW_LIBRARY_NAME}"
    INSTALL_DIR    "${THIRD_PARTY_INSTALL_DIR}/${GLFW_LIBRARY_NAME}"
    
    CMAKE_CACHE_ARGS
        -DBUILD_TESTING:BOOL=OFF
        -DBUILD_SHARED_LIBS:BOOL=ON
        -DCMAKE_CXX_STANDARD:STRING=${CMAKE_CXX_STANDARD}
        -DCMAKE_CXX_STANDARD_REQUIRED:BOOL=ON
        -DCMAKE_CXX_FLAGS:STRING=${CMAKE_CXX_FLAGS}
        -DCMAKE_DEBUG_POSTFIX:STRING=_d
        -DCMAKE_SYSTEM_VERSION:INTERNAL=${CMAKE_SYSTEM_VERSION}
        -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
        -DGLFW_BUILD_EXAMPLES:BOOL=OFF
        -DGLFW_BUILD_TESTS:BOOL=OFF
        -DGLFW_BUILD_DOCS:BOOL=OFF
        -DUSE_MSVC_RUNTIME_LIBRARY_DLL:BOOL=ON
        
    INSTALL_COMMAND ${CMAKE_COMMAND} --install <BINARY_DIR> --config $<CONFIG> --prefix <INSTALL_DIR>)

#------------------------------------------------------------------------------
# glad
#------------------------------------------------------------------------------
ExternalProject_Add(${GLAD_LIBRARY_NAME}
    PREFIX         "${PROJECT_BINARY_DIR}/${GLAD_LIBRARY_NAME}"
    BUILD_ALWAYS   ON
    SOURCE_DIR     "${PROJECT_SOURCE_DIR}/${GLAD_LIBRARY_NAME}"
    BINARY_DIR     "${PROJECT_BINARY_DIR}/${GLAD_LIBRARY_NAME}"
    INSTALL_DIR    "${THIRD_PARTY_INSTALL_DIR}/${GLAD_LIBRARY_NAME}"
    
    CMAKE_CACHE_ARGS
        -DBUILD_TESTING:BOOL=OFF
        -DBUILD_SHARED_LIBS:BOOL=ON
        -DCMAKE_CXX_STANDARD:STRING=${CMAKE_CXX_STANDARD}
        -DCMAKE_CXX_STANDARD_REQUIRED:BOOL=ON
        -DCMAKE_CXX_FLAGS:STRING=${CMAKE_CXX_FLAGS}
        -DCMAKE_DEBUG_POSTFIX:STRING=_d
        -DCMAKE_SYSTEM_VERSION:INTERNAL=${CMAKE_SYSTEM_VERSION}
        -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
        
    INSTALL_COMMAND ${CMAKE_COMMAND} --install <BINARY_DIR> --config $<CONFIG> --prefix <INSTALL_DIR>)

#------------------------------------------------------------------------------
# ImGui related libraries
#------------------------------------------------------------------------------
# imgui is designed for projects to include the library source into your
# project directly. This is also easier to maintain as they recommend to use 
# latest commits and we do not need to pre-compile any binaries by ourselves.
#
# implot follows imgui's integration principle.
#
# Due to the above reasons, We simply copy their source into install directory
# (the source are conveniently placed together under "./ImGui/" directory).
#
file(COPY
    "${PROJECT_SOURCE_DIR}/${IMGUI_LIBRARIES_NAME}/"
    DESTINATION "${THIRD_PARTY_INSTALL_DIR}/${IMGUI_LIBRARIES_NAME}/")

#------------------------------------------------------------------------------
# concurrentqueue (header-only)
#------------------------------------------------------------------------------
ExternalProject_Add(${CONCURRENTQUEUE_LIBRARY_NAME}
    PREFIX         "${PROJECT_BINARY_DIR}/${CONCURRENTQUEUE_LIBRARY_NAME}"
    BUILD_ALWAYS   ON
    SOURCE_DIR     "${PROJECT_SOURCE_DIR}/${CONCURRENTQUEUE_LIBRARY_NAME}"
    BINARY_DIR     "${PROJECT_BINARY_DIR}/${CONCURRENTQUEUE_LIBRARY_NAME}"
    INSTALL_DIR    "${THIRD_PARTY_INSTALL_DIR}/${CONCURRENTQUEUE_LIBRARY_NAME}"
    
    CMAKE_CACHE_ARGS
        -DBUILD_TESTING:BOOL=OFF
        -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
        
    INSTALL_COMMAND ${CMAKE_COMMAND} --install <BINARY_DIR> --config $<CONFIG> --prefix <INSTALL_DIR>)

#------------------------------------------------------------------------------
# json (header-only)
#------------------------------------------------------------------------------
ExternalProject_Add(${JSON_LIBRARY_NAME}
    PREFIX         "${PROJECT_BINARY_DIR}/${JSON_LIBRARY_NAME}"
    BUILD_ALWAYS   ON
    SOURCE_DIR     "${PROJECT_SOURCE_DIR}/${JSON_LIBRARY_NAME}"
    BINARY_DIR     "${PROJECT_BINARY_DIR}/${JSON_LIBRARY_NAME}"
    INSTALL_DIR    "${THIRD_PARTY_INSTALL_DIR}/${JSON_LIBRARY_NAME}"
    
    CMAKE_CACHE_ARGS
        -DBUILD_TESTING:BOOL=OFF
        -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
        -DJSON_BuildTests:BOOL=OFF
        -DJSON_CI:BOOL=OFF
        -DJSON_Install:BOOL=ON
        
    INSTALL_COMMAND ${CMAKE_COMMAND} --install <BINARY_DIR> --config $<CONFIG> --prefix <INSTALL_DIR>)

#------------------------------------------------------------------------------
# tracy
#------------------------------------------------------------------------------
ExternalProject_Add(${TRACY_LIBRARY_NAME}
    PREFIX         "${PROJECT_BINARY_DIR}/${TRACY_LIBRARY_NAME}"
    BUILD_ALWAYS   ON
    SOURCE_DIR     "${PROJECT_SOURCE_DIR}/${TRACY_LIBRARY_NAME}"
    BINARY_DIR     "${PROJECT_BINARY_DIR}/${TRACY_LIBRARY_NAME}"
    INSTALL_DIR    "${THIRD_PARTY_INSTALL_DIR}/${TRACY_LIBRARY_NAME}"
    
    CMAKE_CACHE_ARGS
        -DBUILD_TESTING:BOOL=OFF
        -DBUILD_SHARED_LIBS:BOOL=ON
        -DCMAKE_CXX_STANDARD:STRING=${CMAKE_CXX_STANDARD}
        -DCMAKE_CXX_STANDARD_REQUIRED:BOOL=ON
        -DCMAKE_CXX_FLAGS:STRING=${CMAKE_CXX_FLAGS}
        -DCMAKE_DEBUG_POSTFIX:STRING=_d
        -DCMAKE_SYSTEM_VERSION:INTERNAL=${CMAKE_SYSTEM_VERSION}
        -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
        
    INSTALL_COMMAND ${CMAKE_COMMAND} --install <BINARY_DIR> --config $<CONFIG> --prefix <INSTALL_DIR>)
    