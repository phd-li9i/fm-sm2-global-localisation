#ifndef FMT_GLOBAL_LOCALISATION_LOGGER_H
#define FMT_GLOBAL_LOCALISATION_LOGGER_H

#include <cmath>
#include <iostream>
#include <fstream>
#include <time.h>
#include <ros/ros.h>
#include <geometry_msgs/Pose.h>
#include <geometry_msgs/PoseArray.h>
#include <geometry_msgs/PoseWithCovarianceStamped.h>
#include <nav_msgs/OccupancyGrid.h>
#include <nav_msgs/Odometry.h>
#include <std_msgs/Duration.h>
#include <std_msgs/UInt64.h>
#include <std_msgs/String.h>
#include <std_msgs/Empty.h>
#include <std_srvs/Empty.h>
#include <tf/transform_datatypes.h>
#include <tf/transform_listener.h>
#include <tf/transform_broadcaster.h>

class FMTGlobalLocalisationLogger
{
  private:
    ros::NodeHandle nodehandle_;

    //
    unsigned int num_ground_truths_;
    int first_ground_truth_time_;

    // List subscribers
    ros::Subscriber ground_truth_sub_;
    ros::Subscriber global_pose_sub_;
    ros::Subscriber execution_time_sub_;
    ros::Subscriber map_sub_;
    ros::Subscriber num_particles_sub_;
    ros::Subscriber image_size_sub_;
    ros::Subscriber image_format_sub_;

    // List subscribed topics
    std::string ground_truth_topic_;
    std::string global_pose_topic_;
    std::string execution_time_topic_;
    std::string map_topic_;
    std::string num_particles_topic_;
    std::string image_size_topic_;
    std::string image_format_topic_;

    // service name
    std::string start_signal_service_name_;

    // List logfile filenames
    std::string ground_truth_filename_;
    std::string global_pose_filename_;
    std::string execution_time_filename_;
    std::string map_filename_;
    std::string num_particles_filename_;
    std::string image_size_filename_;
    std::string image_format_filename_;

    std::string map_name_;
    float map_resolution_;
    int map_height_;
    int map_width_;
    int map_origin_x_;
    int map_origin_y_;

    // Callbacks
    void groundTruthCallback(const nav_msgs::Odometry& msg);
    void globalPoseCallback(const geometry_msgs::PoseWithCovarianceStamped& msg);
    void executionTimeCallback(const std_msgs::Duration& msg);
    void mapCallback(const nav_msgs::OccupancyGrid& msg);
    void numParticlesCallback(const std_msgs::UInt64& msg);
    void imageSizeCallback(const std_msgs::UInt64& msg);
    void imageFormatCallback(const std_msgs::String& msg);

    // Init / helpers
    void loadParams();
    void initLogfiles();
    void logPose(const geometry_msgs::PoseWithCovarianceStamped& msg,
      const std::string& filename);
    void callFMTGlobalLocalisation();


  public:
    FMTGlobalLocalisationLogger(void);
    ~FMTGlobalLocalisationLogger(void);

};



#endif // FMT_GLOBAL_LOCALISATION_LOGGER_H
