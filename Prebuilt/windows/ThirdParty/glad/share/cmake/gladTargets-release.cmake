#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "glad::glad" for configuration "Release"
set_property(TARGET glad::glad APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(glad::glad PROPERTIES
  IMPORTED_IMPLIB_RELEASE "${_IMPORT_PREFIX}/lib/glad.lib"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/bin/glad.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS glad::glad )
list(APPEND _IMPORT_CHECK_FILES_FOR_glad::glad "${_IMPORT_PREFIX}/lib/glad.lib" "${_IMPORT_PREFIX}/bin/glad.dll" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
