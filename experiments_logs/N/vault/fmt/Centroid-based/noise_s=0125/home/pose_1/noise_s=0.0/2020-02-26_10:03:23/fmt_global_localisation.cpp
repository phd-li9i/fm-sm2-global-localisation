/*
 * Copyright (c) 2011, Ivan Dryanovski, William Morris
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 *     * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above copyright
 *       notice, this list of conditions and the following disclaimer in the
 *       documentation and/or other materials provided with the distribution.
 *     * Neither the name of the CCNY Robotics Lab nor the names of its
 *       contributors may be used to endorse or promote products derived from
 *       this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 */

/*  This package uses Canonical Scan Matcher [1], written by
 *  Andrea Censi
 *  Code adopted and adapted from
 *  https://github.com/ccny-ros-pkg/scan_tools/tree/indigo/laser_scan_matcher
 *
 *  [1] A. Censi, "An ICP variant using a point-to-line metric"
 *  Proceedings of the IEEE International Conference
 *  on Robotics and Automation (ICRA), 2008
 */

#include <boost/assign.hpp>
#include <pcl_conversions/pcl_conversions.h>
#include <fmt_global_localisation_node/fmt_global_localisation.h>

#define DEBUG_EXECUTION_TIMES 0

/*******************************************************************************
 * @brief Constructor
 * @param[in] nh [ros::NodeHandle]
 * @param[in] nh_private [ros::NodeHandle]
 */
FMTGlobalLocalisation::FMTGlobalLocalisation(
  ros::NodeHandle nh, ros::NodeHandle nh_private):
  nh_(nh),
  nh_private_(nh_private),
  received_scan_(false),
  received_map_(false),
  received_pose_cloud_(false),
  received_both_scan_and_map_(0),
  received_start_signal_(false),
  ground_truths_latest_received_time_ (ros::Time::now()),
  robot_is_omw_(false),
  running_(false),
  omap_(ranges::OMap(1,1)),
  omap_rot_(ranges_rot::OMap(1,1)),
  rm_(ranges::RayMarching(omap_, 1)),
  cddt_(ranges::CDDTCast(omap_, 1, 1)),
  br_(ranges::BresenhamsLine(omap_, 1)),
  rot_rm_(ranges_rot::RayMarching(omap_rot_, 1)),
  rot_cddt_(ranges_rot::CDDTCast(omap_rot_, 1, 1)),
  rot_br_(ranges_rot::BresenhamsLine(omap_rot_, 1))
{
  ROS_INFO("[FMTGlobal Localiser] Starting FMTGlobalLocalisation");

  sleep(10);

  // **** init parameters

  const char * argvv [] = {"embedded", "--silent"};
  octave_main (2, (char **) argvv, 1);

  initParams();


  // **** state variables

  f2b_.setIdentity();
  input_.laser[0] = 0.0;
  input_.laser[1] = 0.0;
  input_.laser[2] = 0.0;

  // Initialize output_ vectors as Null for error-checking
  output_.cov_x_m = 0;
  output_.dx_dy1_m = 0;
  output_.dx_dy2_m = 0;

  // **** publishers

  // The  global pose result is fed-back to amcl through this publisher
  feedback_pose_publisher_ =
    nh_.advertise<geometry_msgs::PoseWithCovarianceStamped>(
      "/initialpose", 1);

  // The s result is published through this publisher
  global_pose_publisher_ =
    nh_.advertise<geometry_msgs::PoseWithCovarianceStamped>(
      ros::this_node::getName() + "/global_pose", 1);

  // Publisher of execution time
  execution_time_publisher_ =
    nh_.advertise<std_msgs::Duration>(
      ros::this_node::getName() + "/execution_time", 1);

  num_particles_publisher_ =
    nh_.advertise<std_msgs::UInt64>(
      ros::this_node::getName() + "/num_particles", 1);

  image_size_publisher_ =
    nh_.advertise<std_msgs::UInt64>(
      ros::this_node::getName() + "/image_size", 1);

  image_format_publisher_ =
    nh_.advertise<std_msgs::String>(
      ros::this_node::getName() + "/image_format", 1);

  // The world scan is published through this publisher
  world_scan_publisher_ =
    nh_.advertise<sensor_msgs::LaserScan>(
      ros::this_node::getName() + "/world_scan", 1);

  // The map scan is published through this publisher
  map_scan_publisher_ =
    nh_.advertise<sensor_msgs::LaserScan>(
      ros::this_node::getName() + "/map_scan", 1);

  // The corrected map scan (its frame is the laser frame) is published
  // through this publisher for debugging reasons
  map_scan_corrected_publisher_ =
    nh_.advertise<geometry_msgs::PoseArray>(
      ros::this_node::getName() + "/map_scan_corrected", 1);

  // *** subscribers

  // This is the map
  map_subscriber_ = nh_.subscribe(map_topic_, 1,
    &FMTGlobalLocalisation::mapCallback, this);

  // This is the scan subscriber
  scan_subscriber_ = nh_.subscribe(scan_topic_, 1,
    &FMTGlobalLocalisation::scanCallback, this);

  // This is the pose published by amcl
  pose_subscriber_ = nh_.subscribe(input_pose_topic_, 1,
    &FMTGlobalLocalisation::poseCallback, this);

  // This is the pose cloud published by amcl
  pose_cloud_subscriber_ = nh_.subscribe(input_pose_cloud_topic_, 1,
    &FMTGlobalLocalisation::poseCloudCallback, this);

  start_signal_service_ = nh_.advertiseService(start_signal_service_name_,
    &FMTGlobalLocalisation::startSignalService, this);

  // Re-set the map png file
  omap_ = ranges::OMap(map_png_file_);
  omap_rot_ = ranges_rot::OMap(map_png_file_);
}


/*******************************************************************************
 * @brief Destructor
 * @params void
 */
FMTGlobalLocalisation::~FMTGlobalLocalisation()
{
  ROS_INFO("[FMTGlobal Localiser] Destroying FMTGlobalLocalisation");
}

/*******************************************************************************
*/
std::vector<double> FMTGlobalLocalisation::callPythonFunc()
{
  setenv("PYTHONPATH",
    "/home/li9i/catkin_ws/src/relief_fmt_global_localisation/tmp/", 1);

  PyObject *pName, *pModule, *pDict, *pFunc, *pValue, *presult;

  // Initialize the Python Interpreter
  Py_Initialize();

  // Build the name object
  pName = PyString_FromString((char*)"func3");

  // Load the module object
  pModule = PyImport_Import(pName);

  // pDict is a borrowed reference
  pDict = PyModule_GetDict(pModule);

  // pFunc is also a borrowed reference
  pFunc = PyDict_GetItemString(pDict, (char*)"compute_rotation_angle");

  if (PyCallable_Check(pFunc))
  {
    pValue=Py_BuildValue("(z)",(char*)dft_image_format_.c_str());
    PyErr_Print();
    presult=PyObject_CallObject(pFunc,pValue);
    PyErr_Print();
  }
  else
    PyErr_Print();

  Py_DECREF(pValue);

  // Clean up
  Py_DECREF(pModule);
  Py_DECREF(pName);



  // For reference: how to return a list
  // https://stackoverflow.com/questions/35801531/returning-list-from-python-method-called-from-c
  std::vector<double> return_vector;
  for (Py_ssize_t i = 0; i < PyList_Size(presult); ++i)
  {
    PyObject* next = PyList_GetItem(presult, i);
    return_vector.push_back(PyFloat_AsDouble(next));
  }

  // Finish the Python Interpreter
  //Py_Finalize();

  return return_vector;
}


/*******************************************************************************
 * @brief This function provides the amcl algorithm with a corrected pose so
 * as to either (a) initialise itself with it, or (b) introduce the global pose
 * result as a new particle.
 * @param[in] pose [const geometry_msgs::Pose&] The pose
 * to feed to the amcl
 * @return void
 */
void
FMTGlobalLocalisation::closeLoop(
  const geometry_msgs::PoseWithCovarianceStamped& pose)
{
  feedback_pose_publisher_.publish(pose);
}


/*******************************************************************************
 * @brief Given two scans (their order matters), this function computes the
 * difference between all valid rays and returns a vector holding the values of
 * these diffs.
 * @param[in] scan_1 [const LDP&] The first scan (should be a world scan)
 * @param[in] scan_2 [const LDP&] The second scan (should be map scan)
 * @param[out] diff_scan [std::vector<double>] A vector holding the
 * difference between valid rays of scan_1 and scan_2.
 * @return [int] The number of valid rays
 */
int
FMTGlobalLocalisation::computeRaysDiff(
  const LDP& scan_1,
  const LDP& scan_2,
  std::vector<double>* diff_scan)
{
  if (scan_1->nrays != scan_2->nrays)
  {
    ROS_ERROR("[FMTGlobal Localiser] DFT diff rays computation impossible ...");
    ROS_ERROR("                     returning empty diff vector");
    return 0;
  }

  int num_valid_rays = 0;
  for (unsigned int i = 0; i < scan_1->nrays; i++)
  {
    if ( scan_1->valid[i] && scan_2->valid[i] )
    {
      diff_scan->push_back(scan_1->readings[i] - scan_2->readings[i]);
      num_valid_rays++;
    }
    else
      diff_scan->push_back(0.0);
  }

  return num_valid_rays;
}


/*******************************************************************************
 * @brief Copies a source LDP structure to a target one.
 * @param[in] source [const LDP&] The source structure
 * @param[out] target [LDP&] The destination structure
 * @return void
 */
void
FMTGlobalLocalisation::copyLDP(
  const LDP& source,
  LDP& target)
{
  unsigned int n = source->nrays;
  target = ld_alloc_new(n);

  copyMetaDataLDP(source, target);

  for (unsigned int i = 0; i < n; i++)
    copyRayDataLDP(source, target, i);
}

/*******************************************************************************
 * @brief Regarding a single ray with index id, this function copies data
 * from a ray of the source LDP structure to that of a target one.
 * @param[in] source [const LDP&] The source structure
 * @param[out] target [LDP&] The destination structure
 * @param[in] id [const int&] The ray index
 * @return void
 */
void
FMTGlobalLocalisation::copyRayDataLDP(
  const LDP& source,
  LDP& target,
  const int& id)
{
  target->valid[id] = source->valid[id];
  target->theta[id] = source->theta[id];
  target->cluster[id]  = source->cluster[id];
  target->readings[id] = source->readings[id];
}

/*******************************************************************************
 * @brief Regarding the metadata from a source LDP, copy them to a
 * a target LDP.
 * @param[in] source [const LDP&] The source structure
 * @param[out] target [LDP&] The destination structure
 * @return void
 */
void
FMTGlobalLocalisation::copyMetaDataLDP(
  const LDP& source,
  LDP& target)
{
  target->nrays = source->nrays;
  target->min_theta = source->min_theta;
  target->max_theta = source->max_theta;

  target->estimate[0] = source->estimate[0];
  target->estimate[1] = source->estimate[1];
  target->estimate[2] = source->estimate[2];

  target->odometry[0] = source->odometry[0];
  target->odometry[1] = source->odometry[1];
  target->odometry[2] = source->odometry[2];

  target->true_pose[0] = source->true_pose[0];
  target->true_pose[1] = source->true_pose[1];
  target->true_pose[2] = source->true_pose[2];
}


/*******************************************************************************
 * @brief This function uses the csm_icp result for correcting the amcl pose.
 * Given the icp output, this function express this correction in the
 * map frame. The result is the icp-corrected pose in the map frame.
 * @param[in,out] icp_corrected_pose
 * [geometry_msgs::Pose::Ptr&] The icp-corrected amcl pose
 * @return void
 */
void
FMTGlobalLocalisation::correctICPPose(
  geometry_msgs::Pose::Ptr& icp_corrected_pose,
  const tf::Transform& f2b)
{
  if (!nanInPose(icp_corrected_pose))
  {
    tf::Transform map_to_base_tf;
    tf::poseMsgToTF(*icp_corrected_pose, map_to_base_tf);

    // Now express the icp-corrected amcl pose in terms of the map frame ...
    tf::Transform icp_corrected_pose_tf = map_to_base_tf * f2b;

    // ... and convert the transform into a message
    tf::poseTFToMsg(icp_corrected_pose_tf, *icp_corrected_pose);

    // Make sure the orientation is in the [-π,π] interval
    wrapPoseOrientation(icp_corrected_pose);
  }
  else
  {
    // icp has failed: the icp-corrected pose falls back to the amcl pose
    ROS_ERROR("[FMTGlobalLocalisation] ICP has failed; falling back to amcl pose");
  }
}

/*******************************************************************************
 */
void
FMTGlobalLocalisation::correctDFTPose(
  geometry_msgs::Pose::Ptr& pose,
  const tf::Transform& f2b)
{
  if (!nanInPose(pose))
  {
    pose->position.x += f2b.getOrigin().x();
    pose->position.y += f2b.getOrigin().y();

    // The pose's original rotation
    tf::Quaternion q_0(
      pose->orientation.x,
      pose->orientation.y,
      pose->orientation.z,
      pose->orientation.w);

    tf::Matrix3x3 mat_0(q_0);
    double roll, pitch, yaw_0;
    mat_0.getRPY(roll, pitch, yaw_0);

    // The correction's rotation
    tf::Quaternion q_c = f2b.getRotation();
    tf::Matrix3x3 mat_c(q_c);
    double yaw_c;
    mat_c.getRPY(roll, pitch, yaw_c);

    double yaw = yaw_0 - yaw_c;

    tf::Quaternion q;
    q.setRPY(0.0, 0.0, yaw);
    q.normalize();
    tf::quaternionTFToMsg(q, pose->orientation);
  }
  else
  {
    // icp has failed: the icp-corrected pose falls back to the amcl pose
    ROS_ERROR("[FMTGlobalLocalisation] failure to correct pose (dft)");
  }
}


/*******************************************************************************
 * @brief Corrects the icp-corrected pose by means of the first coefficient of
 * a DFT of the signal which is the difference between a world scan and a
 * map scan.
 * @param[in,out] dft_corrected_pose [geometry_msgs::Pose::Ptr&]
 * When in, it is equal to the icp-corrected pose. When out, it is the
 * dft-corrected icp-corrected amcl pose.
 * @param[in] dft_coeff [std::vector<double>*] The DFT coefficients.
 * The first one is the real part of the first DFT coefficient. The second one
 * is the imaginary part of the first DFT coefficient.
 * @param[in] num_rays [const int&] The number of rays in the
 * scan that produced the dft_coeff vector
 * @return void
 */
  void
FMTGlobalLocalisation::correctICPPose(
  geometry_msgs::Pose::Ptr& dft_corrected_pose,
  const std::vector<double>& dft_coeff,
  const int& num_rays)
{
  if (nanInPose(dft_corrected_pose))
  {
    ROS_WARN("[FMTGlobalLocalisation] Detected nan's in correction of icp pose");
    return;
  }

  if (dft_coeff[0] == 0.0)
  {
    ROS_WARN("[FMTGlobalLocalisation] DFT-x returned 0.0");
    ROS_WARN("[FMTGlobalLocalisation] ... not likely for ICP to be that accuate");
  }
  if (dft_coeff[1] == 0.0)
  {
    ROS_WARN("[FMTGlobalLocalisation] DFT-y returned 0.0");
    ROS_WARN("[FMTGlobalLocalisation] ... not likely for ICP to be that accuate");
  }

  // Extract yaw from pose
  double yaw = extractYawFromPose(*dft_corrected_pose);

  // Set starting angle for scan ...
  double starting_angle;
  if (dft_do_fill_map_scan_)
    starting_angle = yaw - M_PI;
  else
    starting_angle = yaw + latest_world_scan_->angle_min;

  // ... and wrap within [-π,π]
  wrapAngle(starting_angle);

  // Turn the coefficients into x-wise and y-wise errors
  std::vector<double> errors = turnDFTCoeffsIntoErrors(
    dft_coeff, num_rays, starting_angle);

  double x_err = errors[0];
  double y_err = errors[1];

  // CORRECTION APPROACH A: simple
  dft_corrected_pose->position.x += x_err;

  if (laser_z_orientation_.compare("upwards") == 0)
    dft_corrected_pose->position.y += y_err;

  if (laser_z_orientation_.compare("downwards") == 0)
    dft_corrected_pose->position.y -= y_err;

  /*
  // CORRECTION APPROACH B: proper; equivalent to A
  // The dft correction is expressed in the laser frame.
  // Do the correction in the laser frame and return the corrected robot's pose
  tf::Transform dft_corrected_pose_tf;
  tf::poseMsgToTF(dft_corrected_pose->pose, dft_corrected_pose_tf);
  tf::Transform map_to_laser_pose_old_tf =
  dft_corrected_pose_tf * base_to_laser_;

  geometry_msgs::Pose map_to_laser_old_pose;
  tf::poseTFToMsg(map_to_laser_pose_old_tf, map_to_laser_old_pose);

  map_to_laser_old_pose.position.x += x_err;

  if (laser_z_orientation_.compare("upwards") == 0)
  map_to_laser_old_pose.position.y += y_err;

  if (laser_z_orientation_.compare("downwards") == 0)
  map_to_laser_old_pose.position.y -= y_err;

  tf::Transform map_to_laser_new_tf;
  tf::poseMsgToTF(map_to_laser_old_pose, map_to_laser_new_tf);

  // New position tf
  tf::Transform map_to_base_new_tf = map_to_laser_new_tf * laser_to_base_;
  tf::poseTFToMsg(map_to_base_new_tf, dft_corrected_pose->pose);
  */
}


/*******************************************************************************
 * @brief Creates a cache for access to values of sin and cos for all values
 * in [scan_msg->angle_min, can_msg->angle_max].
 * @param[in] scan_msg [const sensor_msgs::LaserScan::Ptr&] A scan
 * @return void
 */
  void
FMTGlobalLocalisation::createCache(const sensor_msgs::LaserScan::Ptr& scan_msg)
{
  a_cos_.clear();
  a_sin_.clear();

  double angle_min = scan_msg->angle_min;
  double angle_inc = scan_msg->angle_increment;

  for (unsigned int i = 0; i < scan_msg->ranges.size(); ++i)
  {
    double angle = angle_min + i * angle_inc;
    a_cos_.push_back(cos(angle));
    a_sin_.push_back(sin(angle));
  }

  input_.min_reading = scan_msg->range_min;
  input_.max_reading = scan_msg->range_max;
}


/*******************************************************************************
 * @brief Creates a transform from a 2D pose (x,y,theta)
 * @param[in] x [const double&] The x-wise coordinate of the pose
 * @param[in] y [const double&] The y-wise coordinate of the pose
 * @param[in] theta [const double&] The orientation of the pose
 * @param[in,out] t [tf::Transform&] The returned transform
 */
  void
FMTGlobalLocalisation::createTfFromXYTheta(
  const double& x,
  const double& y,
  const double& theta,
  tf::Transform& t)
{
  t.setOrigin(tf::Vector3(x, y, 0.0));
  tf::Quaternion q;
  q.setRPY(0.0, 0.0, theta);
  q.normalize();
  t.setRotation(q);
}


/*******************************************************************************
 * @brief The map scan is published through this function, as a means of visual
 * debug
 * @param[in] amcl_pose [const geometry_msgs::Pose::Ptr]
 * The pose of the robot.
 * @param[in] world_scan [const sensor_msgs::LaserScan::Ptr&] The world scan
 * @param[in] map_scan [const sensor_msgs::LaserScan::Ptr&] The map scan
 * @param[in] world_scan_ldp [const LDP&] The world scan in LDP form
 * @param[in] map_scan_ldp [const LDP&] The map scan in LDP form
 * @return void
 */
  void
FMTGlobalLocalisation::debugICP(
  const geometry_msgs::Pose::Ptr amcl_pose,
  const sensor_msgs::LaserScan::Ptr& world_scan,
  const sensor_msgs::LaserScan::Ptr& map_scan,
  const LDP& world_scan_ldp,
  const LDP& map_scan_ldp)
{
  // Publish scans for visualisation
  if (icp_do_publish_scans_)
    visualiseScans(world_scan_ldp, map_scan_ldp);

  geometry_msgs::PoseArray map_scan_corrected_poses =
    transformLaserScan(amcl_pose, map_scan, f2b_);

  map_scan_corrected_publisher_.publish(map_scan_corrected_poses);
}


/*******************************************************************************
 * @brief Given the ICP-corrected pose and a world scan, this function corrects
 * the pose by DFT-ing the difference between the world scan and a map scan
 * taken at the ICP-corrected pose.
 * @param[in] icp_corrected_pose
 * [const geometry_msgs::Pose::Ptr&]
 * The amcl pose corrected by the preceding ICP
 * @param[in] latest_world_scan [const sensor_msgs::LaserScan::Ptr&] The real
 * laser scan
 * @return void
 */
  void
FMTGlobalLocalisation::doDFT(
  const geometry_msgs::Pose::Ptr& icp_corrected_pose,
  const sensor_msgs::LaserScan::Ptr& latest_world_scan,
  sm_result* output, tf::Transform* f2b)
{
  // Measure execution time
#if DEBUG_EXECUTION_TIMES == 1
  ros::Time start_dft = ros::Time::now();
#endif

  geometry_msgs::Pose::Ptr dft_corrected_pose =
    boost::make_shared<geometry_msgs::Pose>(*icp_corrected_pose);

  // q[0] is occupied by the rotation angle
  std::vector<double> q;

  std::vector<double> errors_xy;
  errors_xy.push_back(0.0);
  errors_xy.push_back(0.0);
  double prev_error = 1000;

  // Convert the map and world scans into LDP and store it for the DFT module
  LDP dft_world_scan_ldp;
  laserScanToLDP(latest_world_scan, dft_world_scan_ldp);

  /*
  // Store the real scan image once
  storeRealScanRanges(dft_world_scan_ldp);
  plotRealScanImage();
  */

  // Declare the ever-changing map scan
  //sensor_msgs::LaserScan::Ptr map_scan;

  for (unsigned int i = 0; i < dft_iterations_; i++)
  {
    // Obtain the map scan
    sensor_msgs::LaserScan::Ptr map_scan;
    if (i == 0)
    {
      map_scan = scanMap(dft_corrected_pose,
        dft_map_scan_method_, "rotation", dft_do_fill_map_scan_);
    }
    else
    {
      map_scan = scanMap(dft_corrected_pose,
        dft_map_scan_method_, "translation", dft_do_fill_map_scan_);
    }

    LDP dft_map_scan_ldp;
    laserScanToLDP(map_scan, dft_map_scan_ldp);

    // Find rotation here
    if (i == 0)
    {
      storeVirtualScanRanges(dft_map_scan_ldp);
      plotVirtualScanImage();

      q = callPythonFunc();

      // See imreg_dft.py:141; if scale is not within bounds return with absurd
      // results
      double scale = fabs(q[3]);
      // 1.2, 0.8 nominally
      if (scale > 1.2 || scale < 0.8)
      {
        output->error = 0.0;
        output->valid = 0;
        createTfFromXYTheta(100.0, 100.0, 100.0, *f2b);
        return;
      }


      // Rotation angle is given in degrees
      q[0] *= M_PI / 180;

      // Rotate first
      rotate(dft_corrected_pose, q[0]);
      continue;
    }


    // Convert the two scans to points
    std::tuple<double,double,double> zero_pose;
    std::get<0>(zero_pose) = 0.0;
    std::get<1>(zero_pose) = 0.0;
    std::get<2>(zero_pose) = 0.0;

    std::vector< std::pair<double,double> > world_scan_points;
    ldp2points(dft_world_scan_ldp, zero_pose, &world_scan_points);

    std::vector< std::pair<double,double> > map_scan_points;
    ldp2points(dft_map_scan_ldp, zero_pose, &map_scan_points);

    // Find their centroids
    std::pair<double,double> world_scan_centroid =
      findCentroid(world_scan_points);

    std::pair<double,double> map_scan_centroid =
      findCentroid(map_scan_points);

    double ang = extractYawFromPose(*dft_corrected_pose);

    world_scan_centroid.first = cosf(ang) * world_scan_centroid.first -
                                sinf(ang) * world_scan_centroid.second;

    world_scan_centroid.second = sinf(ang) * world_scan_centroid.first +
                                 cosf(ang) * world_scan_centroid.second;

    map_scan_centroid.first = cosf(ang) * map_scan_centroid.first -
                              sinf(ang) * map_scan_centroid.second;

    map_scan_centroid.second = sinf(ang) * map_scan_centroid.first +
                               cosf(ang) * map_scan_centroid.second;


    double dx = world_scan_centroid.first - map_scan_centroid.first;
    double dy = world_scan_centroid.second - map_scan_centroid.second;


    dft_corrected_pose->position.x -= dx;
    dft_corrected_pose->position.y -= dy;


































/* -----------------------------------------------------------------------------
    // calculate diff
    std::vector<double> diff;
    double inclusion_bound = dft_world_scan_ldp->nrays/4*prev_error;
    double d = -1.0;
    for (unsigned int j = 0; j < dft_world_scan_ldp->nrays; j=j+1)
    {
      d = dft_world_scan_ldp->readings[j] - dft_map_scan_ldp->readings[j];

      if (fabs(d) < inclusion_bound)
        diff.push_back(d);
      else
        diff.push_back(0.0);
    }

    // X1
    std::vector<double> X1 = DFTUtils::getFirstDFTCoefficient(diff);

    // Find the x-wise and y-wise errors
    double t = M_PI + extractYawFromPose(*dft_corrected_pose);
    errors_xy = turnDFTCoeffsIntoErrors(X1, diff.size(), t);

    double x_e = errors_xy[0];
    double y_e = errors_xy[1];
    double err = sqrtf(x_e*x_e + y_e*y_e);

    dft_corrected_pose->position.x += x_e;

    if (laser_z_orientation_.compare("upwards") == 0)
      dft_corrected_pose->position.y += y_e;

    if (laser_z_orientation_.compare("downwards") == 0)
      dft_corrected_pose->position.y -= y_e;

    prev_error = err;

    //if (sqrtf(x_e*x_e + y_e*y_e) < 0.00001)
    if(sqrtf(X1[0]*X1[0] + X1[1]*X1[1]) < 0.0001)
      break;
*/ //---------------------------------------------------------------------------

    // Delete the map scan ptr
    map_scan.reset();
    ld_free(dft_map_scan_ldp);
  }

  ld_free(dft_world_scan_ldp);

  /*
  ROS_ERROR("at the end of coredft:");
  ROS_ERROR("(%f,%f,%f)",
    dft_corrected_pose->position.x,
    dft_corrected_pose->position.y,
   extractYawFromPose(*dft_corrected_pose));
   */

  output->valid = 1;
  output->error = q[4]; // / (fabs((1.0-fabs(q[3]))) + 1);


  // Find diff between dft_corrected_pose and icp_corrected_pose
  // and store it in a tf::Transform
  double dx = dft_corrected_pose->position.x - icp_corrected_pose->position.x;
  double dy = dft_corrected_pose->position.y - icp_corrected_pose->position.y;
  double dt = q[0];

  /*
  ROS_ERROR("dft core found = (%f,%f,%f)", dft_corrected_pose->position.x, dft_corrected_pose->position.y, q[0]);
  ROS_ERROR("scale = %f", q[3]);
  ROS_ERROR("success = %f", q[4]);
  ROS_ERROR("error = %f", output->error);
  */

  createTfFromXYTheta(dx, dy, dt, *f2b);

  //*f2b = base_to_laser_ * (*f2b) * laser_to_base_;


#if DEBUG_EXECUTION_TIMES == 1
  ROS_ERROR("doDFT() took %.2f ms",
    (ros::Time::now() - start_dft).toSec() * 1000);
#endif
}


/*******************************************************************************
 * @brief Given the amcl pose and a world scan, this function corrects
 * the pose by ICP-ing the world scan and a map scan taken at the amcl pose
 * @param[in] amcl_pose_msg [const geometry_msgs::Pose::Ptr&]
 * The amcl pose
 * @param[in] latest_world_scan [const sensor_msgs::LaserScan::Ptr&] The real
 * laser scan
 * @return void
 * pose
 */
  void
FMTGlobalLocalisation::doICP(
  const geometry_msgs::Pose::Ptr& amcl_pose_msg,
  const sensor_msgs::LaserScan::Ptr& latest_world_scan,
  sm_result* output, tf::Transform* f2b)
{
  // Measure execution time
#if DEBUG_EXECUTION_TIMES == 1
  ros::Time start_icp = ros::Time::now();
#endif

  geometry_msgs::Pose::Ptr icp_corrected_pose =
    boost::make_shared<geometry_msgs::Pose>(*amcl_pose_msg);

  // Convert the latest world scan into LDP form
  LDP world_scan_ldp;
  laserScanToLDP(latest_world_scan, world_scan_ldp);

  // Obtain the map scan ...
  sensor_msgs::LaserScan::Ptr map_scan = scanMap(icp_corrected_pose,
    icp_map_scan_method_, "translation", icp_do_fill_map_scan_);

  // .. and turn into a suitable structure (LDP) for processing
  LDP map_scan_ldp;
  laserScanToLDP(map_scan, map_scan_ldp);

  // Preprocess the map and world scans. Conditionally:
  // 1. fill their blind spots
  // 2. clip above and below thresholds
  // 3. undersample to mitigate noise
  // 4. invalidate rays whose difference is greater than a set threshold
  preprocessICPScans(world_scan_ldp, map_scan_ldp);

  // Do the ICP thing
  processScan(world_scan_ldp, map_scan_ldp, output, f2b);

  // RVIzual debug
  if (icp_visual_debug_)
    debugICP(icp_corrected_pose, latest_world_scan, map_scan,
      world_scan_ldp, map_scan_ldp);

  // Correct the amcl pose given the icp output
  //correctAmclPose(icp_corrected_pose);

  // Delete the map scan ptr and the LDPs
  map_scan.reset();
  ld_free(world_scan_ldp);
  ld_free(map_scan_ldp);

#if DEBUG_EXECUTION_TIMES == 1
  ROS_ERROR("doICP() took %.2f ms",
    (ros::Time::now() - start_icp).toSec() * 1000);
#endif
}


/*******************************************************************************
 * @brief Extracts the yaw component from the input pose's quaternion.
 * @param[in] pose [const geometry_msgs::Pose&] The input pose
 * @return [double] The pose's yaw
 */
  double
FMTGlobalLocalisation::extractYawFromPose(const geometry_msgs::Pose& pose)
{
  tf::Quaternion q(
    pose.orientation.x,
    pose.orientation.y,
    pose.orientation.z,
    pose.orientation.w);

  tf::Matrix3x3 mat(q);
  double roll, pitch, yaw;
  mat.getRPY(roll, pitch, yaw);

  wrapAngle(yaw);

  return yaw;
}


/*******************************************************************************
*/
  void
FMTGlobalLocalisation::dumpScan2(const LDP& real_scan, const LDP& virtual_scan)
{
  std::tuple<double,double,double> zero_pose;
  std::get<0>(zero_pose) = 0.0;
  std::get<1>(zero_pose) = 0.0;
  std::get<2>(zero_pose) = 0.0;

  std::vector< std::pair<double,double> > real_scan_points;
  ldp2points(real_scan, zero_pose, &real_scan_points);

  std::vector< std::pair<double,double> > virtual_scan_points;
  ldp2points(virtual_scan, zero_pose, &virtual_scan_points);

  std::string dump_filepath =
    "/home/li9i/catkin_ws/src/relief_fmt_global_localisation/tmp/scan_dump.m";
  std::ofstream file(dump_filepath.c_str(), std::ios::trunc);

  if (file.is_open())
  {
    file << "rx = [];" << std::endl;
    file << "ry = [];" << std::endl;

    for (int i = 0; i < real_scan->nrays; i++)
    {
      file << "rx = [rx " << real_scan_points[i].first << "];" << std::endl;
      file << "ry = [ry " << real_scan_points[i].second << "];" << std::endl;
    }

    file << "vx = [];" << std::endl;
    file << "vy = [];" << std::endl;
    for (int i = 0; i < virtual_scan->nrays; i++)
    {
      file << "vx = [vx " << virtual_scan_points[i].first << "];" << std::endl;
      file << "vy = [vy " << virtual_scan_points[i].second << "];" << std::endl;
    }

    file.close();
  }
  else
    printf("[FMTGlobal Localiser] Could not log scans\n");
}

/*******************************************************************************
 * @brief Receives two laser scans in LDP form as input.
 * Supposing that ldp.max_theta - ldp.min_theta < 2π, this function fills in the
 * missing range values of target_scan_ldp (missing in the sense that in the
 * end the target scan will be ranging over 2π) with the values of
 * source_scan_ldp that correspond to the missing angles.
 * Noise of a normal distribution is then added to these values.
 * @param[in] source_scan_ldp [const LDP&] The source scan (should be a map
 * scan)
 * @param[in,out] target_scan_ldp [LDP&] The target scan whose missing range
 * values will be filled-in (should be a world scan)
 * @param[in] operation [const std::string&] The origin operation; should be
 * either "icp" or "dft".
 * @return void
 */
  void
FMTGlobalLocalisation::fillLaserScanLDP(
  const LDP& source_scan_ldp,
  LDP& target_scan_ldp,
  const std::string& operation)
{
  double angle_min = target_scan_ldp->min_theta;
  double angle_max = target_scan_ldp->max_theta;

  // The unfilled scan's number of rays
  int prev_nrays = target_scan_ldp->nrays;

  // The filled scan's number of rays
  int two_pi_nrays =
    numRaysFromAngleRange(angle_min, angle_max, prev_nrays, 2*M_PI);

  // How many rays to fill in
  int total_rays_to_fill = two_pi_nrays - prev_nrays;

  // We assume a symmetrical distribution of rays around 0
  int half_nrays = total_rays_to_fill / 2;

  // This is the filled-in scan:
  // world_scan + map_scan (where world_scan is unfilled)
  LDP total_scan_ldp = ld_alloc_new(two_pi_nrays);

  // Random generators; one per operation
  boost::variate_generator<boost::mt19937, boost::normal_distribution<> >
    generator_icp(boost::mt19937(time(0)),
      boost::normal_distribution<>(
        icp_fill_mean_value_, icp_fill_std_value_));

  boost::variate_generator<boost::mt19937, boost::normal_distribution<> >
    generator_dft(boost::mt19937(time(0)),
      boost::normal_distribution<>(
        dft_fill_mean_value_, dft_fill_std_value_));

  // Fill first missing segment
  for (unsigned int i = 0; i < half_nrays; i++)
  {
    // A random number that will be used to add noise to the rays of the map
    // scan that are missing from world scan
    double rn = 0.0;
    if (operation.compare(op_icp_) == 0)
      rn = generator_icp();
    else if (operation.compare(op_dft_) == 0)
      rn = generator_dft();
    else
    {
      ROS_ERROR("[FMTGlobal Localiser] Unknown operation. Aborting ...");
      return;
    }

    total_scan_ldp->valid[i] = source_scan_ldp->valid[i];
    total_scan_ldp->theta[i] = source_scan_ldp->theta[i];

    if (source_scan_ldp->readings[i] + rn <= latest_world_scan_->range_min)
      total_scan_ldp->readings[i] = latest_world_scan_->range_min;
    else if (source_scan_ldp->readings[i] + rn >= latest_world_scan_->range_max)
      total_scan_ldp->readings[i] = latest_world_scan_->range_max;
    else
      total_scan_ldp->readings[i] = source_scan_ldp->readings[i] + rn;
  }

  // Copy actual laser ranges
  for (unsigned int i = 0; i < prev_nrays; i++)
  {
    total_scan_ldp->valid[half_nrays + i] = target_scan_ldp->valid[i];
    total_scan_ldp->theta[half_nrays + i] = target_scan_ldp->theta[i];
    total_scan_ldp->readings[half_nrays + i] = target_scan_ldp->readings[i];
  }

  // Fill second missing segment
  for (unsigned int i = 0; i < half_nrays; i++)
  {
    // A random number that will be used to add noise to the rays of the map
    // scan that are missing from world scan
    double rn = 0.0;
    if (operation.compare(op_icp_) == 0)
      rn = generator_icp();
    else if (operation.compare(op_dft_) == 0)
      rn = generator_dft();
    else
    {
      ROS_ERROR("[FMTGlobal Localiser] Unknown operation. Aborting ...");
      return;
    }

    total_scan_ldp->valid[half_nrays + prev_nrays + i] =
      source_scan_ldp->valid[half_nrays + prev_nrays + i];

    total_scan_ldp->theta[half_nrays + prev_nrays + i] =
      source_scan_ldp->theta[half_nrays + prev_nrays + i];

    if (source_scan_ldp->readings[half_nrays + prev_nrays + i] + rn <=
      latest_world_scan_->range_min)
    {
      total_scan_ldp->readings[half_nrays + prev_nrays + i] =
        latest_world_scan_->range_min;
    }
    else if (source_scan_ldp->readings[half_nrays + prev_nrays + i] + rn >=
      latest_world_scan_->range_max)
    {
      total_scan_ldp->readings[half_nrays + prev_nrays + i] =
        latest_world_scan_->range_max;
    }
    else
    {
      total_scan_ldp->readings[half_nrays + prev_nrays + i] =
        source_scan_ldp->readings[half_nrays + prev_nrays + i] + rn;
    }
  }

  total_scan_ldp->min_theta = total_scan_ldp->theta[0];
  total_scan_ldp->max_theta = total_scan_ldp->theta[two_pi_nrays - 1];

  total_scan_ldp->nrays = two_pi_nrays;

  copyLDP(total_scan_ldp, target_scan_ldp);

  ld_free(total_scan_ldp);
}


/*******************************************************************************
 * @brief Finds the transform between the laser frame and the base frame
 * @param[in] frame_id [const::string&] The laser's frame id
 * @return [bool] True when the transform was found, false otherwise.
 */
  bool
FMTGlobalLocalisation::getBaseToLaserTf(const std::string& frame_id)
{
  ros::Time t = ros::Time::now();

  tf::StampedTransform base_to_laser_tf;
  try
  {
    tf_listener_.waitForTransform(base_frame_, frame_id, t, ros::Duration(1.0));

    // The direction of the transform returned will be from the base_frame_
    // to the frame_id. Which if applied to data, will transform data in
    // the frame_id into the base_frame_.
    tf_listener_.lookupTransform(base_frame_, frame_id, t, base_to_laser_tf);
  }
  catch (tf::TransformException ex)
  {
    ROS_WARN("[FMTGlobal Localiser] Could not get initial transform from");
    ROS_WARN("base frame to %s: %s", frame_id.c_str(), ex.what());

    return false;
  }

  base_to_laser_ = base_to_laser_tf;
  laser_to_base_ = base_to_laser_.inverse();

  return true;
}


/*******************************************************************************
 * @brief Given the robot's pose in the map frame, this function returns the
 * laser's pose in the map frame.
 * @param[in] robot_pose [const geometry_msgs::Pose&] The robot's pose in the
 * map frame.
 * @return [geometry_msgs::Pose] The pose of the laser in the map frame.
 */
  geometry_msgs::Pose
FMTGlobalLocalisation::getCurrentLaserPose(const geometry_msgs::Pose& robot_pose)
{
  // Transform the robot_pose to a transform
  tf::Transform map_to_base_tf;
  tf::poseMsgToTF(robot_pose, map_to_base_tf);

  // Get the laser's pose in the map frame (as a transform)
  tf::Transform map_to_laser_tf = map_to_base_tf * base_to_laser_;

  // Convert the transform into a message
  geometry_msgs::Pose laser_pose;
  tf::poseTFToMsg(map_to_laser_tf, laser_pose);

  // Return the laser's pose
  return laser_pose;
}


/*******************************************************************************
 * @brief Returns the number of valid rays of a LDP scan
 * @param[in] scan [const LDP&] The input scan
 * @return [int] The number of valid rays of scan
 */
  int
FMTGlobalLocalisation::getNumberOfValidRays(const LDP& scan)
{
  int counter = 0;
  for (unsigned int i = 0; i < scan->nrays; i++)
  {
    if (scan->valid[i] == 1)
      counter++;
  }

  return counter;
}


/*******************************************************************************
 * @brief Calculates the compound velocity in (x,y,theta) from a twist message.
 * @param[in] twist_msg [const geometry_msgs::Twist&] The twist message
 * containing the linear and angular velocities of the robot
 * @return [double] The compound velocity
 */
  double
FMTGlobalLocalisation::getTotal3DVelocity(const geometry_msgs::Twist& twist_msg)
{
  return sqrt(
    twist_msg.linear.x * twist_msg.linear.x +
    twist_msg.linear.y * twist_msg.linear.y +
    twist_msg.angular.z * twist_msg.angular.z);
}


/*******************************************************************************
  */
double
FMTGlobalLocalisation::findArea(
  const std::vector< std::pair<double,double> >& polygon)
{
  double area = 0.0;

  std::vector< std::pair<double,double> > polygon_closed = polygon;
  polygon_closed.push_back(polygon[0]);

  for (int i = 0; i < polygon_closed.size()-1; i++)
  {
    area += (polygon_closed[i+1].first + polygon_closed[i].first)
          * (polygon_closed[i+1].second - polygon_closed[i].second);
  }

  return area/2;
}


/*******************************************************************************
*/
std::pair<double,double> FMTGlobalLocalisation::findCentroid(
  const std::vector< std::pair<double,double> >& polygon)
{

  double area = findArea(polygon);

  std::vector< std::pair<double,double> > polygon_closed = polygon;
  polygon_closed.push_back(polygon[0]);

  double x = 0.0;
  double y = 0.0;

  for (int i = 0; i < polygon_closed.size()-1; i++)
  {
    x += (polygon_closed[i+1].first + polygon_closed[i].first)
       * (polygon_closed[i].first * polygon_closed[i+1].second
         -polygon_closed[i+1].first * polygon_closed[i].second);

    y += (polygon_closed[i+1].second + polygon_closed[i].second)
       * (polygon_closed[i].first * polygon_closed[i+1].second
         -polygon_closed[i+1].first * polygon_closed[i].second);
  }

  return std::make_pair(x / (6*area), y / (6*area));
}


/*******************************************************************************
 * @brief This is where all the magic happens
 * @param[in] pose_msg [const geometry_msgs::Pose::Ptr&]
 * The amcl pose wrt to the map frame
 * @return void
 */
  void
FMTGlobalLocalisation::handleInputPose(const geometry_msgs::Pose::Ptr& pose_msg,
  sm_result* output, tf::Transform* f2b)
{
  // Both the laser scan and the map ought to have been received for the
  // icp to commence.
  if (!received_scan_ || !received_map_ || !received_start_signal_)
    return;

  // Construct the 3rd-party ray-casters AFTER both a scan and the map is
  // received
  received_both_scan_and_map_++;
  if (received_both_scan_and_map_ == 1)
    initRangeLibRayCasters();

  // Return if the pose received from amcl contains nan's
  if (nanInPose(pose_msg))
  {
    ROS_ERROR("[FMTGlobalLocalisation] amcl pose contains nan's; aborting ...");
    return;
  }

  // Bail if already running // GUARD
  if (running_)
  {
    ROS_ERROR("[FMTGlobalLocalisation] Already running; aborting ...");
    return;
  }

  // Set status to running to block further execution
  running_ = true;

  // ... and get a lock
  //boost::mutex::scoped_lock lock(mutex_);

  sensor_msgs::LaserScan::Ptr world_scan =
    boost::make_shared<sensor_msgs::LaserScan>(*latest_world_scan_);

  geometry_msgs::Pose::Ptr global_pose;

  // ---------------------------------------------------------------------------
  // --- ICP -------------------------------------------------------------------
  // ---------------------------------------------------------------------------
  if (do_icp_)
    doICP(pose_msg, world_scan, output, f2b);

  // ---------------------------------------------------------------------------
  // --- DFT -------------------------------------------------------------------
  // ---------------------------------------------------------------------------
  if (do_fmt_)
    doDFT(pose_msg, world_scan, output, f2b);

  // GUARD stand-down
  running_ = false;
}


/*******************************************************************************
 * @brief Initializes parameters
 * @return void
 */
  void
FMTGlobalLocalisation::initParams()
{
  if (!nh_private_.getParam ("base_frame", base_frame_))
    base_frame_ = "base_footprint";
  if (!nh_private_.getParam ("fixed_frame", fixed_frame_))
    fixed_frame_ = "map";
  if (!nh_private_.getParam ("odom_frame", odom_frame_))
    odom_frame_ = "odom";
  if (!nh_private_.getParam ("scan_topic", scan_topic_))
    scan_topic_ = "/scan";
  if (!nh_private_.getParam ("map_topic", map_topic_))
    map_topic_ = "/map";
  if (!nh_private_.getParam ("odom_topic", odom_topic_))
    odom_topic_ = "/odom";
  if (!nh_private_.getParam ("input_pose_topic", input_pose_topic_))
    input_pose_topic_ = "/amcl_pose";
  if (!nh_private_.getParam ("input_pose_cloud_topic", input_pose_cloud_topic_))
    input_pose_cloud_topic_ = "/particlecloud";
  if (!nh_private_.getParam ("start_signal_service_name",
      start_signal_service_name_))
    start_signal_service_name_ = ros::this_node::getName() + "/start_signal";

  if (!nh_private_.getParam ("global_localisation_service",
      global_localisation_service_))
    global_localisation_service_ = "/global_localization";
  if (!nh_private_.getParam ("laser_z_orientation", laser_z_orientation_))
    laser_z_orientation_ = "upwards";

  if (!nh_private_.getParam ("do_icp", do_icp_))
    do_icp_ = false;
  if (!nh_private_.getParam ("do_fmt", do_fmt_))
    do_fmt_ = false;

  // String identifiers of internal operations
  op_icp_ = "icp";
  op_dft_ = "dft";

  num_calls_global_localisation_  = 0;

  // **** How to publish the output?
  // tf (fixed_frame->base_frame),
  // pose message (pose of base frame in the fixed frame)

  if (!nh_private_.getParam ("close_loop", close_loop_))
    close_loop_ = false;

  if (!nh_private_.getParam("position_covariance", position_covariance_))
  {
    position_covariance_.resize(3);
    std::fill(position_covariance_.begin(), position_covariance_.end(), 1e-9);
  }

  if (!nh_private_.getParam("orientation_covariance", orientation_covariance_))
  {
    orientation_covariance_.resize(3);
    std::fill(orientation_covariance_.begin(), orientation_covariance_.end(), 1e-9);
  }
  // **** CSM parameters - comments copied from algos.h (by Andrea Censi)

  // Maximum angular displacement between scans
  if (!nh_private_.getParam ("max_angular_correction_deg", input_.max_angular_correction_deg))
    input_.max_angular_correction_deg = 45.0;

  // Maximum translation between scans (m)
  if (!nh_private_.getParam ("max_linear_correction", input_.max_linear_correction))
    input_.max_linear_correction = 0.50;

  // Maximum ICP cycle iterations
  if (!nh_private_.getParam ("max_iterations", input_.max_iterations))
    input_.max_iterations = 10;

  // A threshold for stopping (m)
  if (!nh_private_.getParam ("epsilon_xy", input_.epsilon_xy))
    input_.epsilon_xy = 0.000001;

  // A threshold for stopping (rad)
  if (!nh_private_.getParam ("epsilon_theta", input_.epsilon_theta))
    input_.epsilon_theta = 0.000001;

  // Maximum distance for a correspondence to be valid
  if (!nh_private_.getParam ("max_correspondence_dist", input_.max_correspondence_dist))
    input_.max_correspondence_dist = 0.3;

  // Noise in the scan (m)
  if (!nh_private_.getParam ("sigma", input_.sigma))
    input_.sigma = 0.010;

  // Use smart tricks for finding correspondences.
  if (!nh_private_.getParam ("use_corr_tricks", input_.use_corr_tricks))
    input_.use_corr_tricks = 1;

  // Restart: Restart if error is over threshold
  if (!nh_private_.getParam ("restart", input_.restart))
    input_.restart = 0;

  // Restart: Threshold for restarting
  if (!nh_private_.getParam ("restart_threshold_mean_error", input_.restart_threshold_mean_error))
    input_.restart_threshold_mean_error = 0.01;

  // Restart: displacement for restarting. (m)
  if (!nh_private_.getParam ("restart_dt", input_.restart_dt))
    input_.restart_dt = 1.0;

  // Restart: displacement for restarting. (rad)
  if (!nh_private_.getParam ("restart_dtheta", input_.restart_dtheta))
    input_.restart_dtheta = 0.1;

  // Max distance for staying in the same clustering
  if (!nh_private_.getParam ("clustering_threshold", input_.clustering_threshold))
    input_.clustering_threshold = 0.25;

  // Number of neighbour rays used to estimate the orientation
  if (!nh_private_.getParam ("orientation_neighbourhood", input_.orientation_neighbourhood))
    input_.orientation_neighbourhood = 20;

  // If 0, it's vanilla ICP
  if (!nh_private_.getParam ("use_point_to_line_distance", input_.use_point_to_line_distance))
    input_.use_point_to_line_distance = 1;

  // Discard correspondences based on the angles
  if (!nh_private_.getParam ("do_alpha_test", input_.do_alpha_test))
    input_.do_alpha_test = 0;

  // Discard correspondences based on the angles - threshold angle, in degrees
  if (!nh_private_.getParam ("do_alpha_test_thresholdDeg", input_.do_alpha_test_thresholdDeg))
    input_.do_alpha_test_thresholdDeg = 20.0;

  // Percentage of correspondences to consider: if 0.9,
  // always discard the top 10% of correspondences with more error
  if (!nh_private_.getParam ("outliers_maxPerc", input_.outliers_maxPerc))
    input_.outliers_maxPerc = 0.90;

  // Parameters describing a simple adaptive algorithm for discarding.
  //  1) Order the errors.
  //  2) Choose the percentile according to outliers_adaptive_order.
  //     (if it is 0.7, get the 70% percentile)
  //  3) Define an adaptive threshold multiplying outliers_adaptive_mult
  //     with the value of the error at the chosen percentile.
  //  4) Discard correspondences over the threshold.
  //  This is useful to be conservative; yet remove the biggest errors.
  if (!nh_private_.getParam ("outliers_adaptive_order", input_.outliers_adaptive_order))
    input_.outliers_adaptive_order = 0.7;

  if (!nh_private_.getParam ("outliers_adaptive_mult", input_.outliers_adaptive_mult))
    input_.outliers_adaptive_mult = 2.0;

  // If you already have a guess of the solution, you can compute the polar angle
  // of the points of one scan in the new position. If the polar angle is not a monotone
  // function of the readings index, it means that the surface is not visible in the
  // next position. If it is not visible, then we don't use it for matching.
  if (!nh_private_.getParam ("do_visibility_test", input_.do_visibility_test))
    input_.do_visibility_test = 0;

  // no two points in laser_sens can have the same corr.
  if (!nh_private_.getParam ("outliers_remove_doubles", input_.outliers_remove_doubles))
    input_.outliers_remove_doubles = 1;

  // If 1, computes the covariance of ICP using the method http://purl.org/censi/2006/icpcov
  if (!nh_private_.getParam ("do_compute_covariance", input_.do_compute_covariance))
    input_.do_compute_covariance = 0;

  // Checks that find_correspondences_tricks gives the right answer
  if (!nh_private_.getParam ("debug_verify_tricks", input_.debug_verify_tricks))
    input_.debug_verify_tricks = 0;

  // If 1, the field 'true_alpha' (or 'alpha') in the first scan is used to compute the
  // incidence beta, and the factor (1/cos^2(beta)) used to weight the correspondence.");
  if (!nh_private_.getParam ("use_ml_weights", input_.use_ml_weights))
    input_.use_ml_weights = 0;

  // If 1, the field 'readings_sigma' in the second scan is used to weight the
  // correspondence by 1/sigma^2
  if (!nh_private_.getParam ("use_sigma_weights", input_.use_sigma_weights))
    input_.use_sigma_weights = 0;

  if (!nh_private_.getParam ("gpm_theta_bin_size_deg", input_.gpm_theta_bin_size_deg))
    input_.gpm_theta_bin_size_deg = 5;
  if (!nh_private_.getParam ("gpm_extend_range_deg", input_.gpm_extend_range_deg))
    input_.gpm_extend_range_deg = 15;
  if (!nh_private_.getParam ("gpm_interval", input_.gpm_interval))
    input_.gpm_interval = 1;


  // *** parameters introduced by us

  if (!nh_private_.getParam ("initial_cov_xx", initial_cov_xx_))
    initial_cov_xx_ = 0.05;
  if (!nh_private_.getParam ("initial_cov_yy", initial_cov_yy_))
    initial_cov_yy_ = 0.05;
  if (!nh_private_.getParam ("initial_cov_aa", initial_cov_aa_))
    initial_cov_aa_ = 0.06854;

  if (!nh_private_.getParam("map_png_file", map_png_file_))
    map_png_file_ = "";

  if (!nh_private_.getParam("feedback_particle_topic", feedback_particle_topic_))
    feedback_particle_topic_ = "particle_introduction";

  if (!nh_private_.getParam("map_scan_theta_disc", map_scan_theta_disc_))
    map_scan_theta_disc_ = 720;

  if (!nh_private_.getParam("icp_iterations", icp_iterations_))
    icp_iterations_ = 1;

  if (!nh_private_.getParam("icp_incorporate_orientation_only", icp_incorporate_orientation_only_))
    icp_incorporate_orientation_only_ = true;

  if (!nh_private_.getParam("icp_map_scan_method", icp_map_scan_method_))
    icp_map_scan_method_ = "vanilla";

  // Fill map for more information on matching
  if (!nh_private_.getParam("icp_visual_debug", icp_visual_debug_))
    icp_visual_debug_ = false;

  if (!nh_private_.getParam("icp_do_fill_map_scan", icp_do_fill_map_scan_))
    icp_do_fill_map_scan_ = false;

  if (!nh_private_.getParam("icp_scan_undersample_rate", icp_scan_undersample_rate_))
    icp_scan_undersample_rate_ = 1;

  if (!nh_private_.getParam("dft_scan_undersample_rate", dft_scan_undersample_rate_))
    dft_scan_undersample_rate_ = 1;

  if (!nh_private_.getParam("icp_do_clip_scans", icp_do_clip_scans_))
    icp_do_clip_scans_ = false;

  if (!nh_private_.getParam("icp_clip_sill", icp_clip_sill_))
    icp_clip_sill_ = 100.0;

  if (!nh_private_.getParam("icp_clip_lintel", icp_clip_lintel_))
    icp_clip_lintel_ = 0.0;

  if (!nh_private_.getParam("icp_fill_mean_value", icp_fill_mean_value_))
    icp_fill_mean_value_ = 0.0;

  if (!nh_private_.getParam("icp_fill_std_value", icp_fill_std_value_))
    icp_fill_std_value_ = 0.01;

  if (!nh_private_.getParam("icp_do_invalidate_diff_rays", icp_do_invalidate_diff_rays_))
    icp_do_invalidate_diff_rays_ = false;

  if (!nh_private_.getParam("icp_invalidate_diff_rays_epsilon", icp_invalidate_diff_rays_epsilon_))
    icp_invalidate_diff_rays_epsilon_ = false;

  if (!nh_private_.getParam("icp_do_publish_scans", icp_do_publish_scans_))
    icp_do_publish_scans_ = false;

  if (!nh_private_.getParam("dft_iterations", dft_iterations_))
    dft_iterations_ = 1;

  if (!nh_private_.getParam("dft_do_fill_map_scan", dft_do_fill_map_scan_))
    dft_do_fill_map_scan_ = false;

  if (!nh_private_.getParam("dft_map_scan_method", dft_map_scan_method_))
    dft_map_scan_method_ = "vanilla";

  if (!nh_private_.getParam("dft_do_publish_scans", dft_do_publish_scans_))
    dft_do_publish_scans_ = false;

  if (!nh_private_.getParam("dft_min_valid_rays", dft_min_valid_rays_))
    dft_min_valid_rays_ = 0;

  if (!nh_private_.getParam("dft_fill_mean_value", dft_fill_mean_value_))
    dft_fill_mean_value_ = 0.0;

  if (!nh_private_.getParam("dft_fill_std_value", dft_fill_std_value_))
    dft_fill_std_value_ = 0.00;

  if (!nh_private_.getParam("dft_image_size", dft_image_size_))
    dft_image_size_ = 512;

  if (!nh_private_.getParam("dft_image_format", dft_image_format_))
    dft_image_format_ = ".png";

  // Invalidate rays between world and map scans. For rays of equal index,
  // if their range is more than do_invalidate_diff_rays_epsilon, then they will be
  // considered invalid by the scan matcher.
  if (!nh_private_.getParam("dft_do_invalidate_diff_rays", dft_do_invalidate_diff_rays_))
    dft_do_invalidate_diff_rays_ = false;

  if (!nh_private_.getParam("dft_invalidate_diff_rays_epsilon", dft_invalidate_diff_rays_epsilon_))
    dft_invalidate_diff_rays_epsilon_ = 0.05;
}


/*******************************************************************************
 * @brief Invalidates a LDP scan's rays. If these are above or below certain
 * thresholds, then the `valid` field of their LDP is marked with 0.
 * @param[in,out] scan [LDP&] The input scan.
 * @param[in] lintel [const double&] The threshold under which rays will be
 * invalidated.
 * @param[in] sill [const double&] The threshold over which rays will be
 * invalidated.
 */
  void
FMTGlobalLocalisation::invalidateByClippingScan(
  LDP& scan,
  const double& lintel,
  const double& sill)
{
  for (unsigned int i = 0; i < scan->nrays; i++)
  {
    if ( scan->readings[i] > sill )
      scan->valid[i] = 0;

    if ( scan->readings[i] < lintel )
      scan->valid[i] = 0;
  }
}


/*******************************************************************************
 * @brief Initialises the ray-casters from the RangeLib library. Since they
 * take as arguments the maximum range of the lidar and the resolution of the
 * map, and these are unknown before being received, this function should be
 * called ONCE, exactly after the first scan and the map are received.
 * @param void
 * @return void
 */
void FMTGlobalLocalisation::initRangeLibRayCasters()
{
  // Max laser range in pixels
  float max_range_rc = latest_world_scan_->range_max / map_.info.resolution;

  // Init ray-casters
  if (icp_map_scan_method_.compare("bresenham") == 0 ||
    dft_map_scan_method_.compare("bresenham") == 0)
  {
    br_ = ranges::BresenhamsLine(omap_, max_range_rc);
    rot_br_ = ranges_rot::BresenhamsLine(omap_rot_, max_range_rc);
  }

  if (icp_map_scan_method_.compare("ray_marching") == 0 ||
    dft_map_scan_method_.compare("ray_marching") == 0)
  {
    rm_ = ranges::RayMarching(omap_, max_range_rc);
    rot_rm_ = ranges_rot::RayMarching(omap_rot_, max_range_rc);
  }

  if (icp_map_scan_method_.compare("cddt") == 0 ||
    dft_map_scan_method_.compare("cddt") == 0)
  {
    cddt_ = ranges::CDDTCast(omap_, max_range_rc, map_scan_theta_disc_);
    rot_cddt_ = ranges_rot::CDDTCast(omap_rot_, max_range_rc, map_scan_theta_disc_);
  }
}


/*******************************************************************************
 * @brief Invalidates a world and a map scan by clipping them above and below.
 * @param[in,out] world_scan [LDP&] A world scan in LDP form
 * @param[in,out] map_scan [LDP&] A map scan in LDP form
 * @param[in] lintel [const double&] The threshold under which rays will be
 * invalidated.
 * @param[in] sill [const double&] The threshold over which rays will be
 * invalidated.
 * @return void
 */
  void
FMTGlobalLocalisation::invalidateByClippingScans(
  LDP& world_scan,
  LDP& map_scan,
  const double& lintel,
  const double& sill)
{
  invalidateByClippingScan(world_scan, lintel, sill);
  invalidateByClippingScan(map_scan, lintel, sill);
}


/*******************************************************************************
 * @brief Invalidates scans by checking the difference between their rays and
 * a known threshold, based on the origin operation.
 * @param[in] scan_1 [LDP&] A LDP scan (should be a world scan)
 * @param[in] scan_2 [LDP&] A LDP scan (should be a map scan)
 * @param[in] threshold [const double&] A threshold over which the difference
 * between rays of scan_1 and scan_2 will invalidate said rays if operation
 * is equal to "dft". If operation is equal to "icp", this function invalidates
 * the rays of scan_2 over [min_angle, max_angle] and those of scan_1 if
 * additionally scan_1 is to be filled.
 * @param[in] operation [const std::string&] The origin operation. Available
 * values are "icp" or "dft".
 * @return void
 */
  void
FMTGlobalLocalisation::invalidateDiffRays(
  LDP& scan_1,
  LDP& scan_2,
  const double& threshold,
  const std::string& operation)
{
  if (scan_1->nrays != scan_2->nrays)
  {
    ROS_ERROR("[FMTGlobal Localiser] diff rays invalidation impossible");
    return;
  }

  // If DFT: invalidate both rays as what is meaningful is the value of the
  // difference of the rays of two scans, and therefore it makes more sense to
  // invalidate both
  if (operation.compare(op_dft_) == 0)
  {
    double angle_min = latest_world_scan_->angle_min;
    double angle_max = latest_world_scan_->angle_max;

    // angle_low is the angle from which rays are going to be invalidated
    // if dft_do_fill_map_scan_ is false; angle_high is the angle until which
    // this is going to happen
    double angle_low = angle_max + M_PI;
    double angle_high = angle_min + M_PI;

    // wrap them in [-π,π]
    wrapAngle(angle_low);
    wrapAngle(angle_high);

    for (unsigned int i = 0; i < scan_1->nrays; i++)
    {
      // If the map is not to be filled (this is reasonable now -- it may be the
      // case that the fake rear laser measurements do not help as much as we
      // would wish they would) then invalidate portion of the scan on the front
      // side.
      if (dft_do_fill_map_scan_)
      {
        if ((scan_1->theta[i] >= angle_low && scan_1->theta[i] <= angle_high) ||
          (scan_1->theta[i] <= latest_world_scan_->angle_min &&
           scan_1->theta[i] >= -M_PI) ||
          (scan_1->theta[i] >= latest_world_scan_->angle_max &&
           scan_1->theta[i] <= M_PI))
        {
          scan_1->valid[i] = 0;
          scan_2->valid[i] = 0;
        }
      }

      if (scan_1->valid[i] && scan_2->valid[i])
      {
        if ( fabs(scan_1->readings[i] - scan_2->readings[i]) >= threshold )
        {
          scan_1->valid[i] = 0;
          scan_2->valid[i] = 0;
        }
      }
    }
  }
  else if (operation.compare(op_icp_) == 0)
  {
    if (!icp_do_fill_map_scan_)
    {
      for (unsigned int i = 0; i < scan_1->nrays; i++)
      {
        if (scan_1->valid[i] && scan_2->valid[i])
        {
          if ( fabs(scan_1->readings[i] - scan_2->readings[i]) >= threshold )
          {
            scan_1->valid[i] = 0;
            scan_2->valid[i] = 0;
          }
        }
      }
    }
    else
    {
      int original_size = latest_world_scan_->ranges.size();
      int new_size = scan_1->nrays;
      int added_rays = new_size - original_size;
      int half_rays = added_rays / 2;

      // Invalidate first filled-in segment; the world scan rays are invalidated
      for (unsigned int i = 0; i < half_rays; i++)
      {
        if (scan_1->valid[i] && scan_2->valid[i])
        {
          if ( fabs(scan_1->readings[i] - scan_2->readings[i]) >= threshold )
            scan_1->valid[i] = 0;
        }
      }

      // Invalidate the non-filled in segment; the map scan rays are invalidated
      for (unsigned int i = half_rays; i < new_size - half_rays; i++)
      {
        if (scan_1->valid[i] && scan_2->valid[i])
        {
          if ( fabs(scan_1->readings[i] - scan_2->readings[i]) >= threshold )
          {
            scan_1->valid[i] = 0;
            scan_2->valid[i] = 0;
          }
        }
      }

      // Invalidate second filled-in segment; the world scan rays are invalidated
      for (unsigned int i = new_size - half_rays; i < new_size; i++)
      {
        if (scan_1->valid[i] && scan_2->valid[i])
        {
          if ( fabs(scan_1->readings[i] - scan_2->readings[i]) >= threshold )
            scan_1->valid[i] = 0;
        }
      }
    }
  }
  else
    ROS_ERROR("[FMTGlobal Localiser] Invalid operation during invalidation");
}


/*******************************************************************************
 * @brief Converts a LaserScan laser scan to a LDP structure.
 * @param[in] scan_msg [const sensor_msgs::LaserScan::Ptr&] The input scan
 * @param[out] ldp [LDP&] The output LDP scan
 * @return void
 */
  void
FMTGlobalLocalisation::laserScanToLDP(
  const sensor_msgs::LaserScan::Ptr& scan_msg,
  LDP& ldp)
{
  unsigned int n = scan_msg->ranges.size();
  ldp = ld_alloc_new(n);

  float min_range = scan_msg->range_min;
  float max_range = scan_msg->range_max;
  float angle_min = scan_msg->angle_min;
  float angle_inc = scan_msg->angle_increment;

  for (unsigned int i = 0; i < n; i++)
  {
    double r = scan_msg->ranges[i];

    if (std::isfinite(r))
    {
      if (r >= min_range && r <= max_range)
        ldp->readings[i] = r;
      else if (r < min_range)
        ldp->readings[i] = min_range;
      else if (r > max_range)
        ldp->readings[i] = max_range;

      ldp->valid[i] = 1;
    }
    else
    {
      ldp->readings[i] = max_range;  // for invalid range
      ldp->valid[i] = 1;
      //ldp->readings[i] = -1;  // for invalid range
      //ldp->valid[i] = 0;
      //ROS_WARN("[FMTGlobal Localiser] Detected nan in input laser scan, beware");
    }

    ldp->cluster[i] = -1;
    ldp->theta[i] = angle_min + i * angle_inc;
  }

  ldp->min_theta = ldp->theta[0];
  ldp->max_theta = ldp->theta[n-1];

  ldp->odometry[0] = 0.0;
  ldp->odometry[1] = 0.0;
  ldp->odometry[2] = 0.0;

  ldp->true_pose[0] = 0.0;
  ldp->true_pose[1] = 0.0;
  ldp->true_pose[2] = 0.0;
}

/*******************************************************************************
*/
  void
FMTGlobalLocalisation::ldp2points(
  const LDP& scan,
  const std::tuple<double,double,double> pose,
  std::vector< std::pair<double,double> >* points)
{
  points->clear();

  double px = std::get<0>(pose);
  double py = std::get<1>(pose);
  double pt = std::get<2>(pose);

  double angle_min = scan->min_theta;
  double angle_span = scan->max_theta-scan->min_theta;
  int n = scan->nrays;

  for (int i = 0; i < n; i++)
  {
    double x =
      px + scan->readings[i] * cos(i * angle_span/n + pt + angle_min);
    double y =
      py + scan->readings[i] * sin(i * angle_span/n + pt + angle_min);

    points->push_back(std::make_pair(x,y));
  }
}



/*******************************************************************************
 * @brief Converts a LDP structure to a LaserScan laser scan
 * @param[in] ldp [const LDP&] The input LDP laser scan
 * @return [sensor_msgs::LaserScan::Ptr] The output LaserScan laser scan
 */
  sensor_msgs::LaserScan::Ptr
FMTGlobalLocalisation::ldpTolaserScan(const LDP& ldp)
{
  sensor_msgs::LaserScan::Ptr laser_scan =
    boost::make_shared<sensor_msgs::LaserScan>(*latest_world_scan_);

  laser_scan->angle_min = ldp->min_theta;
  laser_scan->angle_max = ldp->max_theta;

  unsigned int n = ldp->nrays;

  laser_scan->angle_increment =
    (laser_scan->angle_max - laser_scan->angle_min) / n;

  laser_scan->ranges.resize(n);

  for (unsigned int i = 0; i < n; i++)
  {
    if (ldp->valid[i] == 1)
      laser_scan->ranges[i] = ldp->readings[i];
    else
      laser_scan->ranges[i] = 0.0;
  }

  return laser_scan;
}


/*******************************************************************************
 * @brief Stores the map upon receipt. (The map does not change through time)
 * @param[in] map_msg [const nav_msgs::OccupancyGrid] The map
 * @return void
 */
  void
FMTGlobalLocalisation::mapCallback(const nav_msgs::OccupancyGrid& map_msg)
{
  map_ = map_msg;
  received_map_ = true;

  if (received_scan_ && received_pose_cloud_ && received_start_signal_)
    processPoseCloud();
}


/*******************************************************************************
 * @brief Publishes the pipeline's latest execution time.
 * @param[in] start [const ros::Time&] The start time of the pipeline's
 * execution
 * @param[in] end [const ros::Time&] The end time of the pipeline's execution
 */
  void
FMTGlobalLocalisation::measureExecutionTime(
  const ros::Time& start,
  const ros::Time& end)
{
  ros::Duration d = end-start;
  std_msgs::Duration duration_msg;
  duration_msg.data = d;
  execution_time_publisher_.publish(duration_msg);
}


/*******************************************************************************
 * @brief Checks if there are nan's in an input pose.
 * @param[in] pose_msg [const geometry_msgs::Pose::Ptr&]
 * The input pose
 * @return [bool] True if there is at least one nan in the input_pose, false
 * otherwise.
 */
  bool
FMTGlobalLocalisation::nanInPose(
  const geometry_msgs::Pose::Ptr& pose_msg)
{
  if (std::isnan(pose_msg->position.x) ||
    std::isnan(pose_msg->position.y) ||
    std::isnan(pose_msg->orientation.z) ||
    std::isnan(pose_msg->orientation.w))
    return true;
  else
    return false;
}


/*******************************************************************************
 * @brief Returns the number of rays that correspond to an angle range
 * based on known values of minimum and maximum angle, and the number of rays
 * that correspond to them.
 * @param[in] angle_min [const double&] The minimum angle
 * @param[in] angle_max [const double&] The maximum angle
 * @param[in] num_rays [const int&] The number of rays that correspond to the
 * interval [angle_min, angle_max]
 * @param[in] new_range [const double&] The angle range over which we seek the
 * number of rays
 * @return [int] The number of rays corresponding to new_range
 */
  int
FMTGlobalLocalisation::numRaysFromAngleRange(
  const double& angle_min,
  const double& angle_max,
  const int& num_rays,
  const double& new_range)
{
  double v = num_rays * new_range / (angle_max - angle_min);
  int v_int = static_cast<int>(v);

  // We shall return an even number of rays either way
  if (v_int % 2 == 0)
    return v;
  else
    return ceil(v);
}

void FMTGlobalLocalisation::local_exit(int){}

/*******************************************************************************
https://lists.gnu.org/archive/html/help-octave/2009-04/msg00005.html
*/
void FMTGlobalLocalisation::plotWithOctave()
{
  // The two lines below were moved in the constructor because insuppressible
  // warnings were issued
  //const char * argvv [] = {"embedded", "--silent"};
  //octave_main (2, (char **) argvv, 1);

  octave_value_list full_path;

  full_path(0) =
    "/home/li9i/catkin_ws/src/relief_fmt_global_localisation/tmp/";
  feval("addpath", full_path);

  octave_value_list functionArguments;
  functionArguments(0) = dft_image_size_;
  functionArguments(1) = dft_image_format_;

  const octave_value_list result =
    feval ("create_range_images", functionArguments);

  //clean_up_and_exit (0);
  void (*octave_exit) (int) = local_exit;
}

/*******************************************************************************
*/
void FMTGlobalLocalisation::plotRealScanImage()
{
  // The two lines below were moved in the constructor because insuppressible
  // warnings were issued
  //const char * argvv [] = {"embedded", "--silent"};
  //octave_main (2, (char **) argvv, 1);

  octave_value_list full_path;

  full_path(0) =
    "/home/li9i/catkin_ws/src/relief_fmt_global_localisation/tmp/";
  feval("addpath", full_path);

  octave_value_list functionArguments;
  functionArguments(0) = dft_image_size_;
  functionArguments(1) = dft_image_format_;

  const octave_value_list result =
    feval ("create_real_range_image", functionArguments);

  //clean_up_and_exit (0);
  //void (*octave_exit) (int) = local_exit;
}

/*******************************************************************************
*/
void FMTGlobalLocalisation::plotVirtualScanImage()
{
  // The two lines below were moved in the constructor because insuppressible
  // warnings were issued
  //const char * argvv [] = {"embedded", "--silent"};
  //octave_main (2, (char **) argvv, 1);

  octave_value_list full_path;

  full_path(0) =
    "/home/li9i/catkin_ws/src/relief_fmt_global_localisation/tmp/";
  feval("addpath", full_path);

  octave_value_list functionArguments;
  functionArguments(0) = dft_image_size_;
  functionArguments(1) = dft_image_format_;

  const octave_value_list result =
    feval ("create_virtual_range_image", functionArguments);

  //clean_up_and_exit (0);
  //void (*octave_exit) (int) = local_exit;
}

/*******************************************************************************
 * @brief The amcl pose callback. This is the point of entry to the pipeline
 * operation
 * @param[in] pose_msg [const geometry_msgs::PoseWithCovarianceStamped::Ptr&]
 * The amcl pose wrt to the map frame
 * @return void
 */
void
FMTGlobalLocalisation::poseCallback(
  const geometry_msgs::PoseWithCovarianceStamped::Ptr& pose_msg) {}

/*******************************************************************************
 * @brief The amcl cloud pose callback. This is the point of entry
 * @param[in] pose_cloud_msg [const geometry_msgs::PoseArray::Ptr&]
 * The amcl pose wrt to the map frame
 * @return void
 */
  void
FMTGlobalLocalisation::poseCloudCallback(
  const geometry_msgs::PoseArray::Ptr& pose_cloud_msg)
{
  if (!received_start_signal_)
    return;

  num_calls_global_localisation_++;

  if (num_calls_global_localisation_ > 1)
    return;

  received_pose_cloud_ = true;

  // Store all the filter's particles
  dispersed_particles_.clear();

  // Push back all particles from amcl
  for (int i = 0; i < pose_cloud_msg->poses.size(); i++)
  {
    geometry_msgs::Pose::Ptr pose_i =
      boost::make_shared<geometry_msgs::Pose>(pose_cloud_msg->poses[i]);

    dispersed_particles_.push_back(pose_i);
  }

  // Store a rigged particle to test actual accuracy; the particle below
  // resides exactly where the robot is posed at
  /*
  geometry_msgs::Pose::Ptr pose_rigged =
    boost::make_shared<geometry_msgs::Pose>(pose_cloud_msg->poses[0]);
  pose_rigged->position.x = 2.613582;
  pose_rigged->position.y = 20.422026;
  tf::Quaternion q;
  q.setRPY(0.0, 0.0, -2.6);
  q.normalize();
  tf::quaternionTFToMsg(q, pose_rigged->orientation);

  dispersed_particles_.push_back(pose_rigged);
  */

  ROS_INFO("[FMTGlobalLocalisation] There are %zu particles in total",
    dispersed_particles_.size());


  // Process cloud if all other conditions are satisfied
  if (received_scan_ && received_map_ && received_start_signal_)
    processPoseCloud();
}


/*******************************************************************************
 * @brief Processes two scans (a world scan and a map scan) in LDP form prior
 * to the DFT operation.
 * @param[in,out] scan_1 [LDP&] The world scan
 * @param[in,out] scan_2 [LDP&] The map scan
 * @return [void]
 */
  void
FMTGlobalLocalisation::preprocessDFTScans(LDP& scan_1, LDP& scan_2)
{
  // Fill in the rest of the 360 - (max_theta - min_theta) angles with fake
  // values for the sake of completing 2π, which is needed for the fourier
  // transform that follows
  if (dft_do_fill_map_scan_)
    fillLaserScanLDP(scan_2, scan_1, op_dft_);

  // Undersample range scans
  if (dft_scan_undersample_rate_ > 1)
    undersampleLDPScans(scan_1, scan_2, dft_scan_undersample_rate_);

  // Discard rays for which ||scan_1(i) - scan_2(i)|| >= ε applies
  if (dft_do_invalidate_diff_rays_)
    invalidateDiffRays(scan_1, scan_2,
      dft_invalidate_diff_rays_epsilon_, op_dft_);
}


/*******************************************************************************
 * @brief Processes two scans (a world scan and a map scan) in LDP form prior
 * to the ICP operation.
 * @param[in,out] scan_1 [LDP&] The world scan
 * @param[in,out] scan_2 [LDP&] The map scan
 * return void
 */
  void
FMTGlobalLocalisation::preprocessICPScans(LDP& scan_1, LDP& scan_2)
{
  // If the map scan is over 2π, then fill the world scan as well, so that
  // invalidation of different scan rays is possible
  if (icp_do_fill_map_scan_)
    fillLaserScanLDP(scan_2, scan_1, op_icp_);

  // Only incorporate measurements whose range is lower than icp_clip_sill_
  // and higher than icp_clip_lintel_
  if (icp_do_clip_scans_)
    invalidateByClippingScans(scan_1, scan_2,
      icp_clip_lintel_, icp_clip_sill_);

  // Undersample range scans
  if (icp_scan_undersample_rate_ > 1)
    undersampleLDPScans(scan_1, scan_2, icp_scan_undersample_rate_);

  // Invalidate diff rays
  if (icp_do_invalidate_diff_rays_)
    invalidateDiffRays(scan_1, scan_2,
      icp_invalidate_diff_rays_epsilon_, op_icp_);
}

/*******************************************************************************
 * @brief
 * @return void
 */
void FMTGlobalLocalisation::processPoseCloud()
{
  ros::Time start = ros::Time::now();

  std::vector<sm_result> outputs;
  std::vector<tf::Transform> f2bs;
  double score = -1.0;
  double score_i = -1.0;
  int score_idx = -1;
  for (int i = 0; i < dispersed_particles_.size(); i++)
  {
    ROS_INFO(
      "[FMTGlobalLocalisation] Processing particle %d: (x,y,t) = (%f,%f,%f)",
      i, dispersed_particles_[i]->position.x,
      dispersed_particles_[i]->position.y,
      extractYawFromPose(*dispersed_particles_[i]));

    sm_result output;
    tf::Transform f2b;
    handleInputPose(dispersed_particles_[i], &output, &f2b);

    outputs.push_back(output);
    f2bs.push_back(f2b);

    if (do_icp_)
    {
      score_i = output.valid * output.nvalid / fabs(output.error);
      if (score_i > score)
      {
        score = score_i;
        score_idx = i;
      }
    }

    if (do_fmt_)
    {
      // output.error is actually the `success` returned from imreg_dft.py
      score_i = output.valid * output.error;
      if (score_i > score)
      {
        score = score_i;
        score_idx = i;
      }
    }
  }

  ROS_INFO("---------------------");
  ROS_INFO("Best particle id = %d", score_idx);
  ROS_INFO("---------------------");

  // At this point what we have identified is the particle from whose pose
  // the virtual laser scan once transformed has the best match to
  // the input scan
  geometry_msgs::Pose::Ptr global_pose = dispersed_particles_[score_idx];

  if (outputs[score_idx].valid == 1)
  {
    if (do_icp_)
      correctICPPose(global_pose, f2bs[score_idx]);

    if (do_fmt_)
      correctDFTPose(global_pose, f2bs[score_idx]);

    ROS_INFO("Pose found: (%f,%f,%f)",
      global_pose->position.x,
      global_pose->position.y,
      extractYawFromPose(*global_pose));
  }
  else
  {
    ROS_ERROR("[FMTGlobal Localiser] No valid pose found");
    return;
  }

  // Publish execution time
  measureExecutionTime(start, ros::Time::now());

  // Publish global pose
  geometry_msgs::PoseWithCovarianceStamped global_pose_wcs;
  global_pose_wcs.pose.pose = *global_pose;

  boost::array<double,36> covar;
  covar[6*0+0] = initial_cov_xx_;
  covar[6*1+1] = initial_cov_yy_;
  covar[6*5+5] = initial_cov_aa_;
  global_pose_wcs.pose.covariance =  covar;
  global_pose_wcs.header.stamp = ros::Time::now();
  global_pose_wcs.header.frame_id = "/map";
  global_pose_publisher_.publish(global_pose_wcs);

  // Publish the number of particles
  std_msgs::UInt64 np_msg;
  np_msg.data = dispersed_particles_.size();
  num_particles_publisher_.publish(np_msg);

  // Publish the image size and format
  if (do_fmt_)
  {
    std_msgs::UInt64 is_msg;
    is_msg.data = dft_image_size_;
    image_size_publisher_.publish(is_msg);

    std_msgs::String if_msg;
    if_msg.data = dft_image_format_;
    image_format_publisher_.publish(if_msg);
  }

  // Close the loop: feed the corrected pose to the amcl as its initial pose:
  if (close_loop_)
    closeLoop(global_pose_wcs);

  if (do_fmt_)
    clean_up_and_exit (0);
}


/*******************************************************************************
 * @brief The champion function of the ICP operation.
 * @param[in] world_scan_ldp [LDP&] The world scan in LDP form.
 * @param[in] map_scan_ldp [LDP&] The map scan in LDP form.
 * @return void
 */
  void
FMTGlobalLocalisation::processScan(LDP& world_scan_ldp, LDP& map_scan_ldp,
  sm_result* output, tf::Transform* f2b)
{
  ros::WallTime start = ros::WallTime::now();

  // CSM is used in the following way:
  // The scans are always in the laser frame
  // The reference scan (prevLDPcan_) has a pose of [0, 0, 0]
  // The new scan (currLDPScan) has a pose equal to the movement
  // of the laser in the laser frame since the last scan
  // The computed correction is then propagated using the tf machinery

  map_scan_ldp->odometry[0] = 0.0;
  map_scan_ldp->odometry[1] = 0.0;
  map_scan_ldp->odometry[2] = 0.0;

  map_scan_ldp->estimate[0] = 0.0;
  map_scan_ldp->estimate[1] = 0.0;
  map_scan_ldp->estimate[2] = 0.0;

  map_scan_ldp->true_pose[0] = 0.0;
  map_scan_ldp->true_pose[1] = 0.0;
  map_scan_ldp->true_pose[2] = 0.0;

  input_.laser_ref  = map_scan_ldp;
  input_.laser_sens = world_scan_ldp;

  input_.first_guess[0] = 0.0;
  input_.first_guess[1] = 0.0;
  input_.first_guess[2] = 0.0;

  // If they are non-Null, free covariance gsl matrices to avoid leaking memory
  if (output_.cov_x_m)
  {
    gsl_matrix_free(output_.cov_x_m);
    output_.cov_x_m = 0;
  }
  if (output_.dx_dy1_m)
  {
    gsl_matrix_free(output_.dx_dy1_m);
    output_.dx_dy1_m = 0;
  }
  if (output_.dx_dy2_m)
  {
    gsl_matrix_free(output_.dx_dy2_m);
    output_.dx_dy2_m = 0;
  }

  // *** scan match - using point to line icp from CSM

  sm_icp(&input_, &output_);

  // https://github.com/AndreaCensi/csm/blob/master/sm/csm/algos.h#L138
  if (output_.valid)
  {
    // the correction of the laser's position, in the laser frame
    tf::Transform corr_ch_l;
    createTfFromXYTheta(output_.x[0], output_.x[1], output_.x[2], corr_ch_l);

    // the correction of the base's position, in the base frame
    f2b_ = base_to_laser_ * corr_ch_l * laser_to_base_;
  }
  else
  {
    f2b_.setIdentity();
    ROS_WARN("[FMTGlobal Localiser] Error in scan matching");
  }

  *output = output_;
  *f2b = f2b_;

  // **** statistics

  double dur = (ros::WallTime::now() - start).toSec() * 1e3;
  ROS_DEBUG("[FMTGlobal Localiser] Scan matcher total duration: %.1f ms", dur);
}


/*******************************************************************************
 * @brief Calculate the distance between the endpoints of two rays whose
 * in-between angle has a cosine equal to `cos_angle`
 * @param[in] r1 [const  double&] The first laser range distance
 * @param[in] r2 [const  double&] The second laser range distance
 * @param[in] cos_angle [const  double&] The cosine of the angle between r1
 * and r2
 * @return [double] The distance between the endpoints of r1 and r2
 */
  double
FMTGlobalLocalisation::raysEndpointDistance(
  const double& r1,
  const double& r2,
  const double& cos_angle)
{
  return sqrt(r1*r1 + r2*r2 - 2*r1*r2*cos_angle);
}


/*******************************************************************************
 * @brief Transforms a single ray from a range scan into a point in the
 * laser_pose's frame of reference.
 * @param[in] laser_pose [const geometry_msgs::Pose&] The pose of the laser in
 * the map frame.
 * @param[in] scan [const sensor_msgs::LaserScan::Ptr&] The input scan
 * @param[in] ray_id [const int&] The index of the ray within the input scan
 * ranges structure.
 * @return [std::pair<double,double>] The ray as a point (x,y)
 */
  std::pair<double,double>
FMTGlobalLocalisation::rayToPoint(
  const geometry_msgs::Pose& laser_pose,
  const sensor_msgs::LaserScan::Ptr& scan,
  const int& ray_id)
{
  // Extract yaw from pose
  double yaw = extractYawFromPose(laser_pose);

  // Calculate the position of end-point of the ray
  double r_x = laser_pose.position.x + scan->ranges[ray_id] *
    cos(yaw + (scan->angle_min + ray_id * scan->angle_increment));
  double r_y = laser_pose.position.y + scan->ranges[ray_id] *
    sin(yaw + (scan->angle_min + ray_id * scan->angle_increment));

  // Return point
  std::pair<double,double> p(r_x,r_y);
  return p;
}

/*******************************************************************************
*/
void FMTGlobalLocalisation::rotate(
  geometry_msgs::Pose::Ptr pose,
  const double& angle)
{
  tf::Quaternion q1(
    pose->orientation.x,
    pose->orientation.y,
    pose->orientation.z,
    pose->orientation.w);

  tf::Matrix3x3 mat(q1);
  double roll, pitch, yaw;
  mat.getRPY(roll, pitch, yaw);

  yaw -= angle;

  tf::Quaternion q2;
  q2.setRPY(roll, pitch, yaw);
  q2.normalize();
  tf::quaternionTFToMsg(q2, pose->orientation);

/*
  ROS_ERROR("rotate reporting pose (t should be nearly zero)");
  ROS_ERROR("(%f,%f,%f)",
    pose->position.x, pose->position.y, extractYawFromPose(*pose));
*/
}

/*******************************************************************************
 * @brief The laser scan callback
 * @param[in] scan_msg [const sensor_msgs::LaserScan::Ptr&] The input scan
 * message
 * @return void
 */
  void
FMTGlobalLocalisation::scanCallback(
  const sensor_msgs::LaserScan::Ptr& scan_msg)
{
  // **** if first scan, cache the tf from base to the scanner

  if (!received_scan_)
  {
    createCache(scan_msg);    // caches the sin and cos of all angles

    // cache the static tf from base to laser
    if (!getBaseToLaserTf(scan_msg->header.frame_id))
    {
      ROS_WARN("[FMTGlobal Localiser] Skipping scan");
      return;
    }

    received_scan_ = true;

    // Store the latest scan
    //boost::mutex::scoped_lock lock(mutex_);
    latest_world_scan_ =
      boost::make_shared<sensor_msgs::LaserScan>(*scan_msg);

    // Store the real scan image once
    LDP dft_world_scan_ldp;
    laserScanToLDP(latest_world_scan_, dft_world_scan_ldp);
    storeRealScanRanges(dft_world_scan_ldp);
    ld_free(dft_world_scan_ldp);
    plotRealScanImage();

    if (received_map_ && received_pose_cloud_ && received_start_signal_)
      processPoseCloud();
  }
}


/*******************************************************************************
 * @brief Given the robot's pose and a choice to scan over an angle of 2π,
 * this function simulates a range scan that has the physical world substituted
 * for the map.
 * @param[in] robot_pose [const geometry_msgs::Pose::Ptr&]
 * The robot's pose.
 * @param[in] scan_method [const std::string&] Which method to use for
 * scanning the map. Currently supports vanilla (Bresenham's method)
 * and ray_marching.
 * @param[in] do_fill_map_scan [const bool&] A choice to scan over an angle of
 * 2π.
 * @return [sensor_msgs::LaserScan::Ptr] The map scan in LaserScan form.
 */
  sensor_msgs::LaserScan::Ptr
FMTGlobalLocalisation::scanMap(
  const geometry_msgs::Pose::Ptr& robot_pose,
  const std::string& scan_method,
  const std::string& scan_context,
  const bool& do_fill_map_scan)
{
#if DEBUG_EXECUTION_TIMES == 1
  ros::Time start = ros::Time::now();
#endif

  // Get the laser's pose: the map scan needs that one, not the pose of the
  // robot!
  const geometry_msgs::Pose current_laser_pose =
    getCurrentLaserPose(*robot_pose);

  sensor_msgs::LaserScan::Ptr laser_scan_info =
    boost::make_shared<sensor_msgs::LaserScan>(*latest_world_scan_);

  // Scan the map over 2π -- we get more information that way
  if (do_fill_map_scan)
  {
    laser_scan_info->angle_min = -M_PI;
    laser_scan_info->angle_max = M_PI;
  }


  sensor_msgs::LaserScan::Ptr map_scan;
  double min_a = laser_scan_info->angle_min;
  double inc_a = laser_scan_info->angle_increment;

  // Scan the map using the occupancy_grid_utils method
  if (scan_method.compare("vanilla") == 0)
  {
    map_scan = occupancy_grid_utils::simulateRangeScan(map_, current_laser_pose,
      *laser_scan_info);
  }
  else if (scan_method.compare("ray_marching") == 0 ||
    scan_method.compare("bresenham") == 0 ||
    scan_method.compare("cddt") == 0)
  {
    // Convert laser position to grid coordinates
    float x = current_laser_pose.position.x / map_.info.resolution;
    float y = map_.info.height - 1 -
      current_laser_pose.position.y / map_.info.resolution;
    float a = extractYawFromPose(current_laser_pose);

    // How many rays?
    int num_rays = numRaysFromAngleRange(latest_world_scan_->angle_min,
      latest_world_scan_->angle_max, laser_scan_info->ranges.size(),
      laser_scan_info->angle_max - laser_scan_info->angle_min);

    map_scan = boost::make_shared<sensor_msgs::LaserScan>(*laser_scan_info);
    map_scan->ranges.clear();

    // The angular progression of scanning depends on how the laser is mounted
    // on the robot:
    // a. On the turtlebot the laser faces upwards;
    // b. On the rb1 the laser faces downwards
    int sgn = 0;
    if (laser_z_orientation_.compare("upwards") == 0)
      sgn = -1;
    else if (laser_z_orientation_.compare("downwards") == 0)
      sgn = 1;
    else
    {
      ROS_ERROR("[FMTGlobal Localiser] Please provide a valid value");
      ROS_ERROR("                     for param laser_z_orientation");
    }

    // Iterate over all angles.
    // Calculate range for every angle (calc_range returns range in pixels).
    // The angles start counting negatively.
    // For details see
    // https://github.com/kctess5/range_libc/blob/deploy/docs/RangeLibcUsageandInformation.pdf

    if (scan_method.compare("ray_marching") == 0)
    {
      if (scan_context.compare("rotation") == 0)
      {
        for (unsigned int i = 0; i < num_rays; i++)
          map_scan->ranges.push_back(map_.info.resolution *
            rot_rm_.calc_range(x,y, -a + sgn * (min_a + i * inc_a)));
      }

      if (scan_context.compare("translation") == 0)
      {
        for (unsigned int i = 0; i < num_rays; i++)
          map_scan->ranges.push_back(map_.info.resolution *
            rm_.calc_range(x,y, -a + sgn * (min_a + i * inc_a)));
      }
    }
    else if (scan_method.compare("cddt") == 0)
    {
      if (scan_context.compare("rotation") == 0)
      {
        for (unsigned int i = 0; i < num_rays; i++)
          map_scan->ranges.push_back(map_.info.resolution *
            rot_cddt_.calc_range(x,y, -a + sgn * (min_a + i * inc_a)));
      }

      if (scan_context.compare("translation") == 0)
      {
        for (unsigned int i = 0; i < num_rays; i++)
          map_scan->ranges.push_back(map_.info.resolution *
            cddt_.calc_range(x,y, -a + sgn * (min_a + i * inc_a)));
      }
    }
    else if (scan_method.compare("bresenham") == 0)
    {
      if (scan_context.compare("rotation") == 0)
      {
        for (unsigned int i = 0; i < num_rays; i++)
          map_scan->ranges.push_back(map_.info.resolution *
            rot_br_.calc_range(x,y, -a + sgn * (min_a + i * inc_a)));
      }

      if (scan_context.compare("translation") == 0)
      {
        for (unsigned int i = 0; i < num_rays; i++)
          map_scan->ranges.push_back(map_.info.resolution *
            br_.calc_range(x,y, -a + sgn * (min_a + i * inc_a)));
      }
    }
  }
  else // Default to vanilla
  {
    map_scan = occupancy_grid_utils::simulateRangeScan(map_, current_laser_pose,
      *laser_scan_info);
  }

  map_scan->header.stamp = ros::Time::now();

#if DEBUG_EXECUTION_TIMES == 1
  ROS_ERROR("scanMap() took %.2f ms", (ros::Time::now() - start).toSec() * 1000);
#endif

  return map_scan;
}


/*******************************************************************************
*/
bool
FMTGlobalLocalisation::startSignalService(
  std_srvs::Empty::Request& req,
  std_srvs::Empty::Response& res)
{
  // Call amcl's global localisation
  ros::ServiceClient client =
    nh_.serviceClient<std_srvs::Empty>(global_localisation_service_);
  std_srvs::Empty srv;

  bool success = false;

  if (client.call(srv))
  {
    ROS_INFO("[FMTGlobal Localiser] Successful call of global localisation");
    success = true;
  }
  else
  {
    ROS_ERROR("[FMTGlobal Localiser] Failed to call global localisation");
    success = false;
  }

  received_start_signal_ = success;

  return success;

  //if (received_map_ && received_scan_ && received_pose_cloud_)
    //processPoseCloud();
}


/*******************************************************************************
*/
  void
FMTGlobalLocalisation::storeRealScanRanges(const LDP& real_scan)
{
  std::tuple<double,double,double> zero_pose;
  std::get<0>(zero_pose) = 0.0;
  std::get<1>(zero_pose) = 0.0;
  std::get<2>(zero_pose) = 0.0;

  std::vector< std::pair<double,double> > real_scan_points;
  ldp2points(real_scan, zero_pose, &real_scan_points);

  std::string dump_filepath =
    "/home/li9i/catkin_ws/src/relief_fmt_global_localisation/tmp/real_scan.m";
  std::ofstream file(dump_filepath.c_str(), std::ios::trunc);

  if (file.is_open())
  {
    file << "rx = [];" << std::endl;
    file << "ry = [];" << std::endl;

    for (int i = 0; i < real_scan->nrays; i++)
    {
      file << "rx = [rx " << real_scan_points[i].first << "];" << std::endl;
      file << "ry = [ry " << real_scan_points[i].second << "];" << std::endl;
    }

    file.close();
  }
  else
    printf("[FMTGlobal Localiser] Could not log real scan\n");
}

/*******************************************************************************
*/
  void
FMTGlobalLocalisation::storeVirtualScanRanges(const LDP& virtual_scan)
{
  std::tuple<double,double,double> zero_pose;
  std::get<0>(zero_pose) = 0.0;
  std::get<1>(zero_pose) = 0.0;
  std::get<2>(zero_pose) = 0.0;

  std::vector< std::pair<double,double> > virtual_scan_points;
  ldp2points(virtual_scan, zero_pose, &virtual_scan_points);

  std::string dump_filepath =
    "/home/li9i/catkin_ws/src/relief_fmt_global_localisation/tmp/virtual_scan.m";
  std::ofstream file(dump_filepath.c_str(), std::ios::trunc);

  if (file.is_open())
  {
    file << "vx = [];" << std::endl;
    file << "vy = [];" << std::endl;
    for (int i = 0; i < virtual_scan->nrays; i++)
    {
      file << "vx = [vx " << virtual_scan_points[i].first << "];" << std::endl;
      file << "vy = [vy " << virtual_scan_points[i].second << "];" << std::endl;
    }

    file.close();
  }
  else
    printf("[FMTGlobal Localiser] Could not log virtual scan\n");
}


/*******************************************************************************
 * @brief Transforms a laser scan into the points of its ray-ends. Used to
 * visualise the transform of the map_scan and compare it against the world scan
 * @param[in] amcl_pose [const geometry_msgs::Pose::Ptr&]
 * The robot's pose
 * @param[in] scan [const sensor_msgs::LaserScan::Ptr&] The laser scan
 * (should be a map scan)
 * @param[in] transform [const tf::Transform&] The transform from the map scan
 * to the world scan
 * @return [geometry_msgs::PoseArray] An array of poses. The poses are the points
 * of the end of the rays of the map scan in the map frame.
 */
  geometry_msgs::PoseArray
FMTGlobalLocalisation::transformLaserScan(
  const geometry_msgs::Pose::Ptr& amcl_pose,
  const sensor_msgs::LaserScan::Ptr& scan,
  const tf::Transform& transform)
{
  // Get the laser pose: the scan is expressed in the laser frame
  geometry_msgs::Pose laser_pose = getCurrentLaserPose(*amcl_pose);

  // The scan transformed into an array of poses
  geometry_msgs::PoseArray corrected_poses;
  corrected_poses.header.frame_id = fixed_frame_;

  for (unsigned int i = 0; i < scan->ranges.size(); i++)
  {
    // Transform ray to point in map frame
    std::pair<double,double> p = rayToPoint(laser_pose, scan, i);

    geometry_msgs::Pose ray_pose;
    ray_pose.position.x = p.first;
    ray_pose.position.y = p.second;
    ray_pose.orientation.x = 0.0;
    ray_pose.orientation.y = 0.0;
    ray_pose.orientation.z = 0.0;
    ray_pose.orientation.w = 1.0;

    tf::Transform tr;
    tf::poseMsgToTF(ray_pose, tr);

    tf::Transform point_corrected_tf = tr * transform;

    geometry_msgs::Pose pose_corrected;
    tf::poseTFToMsg(point_corrected_tf, pose_corrected);
    corrected_poses.poses.push_back(pose_corrected);
  }

  return corrected_poses;
}


/*******************************************************************************
 * @brief Given the first coefficient of the DFT, this function turns them into
 * errors in the x and y directions.
 * @param[in] dft_coeff [const std::vector<double>&] A vector holding the real
 * part of the first coefficient of the dft in its first position, and the
 * imaginary in the second.
 * @param[in] num_valid_rays [const int&] The number of jointly valid rays.
 * @param[in] starting_angle [const double&] The orientation of the robot.
 * return [std::vector<double>] The errors in the x (in the first position)
 * and y (in the second position) directions.
 */
  std::vector<double>
FMTGlobalLocalisation::turnDFTCoeffsIntoErrors(
  const std::vector<double>& dft_coeff,
  const int& num_valid_rays,
  const double& starting_angle)
{
  double x_err = 0.0;
  double y_err = 0.0;

  if (num_valid_rays > 0)
  {
    // The error in the x- direction
    x_err = 1.0 / num_valid_rays *
      (-dft_coeff[0] * cos(starting_angle)
       -dft_coeff[1] * sin(starting_angle));

    // The error in the y- direction
    y_err = 1.0 / num_valid_rays *
      (-dft_coeff[0] * sin(starting_angle)
       +dft_coeff[1] * cos(starting_angle));
  }

  std::vector<double> errors;
  errors.push_back(x_err);
  errors.push_back(y_err);

  return errors;
}


/*******************************************************************************
 * @brief Undersamples a LDP scan.
 * @param[in,out] scan [LDP&] The input scan
 * @param[in] rate [const int&] Take account of one out of every rate rays of
 * input scan
 * @return void
 */
  void
FMTGlobalLocalisation::undersampleLDPScan(
  LDP& scan,
  const int& rate)
{
  // The undersampled scan will have scan.nrays / rate number of rays
  int nrays = static_cast<int>(static_cast<double>(scan->nrays) / rate);

  LDP subed_scan = ld_alloc_new(nrays);

  int s = 0;
  for (unsigned int i = 0; i < nrays; i++)
  {
    subed_scan->valid[i] = scan->valid[s];
    subed_scan->theta[i] = scan->theta[s];
    subed_scan->cluster[i] = scan->cluster[s];
    subed_scan->readings[i] = scan->readings[s];

    s += rate;
  }

  subed_scan->nrays = nrays;
  subed_scan->min_theta = subed_scan->theta[0];
  subed_scan->max_theta = subed_scan->theta[nrays-1];

  subed_scan->odometry[0] = scan->odometry[0];
  subed_scan->odometry[1] = scan->odometry[1];
  subed_scan->odometry[2] = scan->odometry[2];

  subed_scan->true_pose[0] = scan->true_pose[0];
  subed_scan->true_pose[1] = scan->true_pose[1];
  subed_scan->true_pose[2] = scan->true_pose[2];

  copyLDP(subed_scan, scan);
  ld_free(subed_scan);
}


/*******************************************************************************
 * @brief Undersamples a world and a map scan in LDP scan.
 * @param[in,out] world_scan [LDP&] A world scan in LDP form
 * @param[in,out] map_scan [LDP&] A map scan in LDP form
 * @param[in] rate [const int&] Take account of one out of every rate rays of
 * the input scans
 * @return void
 */
  void
FMTGlobalLocalisation::undersampleLDPScans(
  LDP& world_scan,
  LDP& map_scan,
  const int& rate)
{
  undersampleLDPScan(world_scan, rate);
  undersampleLDPScan(map_scan, rate);
}


/*******************************************************************************
 * @brief Checks whether a value exists within the ranges structure of a
 * geometry_msgs::LaserScan laser scan.
 * @param[in] scan [const sensor_msgs::LaserScan&] The scan
 * @param[in] value [const double&] The value to be searched in the scan
 * @return [bool]
 */
  bool
FMTGlobalLocalisation::valueExistsInLaserScan(
  const sensor_msgs::LaserScan::Ptr& scan,
  const double& value)
{
  bool value_exists = false;

  for (std::vector<float>::iterator it = scan->ranges.begin();
    it != scan->ranges.end(); it++)
  {
    if (*it == value)
      value_exists = true;
  }

  return value_exists;
}

/*******************************************************************************
 * @brief Visualisation of world and map scans
 * @param[in] world_scan [const LDP&] The world scan in LDP form
 * @param[in] map_scan [const LDP&] The map scan in LDP form
 * @return void
 */
  void
FMTGlobalLocalisation::visualiseScans(
  const LDP& world_scan,
  const LDP& map_scan)
{
  sensor_msgs::LaserScan world_laser_scan = *ldpTolaserScan(world_scan);
  sensor_msgs::LaserScan map_laser_scan = *ldpTolaserScan(map_scan);

  world_scan_publisher_.publish(world_laser_scan);
  map_scan_publisher_.publish(map_laser_scan);
}


/*******************************************************************************
 * @brief Wraps an angle in the [-π, π] interval
 * @param[in,out] angle [double&] The angle to be expressed in [-π,π]
 * @return void
 */
  void
FMTGlobalLocalisation::wrapAngle(double& angle)
{
  angle = fmod(angle + 5*M_PI, 2*M_PI) - M_PI;
}

/*******************************************************************************
 * @brief Wraps a pose's orientation in the [-π,π] interval
 * @param[in,out] pose [geometry_msgs::Pose::Ptr&] The pose
 * whose input will be wrapped in [-π,π]
 * @return void
 */
  void
FMTGlobalLocalisation::wrapPoseOrientation(
  geometry_msgs::Pose::Ptr& pose)
{
  // Extract yaw ...
  double yaw = extractYawFromPose(*pose);

  // ... and wrap between [-π, π]
  wrapAngle(yaw);

  tf::Quaternion q;
  q.setRPY(0.0, 0.0, yaw);
  q.normalize();
  tf::quaternionTFToMsg(q, pose->orientation);
}
