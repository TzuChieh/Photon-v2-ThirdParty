cmake_minimum_required(VERSION 3.15)

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

# Compile with C++17 standard enabled
set(CMAKE_CXX_STANDARD          17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# TODO: option for switching between static and dynamic linking
# TODO: add g++/clang MT MD equivalent flags?

#------------------------------------------------------------------------------
# Set suitable CMAKE_CXX_FLAGS
#------------------------------------------------------------------------------

# Using MSVC
if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC")

    # use C++17 (VS usually do not pick up previous requests)
    set(CMAKE_CXX_FLAGS         "${CMAKE_CXX_FLAGS} /std:c++17")

    # use PDB files for debugging, which also provides potential optimizations
    set(CMAKE_CXX_FLAGS         "${CMAKE_CXX_FLAGS} /Zi")

    # use multithreaded compilation
    set(CMAKE_CXX_FLAGS         "${CMAKE_CXX_FLAGS} /MP")

    # statically link runtime lib to ensure 
    # set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} /MT")
    # set(CMAKE_CXX_FLAGS_DEBUG   "${CMAKE_CXX_FLAGS_DEBUG} /MTd")

# Using GCC
elseif("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")

    # as a fallback when CMake version < 3.8.0 or for whatever reasons
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++17")

# Using regular Clang or AppleClang
elseif(CMAKE_CXX_COMPILER_ID MATCHES "Clang")

    # TODO: enforce C++17 if previous requests have no use

endif()

include(ExternalProject)
include(GNUInstallDirs)

set(STB_LIBRARY_NAME         "stb")
set(ASIO_LIBRARY_NAME        "Asio")
set(GOOGLETEST_LIBRARY_NAME  "googletest")
set(ZLIB_LIBRARY_NAME        "zlib")
set(OPENEXR_LIBRARY_NAME     "OpenEXR")
set(STACKWALKER_LIBRARY_NAME "StackWalker")
set(GLFW_LIBRARY_NAME        "glfw")
set(GLAD_LIBRARY_NAME        "glad")
set(IMGUI_LIBRARY_NAME       "imgui")

#------------------------------------------------------------------------------
# stb
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
        -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
        -Dgtest_force_shared_crt:BOOL=ON
        
    INSTALL_COMMAND ${CMAKE_COMMAND} --install <BINARY_DIR> --config $<CONFIG> --prefix <INSTALL_DIR>)

#------------------------------------------------------------------------------
# Asio
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
# zlib
#------------------------------------------------------------------------------
set(ZLIB_COPIED_REPO_SRC_DIR "${PROJECT_BINARY_DIR}/zlib_copied_repo/")
set(ZLIB_COPIED_REPO_BIN_DIR "${PROJECT_BINARY_DIR}/zlib_copied_repo_build/")
set(ZLIB_LIBRARY_INSTALL_DIR "${THIRD_PARTY_INSTALL_DIR}/${ZLIB_LIBRARY_NAME}")

# Using a copied repository of zlib since zlib may modify its own source
# during configuration stage (which pollutes the source tree as changes will 
# be reflected in next commit and may not be reconfigured next time since the 
# original zonf.h has already gone/renamed to zconf.h.included).
file(COPY
    "./zlib/"
    DESTINATION ${ZLIB_COPIED_REPO_SRC_DIR})

# TODO: what if the user want to link to static version of zlib (zlibstatic)?
#       possibly check for flags and make that a cmake option

ExternalProject_Add(${ZLIB_LIBRARY_NAME}
    PREFIX         "${ZLIB_COPIED_REPO_BIN_DIR}"
    BUILD_ALWAYS   ON
    SOURCE_DIR     "${ZLIB_COPIED_REPO_SRC_DIR}"
    BINARY_DIR     "${ZLIB_COPIED_REPO_BIN_DIR}"
    INSTALL_DIR    "${ZLIB_LIBRARY_INSTALL_DIR}"
    
    CMAKE_CACHE_ARGS
        -DBUILD_TESTING:BOOL=OFF
        -DBUILD_SHARED_LIBS:BOOL=ON
        -DCMAKE_CXX_STANDARD:STRING=${CMAKE_CXX_STANDARD}
        -DCMAKE_CXX_STANDARD_REQUIRED:BOOL=ON
        -DCMAKE_CXX_FLAGS:STRING=${CMAKE_CXX_FLAGS}
        -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
        
    INSTALL_COMMAND ${CMAKE_COMMAND} --install <BINARY_DIR> --config $<CONFIG> --prefix <INSTALL_DIR>)

#------------------------------------------------------------------------------
# OpenEXR
#------------------------------------------------------------------------------
ExternalProject_Add(${OPENEXR_LIBRARY_NAME}
    DEPENDS        ${ZLIB_LIBRARY_NAME}

    PREFIX         "${PROJECT_BINARY_DIR}/${OPENEXR_LIBRARY_NAME}"
    BUILD_ALWAYS   ON
    SOURCE_DIR     "${PROJECT_SOURCE_DIR}/${OPENEXR_LIBRARY_NAME}"
    BINARY_DIR     "${PROJECT_BINARY_DIR}/${OPENEXR_LIBRARY_NAME}"
    INSTALL_DIR    "${THIRD_PARTY_INSTALL_DIR}/${OPENEXR_LIBRARY_NAME}"
    
    CMAKE_CACHE_ARGS
        -DBUILD_TESTING:BOOL=OFF
        -DBUILD_SHARED_LIBS:BOOL=ON
        -DCMAKE_CXX_STANDARD:STRING=${CMAKE_CXX_STANDARD}
        -DCMAKE_CXX_STANDARD_REQUIRED:BOOL=ON
        -DCMAKE_CXX_FLAGS:STRING=${CMAKE_CXX_FLAGS}
        -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
        -DOPENEXR_INSTALL_PKG_CONFIG:BOOL=ON
        -DILMBASE_INSTALL_PKG_CONFIG:BOOL=ON
        -DPYILMBASE_ENABLE:BOOL=OFF
        -DPYILMBASE_ENABLE:BOOL=OFF
        -DOPENEXR_BUILD_UTILS:BOOL=OFF
        -DOPENEXR_VIEWERS_ENABLE:BOOL=OFF
        -DILMBASE_OUTPUT_SUBDIR:STRING=
        -DOPENEXR_OUTPUT_SUBDIR:STRING=
        -DILMBASE_LIB_SUFFIX:STRING=
        -DOPENEXR_LIB_SUFFIX:STRING=
        -DZLIB_ROOT:STRING=${ZLIB_LIBRARY_INSTALL_DIR}
        
    INSTALL_COMMAND ${CMAKE_COMMAND} --install <BINARY_DIR> --config $<CONFIG> --prefix <INSTALL_DIR>)

#------------------------------------------------------------------------------
# StackWalker
#------------------------------------------------------------------------------
if(WIN32)
    ExternalProject_Add(${STACKWALKER_LIBRARY_NAME}
        PREFIX         "${PROJECT_BINARY_DIR}/${STACKWALKER_LIBRARY_NAME}"
        BUILD_ALWAYS   ON
        SOURCE_DIR     "${PROJECT_SOURCE_DIR}/${STACKWALKER_LIBRARY_NAME}"
        BINARY_DIR     "${PROJECT_BINARY_DIR}/${STACKWALKER_LIBRARY_NAME}"
        INSTALL_DIR    "${THIRD_PARTY_INSTALL_DIR}/${STACKWALKER_LIBRARY_NAME}"
        
        CMAKE_CACHE_ARGS
            -DBUILD_TESTING:BOOL=OFF
            -DBUILD_SHARED_LIBS:BOOL=ON
            -DCMAKE_CXX_STANDARD:STRING=${CMAKE_CXX_STANDARD}
            -DCMAKE_CXX_STANDARD_REQUIRED:BOOL=ON
            -DCMAKE_CXX_FLAGS:STRING=${CMAKE_CXX_FLAGS}
            -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
            -DStackWalker_DISABLE_TESTS:BOOL=ON
            
        INSTALL_COMMAND ${CMAKE_COMMAND} --install <BINARY_DIR> --config $<CONFIG> --prefix <INSTALL_DIR>)
endif()

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
        -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
        
    INSTALL_COMMAND ${CMAKE_COMMAND} --install <BINARY_DIR> --config $<CONFIG> --prefix <INSTALL_DIR>)

#------------------------------------------------------------------------------
# imgui
#------------------------------------------------------------------------------
# imgui is designed for projects to include the library source into your
# project directly. We simply copy its source into install directory.
file(COPY
    "${PROJECT_SOURCE_DIR}/${IMGUI_LIBRARY_NAME}/"
    DESTINATION "${THIRD_PARTY_INSTALL_DIR}/${IMGUI_LIBRARY_NAME}/")
