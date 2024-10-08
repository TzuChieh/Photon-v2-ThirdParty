#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "Tracy::TracyClient" for configuration "Release"
set_property(TARGET Tracy::TracyClient APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(Tracy::TracyClient PROPERTIES
  IMPORTED_IMPLIB_RELEASE "${_IMPORT_PREFIX}/lib/TracyClient.lib"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/bin/TracyClient.dll"
  )

list(APPEND _cmake_import_check_targets Tracy::TracyClient )
list(APPEND _cmake_import_check_files_for_Tracy::TracyClient "${_IMPORT_PREFIX}/lib/TracyClient.lib" "${_IMPORT_PREFIX}/bin/TracyClient.dll" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
