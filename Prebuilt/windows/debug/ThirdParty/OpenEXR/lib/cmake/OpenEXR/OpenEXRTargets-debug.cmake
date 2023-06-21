#----------------------------------------------------------------
# Generated CMake target import file for configuration "Debug".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "OpenEXR::IlmImf" for configuration "Debug"
set_property(TARGET OpenEXR::IlmImf APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(OpenEXR::IlmImf PROPERTIES
  IMPORTED_IMPLIB_DEBUG "${_IMPORT_PREFIX}/lib/IlmImf_d.lib"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/bin/IlmImf_d.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS OpenEXR::IlmImf )
list(APPEND _IMPORT_CHECK_FILES_FOR_OpenEXR::IlmImf "${_IMPORT_PREFIX}/lib/IlmImf_d.lib" "${_IMPORT_PREFIX}/bin/IlmImf_d.dll" )

# Import target "OpenEXR::IlmImfUtil" for configuration "Debug"
set_property(TARGET OpenEXR::IlmImfUtil APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(OpenEXR::IlmImfUtil PROPERTIES
  IMPORTED_IMPLIB_DEBUG "${_IMPORT_PREFIX}/lib/IlmImfUtil_d.lib"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/bin/IlmImfUtil_d.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS OpenEXR::IlmImfUtil )
list(APPEND _IMPORT_CHECK_FILES_FOR_OpenEXR::IlmImfUtil "${_IMPORT_PREFIX}/lib/IlmImfUtil_d.lib" "${_IMPORT_PREFIX}/bin/IlmImfUtil_d.dll" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
