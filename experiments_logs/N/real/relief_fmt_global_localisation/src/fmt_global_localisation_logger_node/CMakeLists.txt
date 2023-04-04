#add_library(relief_fmt_global_localisation_logger fmt_global_localisation_logger.cpp)

#target_link_libraries(relief_fmt_global_localisation_logger
  #${catkin_LIBRARIES})

#add_dependencies(relief_fmt_global_localisation_logger
  #${catkin_EXPORTED_TARGETS})

#add_executable(relief_fmt_global_localisation_logger_node
  #fmt_global_localisation_logger_node.cpp)

#target_link_libraries(relief_fmt_global_localisation_logger_node
  #relief_fmt_global_localisation_logger
  #${catkin_LIBRARIES}
#)

#add_dependencies(relief_fmt_global_localisation_logger_node
  #${catkin_EXPORTED_TARGETS}
#)


add_executable(relief_fmt_global_localisation_logger_node
  fmt_global_localisation_logger.cpp
  fmt_global_localisation_logger_node.cpp)

target_link_libraries(relief_fmt_global_localisation_logger_node
  ${catkin_LIBRARIES}
)
