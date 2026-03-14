# This file is injected into each third-party project to force library prefixes 
# on Windows if they are not already set.

if(WIN32)
    # Check if the prefixes are empty and set them to "Photon_" if they are.
    # This avoids naming conflicts (dll hell) with other software (e.g., Blender).
    
    if("${CMAKE_SHARED_LIBRARY_PREFIX}" STREQUAL "")
        set(CMAKE_SHARED_LIBRARY_PREFIX "Photon_" CACHE STRING "Forced by Photon-v2-ThirdParty" FORCE)
    endif()
    
    if("${CMAKE_IMPORT_LIBRARY_PREFIX}" STREQUAL "")
        set(CMAKE_IMPORT_LIBRARY_PREFIX "Photon_" CACHE STRING "Forced by Photon-v2-ThirdParty" FORCE)
    endif()
    
    if("${CMAKE_STATIC_LIBRARY_PREFIX}" STREQUAL "")
        set(CMAKE_STATIC_LIBRARY_PREFIX "Photon_" CACHE STRING "Forced by Photon-v2-ThirdParty" FORCE)
    endif()
endif()
