# Deps versions parsing
file(STRINGS "${MANTICORE_SOURCE_DIR}/deps.txt" lines)
foreach(line ${lines})
  if(line STREQUAL "---")
    break()
  endif()
    message("Parsing deps.txt line: ${line}")
    string(REGEX MATCH "^([^ ]+) ([^ ]+) ([^ ]+) ([^ ]+)" _ ${line})
    string(TOUPPER ${CMAKE_MATCH_1} dep)
    set(vernum ${CMAKE_MATCH_2})
    set(verdate ${CMAKE_MATCH_3})
    set(verhash ${CMAKE_MATCH_4})
    set("${dep}_VERNUM" ${vernum})
    set("${dep}_VERDATE" ${verdate})
    set("${dep}_VERHASH" ${verhash})

    # Increment first number in semver and assign it to max (incompatible)
    string(REGEX REPLACE "^([0-9]+)\\..*$" "\\1" major_version "${CMAKE_MATCH_2}")
    math(EXPR major_version "${major_version} + 1")
    set(vernum_max "${major_version}.0.0")
    set("${dep}_VERNUM_MAX" ${vernum_max})

    message("${dep} version: >= ${vernum}-${verdate}-${verhash} & < ${vernum_max}")
endforeach()