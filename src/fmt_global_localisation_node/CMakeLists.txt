add_library(relief_fmt_global_localisation fmt_global_localisation.cpp)

# Range_libc required library
set(BASEPATH "${CMAKE_SOURCE_DIR}")
set(RANGELIB_DIR ${BASEPATH}/include/utils/range_libc)
add_library(relief_fmt_global_localisation_lodepng_lib
  ${RANGELIB_DIR}/vendor/lodepng/lodepng.cpp)

# Rabge_libc for rotation only
set(RANGELIB_ROTATION_DIR ${BASEPATH}/include/utils/range_libc_rotation)
add_library(relief_fmt_global_localisation_lodepng_lib_rotation
  ${RANGELIB_ROTATION_DIR}/vendor/lodepng/lodepng.cpp)

include_directories(include
  ${catkin_INCLUDE_DIRS}
  ${csm_INCLUDE_DIRS}
  /usr/include/pcl-1.7/
  /usr/include/eigen3/
  #/usr/include/python2.7/
  #/usr/include/octave-4.0.0/octave/
)


#Note we don't link against pcl as we're using header-only parts of the library
target_link_libraries(relief_fmt_global_localisation
  python2.7
  octinterp
  octave
  relief_fmt_global_localisation_lodepng_lib
  relief_fmt_global_localisation_lodepng_lib_rotation
  ${catkin_LIBRARIES}
  ${csm_LIBRARIES}
  relief_fmt_global_localisation_utils_lib)

add_dependencies(relief_fmt_global_localisation
  ${csm_EXPORTED_TARGETS}
  ${catkin_EXPORTED_TARGETS})

add_executable(relief_fmt_global_localisation_node
  fmt_global_localisation_node.cpp)

target_link_libraries(relief_fmt_global_localisation_node
  relief_fmt_global_localisation
  ${catkin_LIBRARIES}
)

add_dependencies(relief_fmt_global_localisation_node
  ${catkin_EXPORTED_TARGETS}
)
