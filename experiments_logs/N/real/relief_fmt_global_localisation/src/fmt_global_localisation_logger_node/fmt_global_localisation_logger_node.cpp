#include <fmt_global_localisation_logger_node/fmt_global_localisation_logger.h>

int main(int argc, char** argv)
{
  ros::init(argc, argv, "relief_fmt_global_localisation_logger");

  FMTGlobalLocalisationLogger fmt_global_localisation_logger;
  ros::spin();
  return 0;
}
