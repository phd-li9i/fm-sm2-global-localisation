#include <fmt_global_localisation_node/fmt_global_localisation.h>

int main(int argc, char** argv)
{
  ros::init(argc, argv, "relief_fmt_global_localisation");
  ros::NodeHandle nh;
  ros::NodeHandle nh_private("~");

  FMTGlobalLocalisation pipeline_localisation(nh, nh_private);
  ros::spin();
  return 0;
}
