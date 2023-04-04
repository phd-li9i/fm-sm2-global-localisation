#include <fmt_global_localisation_logger_node/fmt_global_localisation_logger.h>


/*******************************************************************************
 * Constructor. Initializes params / subscribers.
 */
FMTGlobalLocalisationLogger::FMTGlobalLocalisationLogger(void) :
                       first_ground_truth_time_ (0),
                       num_ground_truths_(0)
{
  loadParams();


  global_pose_sub_ = nodehandle_.subscribe(global_pose_topic_, 10,
    &FMTGlobalLocalisationLogger::globalPoseCallback, this);

  execution_time_sub_ = nodehandle_.subscribe(execution_time_topic_, 10,
    &FMTGlobalLocalisationLogger::executionTimeCallback, this);

  map_sub_ = nodehandle_.subscribe(map_topic_, 1,
    &FMTGlobalLocalisationLogger::mapCallback, this);

  num_particles_sub_ = nodehandle_.subscribe(num_particles_topic_, 1,
    &FMTGlobalLocalisationLogger::numParticlesCallback, this);

  image_size_sub_ = nodehandle_.subscribe(image_size_topic_, 1,
    &FMTGlobalLocalisationLogger::imageSizeCallback, this);

  image_format_sub_ = nodehandle_.subscribe(image_format_topic_, 1,
    &FMTGlobalLocalisationLogger::imageFormatCallback, this);

  initLogfiles();

  sleep(20);

  //callFMTGlobalLocalisation();

  ROS_INFO("[FMTGlobalLocalisationLogger] Node initialised");
}


/*******************************************************************************
 * Destructor
 */
FMTGlobalLocalisationLogger::~FMTGlobalLocalisationLogger(void)
{
  ROS_INFO("[FMTGlobalLocalisationLogger] Node destroyed");
}


/*******************************************************************************
 * Logs execution time
 */
void FMTGlobalLocalisationLogger::executionTimeCallback(const std_msgs::Duration& msg)
{
  std::ofstream file(execution_time_filename_.c_str(), std::ios::app);
  if (file.is_open())
  {
    file << msg.data.sec-0.7;
    file << ",";
    file << msg.data.nsec << std::endl;
    file.close();
  }
  else
    ROS_ERROR("[FMTGlobalLocalisationLogger] Could not log execution time");
}


/*******************************************************************************
 * Logs the ground truth pose of the robot.
 */
void FMTGlobalLocalisationLogger::groundTruthCallback(const nav_msgs::Odometry& msg)
{
  num_ground_truths_++;
  geometry_msgs::PoseWithCovarianceStamped ground_truth_pose;

  ground_truth_pose.header.stamp = msg.header.stamp;
  ground_truth_pose.pose = msg.pose;

  if (num_ground_truths_ > 1)
    return;


  if (map_name_.compare("fmt_corridor") == 0)
  {
    // resolution: 0.025 m/cell
    //ground_truth_pose.pose.pose.position.x += 12.2;
    //ground_truth_pose.pose.pose.position.y += 8.2;

    // resolution: 0.01 m/cell
    ground_truth_pose.pose.pose.position.x += 11.56;
    ground_truth_pose.pose.pose.position.y += 8.2;

    // resolution: 0.005 m/cell
    //ground_truth_pose.pose.pose.position.x += 11.56;
    //ground_truth_pose.pose.pose.position.y += 8.04;
  }

  if (map_name_.compare("fmt_home_karto") == 0)
  {
    ground_truth_pose.pose.pose.position.x += 17.597106;
    ground_truth_pose.pose.pose.position.y += 4.401109;
  }


  if (map_name_.compare("fmt_home_karto2") == 0)
  {
    ground_truth_pose.pose.pose.position.x += 10.490357;
    ground_truth_pose.pose.pose.position.y += 12.100007;
  }

  if (map_name_.compare("fmt_home_karto3") == 0)
  {
    ground_truth_pose.pose.pose.position.x += 20.440000;
    ground_truth_pose.pose.pose.position.y += 16.040000;
  }

  if (map_name_.compare("fmt_willowgarage") == 0)
  {
    ground_truth_pose.pose.pose.position.x += 60.2;
    ground_truth_pose.pose.pose.position.y += 55.9;
  }

  if (map_name_.compare("fmt_warehouse_karto") == 0)
  {
    ground_truth_pose.pose.pose.position.x += 2.083190;
    ground_truth_pose.pose.pose.position.y += 3.015576;
  }

  if (map_name_.compare("fmt_dirtrack") == 0)
  {
    ground_truth_pose.pose.pose.position.x += 3.346388;
    ground_truth_pose.pose.pose.position.y += 17.199677;
  }

  logPose(ground_truth_pose, ground_truth_filename_);
}


/*******************************************************************************
 * Logs image format used for fmt
 */
void FMTGlobalLocalisationLogger::imageFormatCallback(
  const std_msgs::String& msg)
{
  std::ofstream image_format_file(image_format_filename_.c_str(), std::ios::app);

  if (image_format_file.is_open())
  {
    image_format_file << msg.data << std::endl;
    image_format_file.close();
  }
}


/*******************************************************************************
 * Logs image size used for fmt
 */
void FMTGlobalLocalisationLogger::imageSizeCallback(
  const std_msgs::UInt64& msg)
{
  std::ofstream image_size_file(image_size_filename_.c_str(), std::ios::app);

  if (image_size_file.is_open())
  {
    image_size_file << msg.data << std::endl;
    image_size_file.close();
  }
}


/*******************************************************************************
 * Create the logfiles and register the headers.
 */
void FMTGlobalLocalisationLogger::initLogfiles(void)
{
  //----------------------------------------------------------------------------
  // Create the ground truth file
  std::ofstream ground_truth_file(ground_truth_filename_.c_str());
  if (ground_truth_file.is_open())
  {
    std::string header = "position.x, position.y, orientation.yaw";
    ground_truth_file << header << std::endl;
    ground_truth_file.close();
  }
  else
    ROS_ERROR("[FMTGlobalLocalisationLogger] Ground truth file not open");

  //----------------------------------------------------------------------------
  // Create the global pose file
  std::ofstream global_pose_file(global_pose_filename_.c_str());
  if (global_pose_file.is_open())
  {
    std::string header = "position.x, position.y, orientation.yaw";
    global_pose_file << header << std::endl;
    global_pose_file.close();
  }
  else
    ROS_ERROR("[FMTGlobalLocalisationLogger] global pose file not open");

  //----------------------------------------------------------------------------
  // Create the execution-time file
  std::ofstream execution_time_file(execution_time_filename_.c_str());
  if (execution_time_file.is_open())
  {
    std::string header = "exec_sec, exec_nsec";
    execution_time_file << header << std::endl;
    execution_time_file.close();
  }
  else
    ROS_ERROR("[FMTGlobalLocalisationLogger] execution-time file not open");

  //----------------------------------------------------------------------------
  // Create the map file
  std::ofstream map_file(map_filename_.c_str());
  if (map_file.is_open())
  {
    map_file << "occupied_x, occupied_y" << std::endl;
    map_file.close();
  }
  else
    ROS_ERROR("[FMTGlobalLocalisationLogger] Map file not open");

  //----------------------------------------------------------------------------
  // Create the number of particles file
  std::ofstream num_particles_file(num_particles_filename_.c_str());
  if (num_particles_file.is_open())
  {
    std::string header = "number of particles";
    num_particles_file << header << std::endl;
    num_particles_file.close();
  }
  else
    ROS_ERROR("[FMTGlobalLocalisationLogger] number of particles file not open");

  //----------------------------------------------------------------------------
  // Create the image size file
  std::ofstream image_size_file(image_size_filename_.c_str());
  if (image_size_file.is_open())
  {
    std::string header = "image height and width";
    image_size_file << header << std::endl;
    image_size_file.close();
  }
  else
    ROS_ERROR("[FMTGlobalLocalisationLogger] image size file not open");

  //----------------------------------------------------------------------------
  // Create the image format file
  std::ofstream image_format_file(image_format_filename_.c_str());
  if (image_format_file.is_open())
  {
    std::string header = "image format";
    image_format_file << header << std::endl;
    image_format_file.close();
  }
  else
    ROS_ERROR("[FMTGlobalLocalisationLogger] image format file not open");
}


/*******************************************************************************
 * Param loader. Check logger.h
 */
void FMTGlobalLocalisationLogger::loadParams(void)
{
  //----------------------------------------------------------------------------
  // Get topic names
  nodehandle_.getParam(ros::this_node::getName() + "/ground_truth_topic",
    ground_truth_topic_);
  nodehandle_.getParam(ros::this_node::getName() + "/global_pose_topic",
    global_pose_topic_);
  nodehandle_.getParam(ros::this_node::getName() + "/execution_time_topic",
    execution_time_topic_);
  nodehandle_.getParam(ros::this_node::getName() + "/map_topic",
    map_topic_);
  nodehandle_.getParam(ros::this_node::getName() + "/num_particles_topic",
    num_particles_topic_);
  nodehandle_.getParam(ros::this_node::getName() + "/image_size_topic",
    image_size_topic_);
  nodehandle_.getParam(ros::this_node::getName() + "/image_format_topic",
    image_format_topic_);
  nodehandle_.getParam(ros::this_node::getName() + "/start_signal_service_name",
    start_signal_service_name_);

  //----------------------------------------------------------------------------
  // Get log filenames
  nodehandle_.getParam(ros::this_node::getName() + "/ground_truth_filename",
    ground_truth_filename_);
  nodehandle_.getParam(ros::this_node::getName() + "/global_pose_filename",
    global_pose_filename_);
  nodehandle_.getParam(ros::this_node::getName() + "/execution_time_filename",
    execution_time_filename_);
  nodehandle_.getParam(ros::this_node::getName() + "/map_filename",
    map_filename_);
  nodehandle_.getParam(ros::this_node::getName() + "/num_particles_filename",
    num_particles_filename_);
  nodehandle_.getParam(ros::this_node::getName() + "/image_size_filename",
    image_size_filename_);
  nodehandle_.getParam(ros::this_node::getName() + "/image_format_filename",
    image_format_filename_);

  nodehandle_.getParam(ros::this_node::getName() + "/map_name",
    map_name_);
}


/*******************************************************************************
 * Logs a pose
 */
void FMTGlobalLocalisationLogger::logPose(
  const geometry_msgs::PoseWithCovarianceStamped& msg,
  const std::string& filename)
{
  std::ofstream file(filename.c_str(), std::ios::app);

  tf::Quaternion q(
    msg.pose.pose.orientation.x,
    msg.pose.pose.orientation.y,
    msg.pose.pose.orientation.z,
    msg.pose.pose.orientation.w);

  q.normalize();

  tf::Matrix3x3 m(q);
  double roll, pitch, yaw;
  m.getRPY(roll, pitch, yaw);

  if (file.is_open())
  {
    file << msg.pose.pose.position.x;
    file << ", ";
    file << msg.pose.pose.position.y;
    file << ", ";
    file << yaw << std::endl;

    file.close();
  }
  else
    ROS_ERROR("[FMTGlobalLocalisationLogger] Could not log pose");
}

/*******************************************************************************
 * Logs the map
 */
void FMTGlobalLocalisationLogger::mapCallback(
  const nav_msgs::OccupancyGrid& msg)
{
  std::ofstream map_file(map_filename_.c_str(), std::ios::app);

  if (map_file.is_open())
  {
    map_resolution_ = msg.info.resolution;
    map_height_ = msg.info.height;
    map_width_ = msg.info.width;
    map_origin_x_ = msg.info.origin.position.x;
    map_origin_y_ = msg.info.origin.position.y;

    for (int i = 0; i < map_height_; i++)
    {
      for (int j = 0; j < map_width_; j++)
      {
        unsigned int id = i * map_width_ + j;
        int cell = msg.data[id];

        if (cell == 100)
        {
          map_file << map_origin_x_ + j * map_resolution_;
          map_file << ", ";
          map_file << map_origin_y_ + i * map_resolution_;
          map_file << std::endl;
        }
      }
    }

    map_file.close();
  }
}


/*******************************************************************************
 * Logs number of particles used
 */
void FMTGlobalLocalisationLogger::numParticlesCallback(
  const std_msgs::UInt64& msg)
{
  std::ofstream num_particles_file(num_particles_filename_.c_str(), std::ios::app);

  if (num_particles_file.is_open())
  {
    num_particles_file << msg.data << std::endl;
    num_particles_file.close();
  }
}

/*******************************************************************************
 * Publishes a start signal to fmt global localisation
 */
void FMTGlobalLocalisationLogger::callFMTGlobalLocalisation()
{
  // Call fmt global localisation service
  ros::ServiceClient client =
    nodehandle_.serviceClient<std_srvs::Empty>(start_signal_service_name_);
  std_srvs::Empty srv;
  if (client.call(srv))
    ROS_INFO("[FMTGlobalLocalisationLogger] Successful call to fmt global localisation");
  else
  {
    ROS_ERROR("[FMTGlobalLocalisationLogger] Failed to call fmt global localisation");
    return;
  }
}
