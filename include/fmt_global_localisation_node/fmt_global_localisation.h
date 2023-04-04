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
 *
 *  [1] A. Censi, "An ICP variant using a point-to-line metric"
 *  Proceedings of the IEEE International Conference
 *  on Robotics and Automation (ICRA), 2008
 */

#ifndef FMT_GLOBAL_LOCALISATION_H
#define FMT_GLOBAL_LOCALISATION_H

#include <unistd.h>
#include <sys/wait.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <utime.h>
#include <cmath>
#include <iostream>
#include <time.h>
#include <boost/random/normal_distribution.hpp>
#include <boost/random/mersenne_twister.hpp>
#include <boost/random/variate_generator.hpp>
#include <python2.7/Python.h>
#include "octave-4.0.0/octave/oct.h"
#include "octave-4.0.0/octave/octave.h"
#include "octave-4.0.0/octave/parse.h"
#include "octave-4.0.0/octave/toplev.h"
#include <gsl/gsl_vector.h>
#include <gsl/gsl_histogram.h>
#include <gsl/gsl_matrix.h>
#include <ros/ros.h>
#include <sensor_msgs/LaserScan.h>
#include <std_msgs/Duration.h>
#include <std_msgs/UInt64.h>
#include <std_msgs/String.h>
#include <std_msgs/Empty.h>
#include <std_srvs/Empty.h>
#include <geometry_msgs/Pose.h>
#include <geometry_msgs/PoseArray.h>
#include <geometry_msgs/PoseWithCovarianceStamped.h>
#include <nav_msgs/OccupancyGrid.h>
#include <nav_msgs/Odometry.h>
#include <tf/transform_datatypes.h>
#include <tf/transform_listener.h>
#include <tf/transform_broadcaster.h>
#include <csm/csm_all.h>  // csm defines min and max, but Eigen complains
#include <egsl/egsl_macros.h>

#undef min
#undef max

#include "utils/range_libc/includes/RangeLib.h"
#include "utils/range_libc_rotation/includes/RangeLib.h"
#include "utils/occupancy_grid_utils/ray_tracer.h"
#include "utils/dft_utils.h"



class FMTGlobalLocalisation
{
  public:

    FMTGlobalLocalisation(ros::NodeHandle nh, ros::NodeHandle nh_private);
    ~FMTGlobalLocalisation();

  private:

    // **** ros

    ros::NodeHandle nh_;
    ros::NodeHandle nh_private_;

    // subscribers
    ros::Subscriber scan_subscriber_;
    ros::Subscriber map_subscriber_;
    ros::Subscriber pose_subscriber_;
    ros::Subscriber pose_cloud_subscriber_;
    ros::Subscriber odom_subscriber_;
    ros::Subscriber ground_truth_subscriber_;

    // services
    ros::ServiceServer start_signal_service_;

    tf::TransformListener tf_listener_;
    tf::TransformBroadcaster tf_broadcaster_;

    tf::StampedTransform map_to_base_tf_;

    // static, cached
    tf::Transform base_to_laser_;

    // static, cached, calculated from base_to_laser_
    tf::Transform laser_to_base_;

    // publishers
    ros::Publisher feedback_pose_publisher_;
    ros::Publisher global_pose_publisher_;
    ros::Publisher execution_time_publisher_;
    ros::Publisher num_particles_publisher_;
    ros::Publisher image_size_publisher_;
    ros::Publisher image_format_publisher_;
    ros::Publisher world_scan_publisher_;
    ros::Publisher map_scan_publisher_;
    ros::Publisher map_scan_corrected_publisher_;

    // **** parameters

    std::string base_frame_;
    std::string fixed_frame_;
    std::string odom_frame_;

    std::string scan_topic_;
    std::string map_topic_;
    std::string odom_topic_;
    std::string input_pose_topic_;
    std::string input_pose_cloud_topic_;
    std::string global_localisation_service_;
    std::string start_signal_service_name_;

    std::string laser_z_orientation_;
    bool do_icp_;
    bool do_fmt_;

    unsigned int num_calls_global_localisation_;

    bool close_loop_;
    bool robot_is_omw_;

    bool publish_pose_with_covariance_stamped_;

    std::vector<double> position_covariance_;
    std::vector<double> orientation_covariance_;

    // Parameters introduced by us
    bool feedback_init_pf_;
    std::string feedback_particle_topic_;
    int map_scan_theta_disc_;

    // ICP variables introduced by us
    int icp_iterations_;
    bool icp_incorporate_orientation_only_;
    bool icp_provide_initial_guess_;
    std::string icp_map_scan_method_;
    bool icp_do_fill_map_scan_;
    int icp_scan_undersample_rate_;
    int dft_scan_undersample_rate_;
    bool icp_do_clip_scans_;
    double icp_clip_sill_;
    double icp_clip_lintel_;
    double icp_fill_mean_value_;
    double icp_fill_std_value_;
    bool icp_do_invalidate_diff_rays_;
    double icp_invalidate_diff_rays_epsilon_;
    std::string op_icp_;


    // DFT variables introduced by us
    int dft_iterations_;
    bool dft_do_fill_map_scan_;
    std::string dft_map_scan_method_;
    double dft_fill_mean_value_;
    double dft_fill_std_value_;
    int dft_min_valid_rays_;
    bool dft_do_invalidate_diff_rays_;
    double dft_invalidate_diff_rays_epsilon_;
    std::string op_dft_;
    int dft_image_size_;
    std::string dft_image_format_;

    // Visualisation params introduced by us
    bool icp_visual_debug_;
    bool icp_do_publish_scans_;
    bool dft_do_publish_scans_;

    // Covariance params
    double initial_cov_xx_;
    double initial_cov_yy_;
    double initial_cov_aa_;

    // **** state variables

    boost::mutex mutex_;

    bool received_scan_;
    bool received_map_;
    bool received_pose_cloud_;
    bool running_;
    int received_both_scan_and_map_;
    bool received_start_signal_;

    // fixed-to-base tf (pose of base frame in fixed frame)
    tf::Transform f2b_;

    // the map
    nav_msgs::OccupancyGrid map_;

    // The map converted to a suitable structure for 3rd-party lib ray-casting
    ranges::OMap omap_;
    ranges_rot::OMap omap_rot_;
    std::string map_png_file_;

    // 3rd-party ray-casters (range_libc)
    ranges::RayMarching rm_;
    ranges::CDDTCast cddt_;
    ranges::BresenhamsLine br_;

    ranges_rot::RayMarching rot_rm_;
    ranges_rot::CDDTCast rot_cddt_;
    ranges_rot::BresenhamsLine rot_br_;

    // The world scan received latest
    sensor_msgs::LaserScan::Ptr latest_world_scan_;

    std::vector<double> a_cos_;
    std::vector<double> a_sin_;

    sm_params input_;
    sm_result output_;

    ros::Time ground_truths_latest_received_time_;

    std::vector<geometry_msgs::Pose::Ptr> dispersed_particles_;

    // **** methods


    static void local_exit(int);
    std::vector<double> callPythonFunc();

    /*****************************************************************************
     * @brief This function provides the amcl algorithm with a corrected pose so
     * as to either (a) initialise itself with it, or (b) introduce the pipeline
     * result as a new particle.
     * @param[in] pose [const geometry_msgs::Pose&] The pose
     * to feed to the amcl
     * @return void
     */
    void closeLoop(const geometry_msgs::PoseWithCovarianceStamped& pose);

    /*****************************************************************************
     * @brief Given two scans (their order matters), this function computes the
     * difference between all valid rays and returns a vector holding the values
     * of these diffs.
     * @param[in] scan_1 [const LDP&] The first scan (should be a world scan)
     * @param[in] scan_2 [const LDP&] The second scan (should be map scan)
     * @param[out] diff_scan [std::vector<double>] A vector holding the
     * difference between valid rays of scan_1 and scan_2.
     * @return [int] The number of valid rays
     */
    int computeRaysDiff(const LDP& scan_1, const LDP& scan_2,
      std::vector<double>* diff_scan);

    /*****************************************************************************
     * @brief Copies a source LDP structure to a target one.
     * @param[in] source [const LDP&] The source structure
     * @param[out] target [LDP&] The destination structure
     * @return void
     */
    void copyLDP(const LDP& source, LDP& target);

    /*****************************************************************************
     * @brief Regarding a single ray with index id, this function copies data
     * from a ray of the source LDP structure to that of a target one.
     * @param[in] source [const LDP&] The source structure
     * @param[out] target [LDP&] The destination structure
     * @param[in] id [const int&] The ray index
     * @return void
     */
    void copyRayDataLDP(const LDP& source, LDP& target, const int& id);

    /*****************************************************************************
     * @brief Regarding the metadata from a source LDP, copy them to a
     * a target LDP.
     * @param[in] source [const LDP&] The source structure
     * @param[out] target [LDP&] The destination structure
     * @return void
     */
    void copyMetaDataLDP(const LDP& source, LDP& target);

    /*****************************************************************************
     * @brief This function uses the icp result for correcting the amcl pose.
     * Given the icp output, this function express this correction in the
     * map frame. The result is the icp-corrected pose in the map frame.
     * @param[in,out] icp_corrected_pose
     * [geometry_msgs::Pose::Ptr&] The icp-corrected amcl
     * pose
     * @return void
     */
    void correctICPPose(geometry_msgs::Pose::Ptr& icp_corrected_pose,
      const tf::Transform& f2b);

    /*****************************************************************************
    */
    void correctDFTPose(geometry_msgs::Pose::Ptr& icp_corrected_pose,
      const tf::Transform& f2b);

    /*****************************************************************************
     * @brief Corrects the icp-corrected pose by means of the first coefficient of
     * a DFT of the signal which is the difference between a world scan and a
     * map scan.
     * @param[in,out] dft_corrected_pose
     * [geometry_msgs::Pose::Ptr&]
     * When in, it is equal to the icp-corrected pose. When out, it is the
     * dft-corrected icp-corrected amcl pose.
     * @param[in] dft_coeff [std::vector<double>*] The DFT coefficients.
     * The first one is the real part of the first DFT coefficient. The second one
     * is the imaginary part of the first DFT coefficient.
     * @param[in] num_rays [const int&] The number of rays in the
     * scan that produced the dft_coeff vector
     * @return void
     */
    void correctICPPose(
      geometry_msgs::Pose::Ptr& dft_corrected_pose,
      const std::vector<double>& dft_coeff,
      const int& num_rays);

    /*****************************************************************************
     * @brief Creates a cache for access to values of sin and cos for all values
     * in [scan_msg->angle_min, can_msg->angle_max].
     * @param[in] scan_msg [const sensor_msgs::LaserScan::Ptr&] A scan
     * @return void
     */
    void createCache (const sensor_msgs::LaserScan::Ptr& scan_msg);

    /*****************************************************************************
     * @brief Creates a transform from a 2D pose (x,y,theta)
     * @param[in] x [const double&] The x-wise coordinate of the pose
     * @param[in] y [const double&] The y-wise coordinate of the pose
     * @param[in] theta [const double&] The orientation of the pose
     * @param[in,out] t [tf::Transform&] The returned transform
     */
    void createTfFromXYTheta(const double& x, const double& y,
      const double& theta, tf::Transform& t);

    /*****************************************************************************
     * @brief The map scan is published through this function, as a means of
     * visual debug
     * @param[in] amcl_pose [const geometry_msgs::Pose::Ptr]
     * The pose of the robot.
     * @param[in] world_scan [const sensor_msgs::LaserScan::Ptr&] The world scan
     * @param[in] map_scan [const sensor_msgs::LaserScan::Ptr&] The map scan
     * @param[in] world_scan_ldp [const LDP&] The world scan in LDP form
     * @param[in] map_scan_ldp [const LDP&] The map scan in LDP form
     * @return void
     */
    void debugICP(const geometry_msgs::Pose::Ptr pose,
      const sensor_msgs::LaserScan::Ptr& world_scan,
      const sensor_msgs::LaserScan::Ptr& map_scan,
      const LDP& world_scan_ldp,
      const LDP& map_scan_ldp);

    /*****************************************************************************
     * @brief Given the ICP-corrected pose and a world scan, this function
     * corrects the pose by DFT-ing the difference between the world scan and a
     * map scan taken at the ICP-corrected pose.
     * @param[in] icp_corrected_pose
     * [const geometry_msgs::Pose::Ptr&]
     * The amcl pose corrected by the preceding ICP
     * @param[in] latest_world_scan [const sensor_msgs::LaserScan::Ptr&] The real
     * laser scan
     * @return void
     */
    void doDFT(
      const geometry_msgs::Pose::Ptr& icp_corrected_pose,
      const sensor_msgs::LaserScan::Ptr& latest_world_scan,
      sm_result* output, tf::Transform* f2b);

    /*****************************************************************************
     * @brief Given the amcl pose and a world scan, this function corrects
     * the pose by ICP-ing the world scan and a map scan taken at the amcl pose
     * @param[in] amcl_pose_msg
     * [const geometry_msgs::Pose::Ptr&] The amcl pose
     * @param[in] latest_world_scan [const sensor_msgs::LaserScan::Ptr&] The real
     * laser scan
     * @return void
     */
    void doICP(const geometry_msgs::Pose::Ptr& amcl_pose_msg,
      const sensor_msgs::LaserScan::Ptr& latest_world_scan,
      sm_result* output, tf::Transform* f2b);


    void dumpScan2(const LDP& real_scan, const LDP& virtual_scan);

    /*****************************************************************************
     * @brief Extracts the yaw component from the input pose's quaternion.
     * @param[in] pose [const geometry_msgs::Pose&] The input pose
     * @return [double] The pose's yaw
     */
    double extractYawFromPose(const geometry_msgs::Pose& pose);

    /*****************************************************************************
     * @brief Receives two laser scans in LDP form as input.
     * Supposing that ldp.max_theta - ldp.min_theta < 2π, this function fills in
     * the missing range values of target_scan_ldp (missing in the sense that in
     * the end the target scan will be ranging over 2π) with the values of
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
    void fillLaserScanLDP(const LDP& source_scan_ldp, LDP& target_scan_ldp,
      const std::string& operation);

    /*****************************************************************************
     * @brief Finds the transform between the laser frame and the base frame
     * @param[in] frame_id [const::string&] The laser's frame id
     * @return [bool] True when the transform was found, false otherwise.
     */
    bool getBaseToLaserTf (const std::string& frame_id);

    /*****************************************************************************
     * @brief Given the robot's pose in the map frame, this function returns the
     * laser's pose in the map frame.
     * @param[in] robot_pose [const geometry_msgs::Pose&] The robot's pose in the
     * map frame.
     * @return [geometry_msgs::Pose] The pose of the laser in the map frame.
     */
    geometry_msgs::Pose getCurrentLaserPose(
      const geometry_msgs::Pose& robot_pose);


    long get_mtime(const char *path);

    /*****************************************************************************
     * @brief Returns the number of valid rays of a LDP scan
     * @param[in] scan [const LDP&] The input scan
     * @return [int] The number of valid rays of scan
     */
    int getNumberOfValidRays(const LDP& scan);

    /*****************************************************************************
     * @brief Calculates the compound velocity in (x,y,theta) from a twist
     * message.
     * @param[in] twist_msg [const geometry_msgs::Twist&] The twist message
     * containing the linear and angular velocities of the robot
     * @return [double] The compound velocity
     */
    double getTotal3DVelocity(const geometry_msgs::Twist& twist_msg);

    double findArea(
      const std::vector< std::pair<double,double> >& polygon);

    std::pair<double,double> findCentroid(
      const std::vector< std::pair<double,double> >& polygon);

    /*****************************************************************************
     * @brief This is where all the magic happens
     * @param[in] pose_msg [const geometry_msgs::Pose::Ptr&]
     * The amcl pose wrt to the map frame
     * @return void
     */
    void handleInputPose(const geometry_msgs::Pose::Ptr& pose_msg,
      sm_result* output, tf::Transform* f2b);

    /*****************************************************************************
     * @brief Initializes parameters
     * @return void
     */
    void initParams();

    /*****************************************************************************
     * @brief Initialises the ray-casters from the RangeLib library. Since they
     * take as arguments the maximum range of the lidar and the resolution of the
     * map, and these are unknown before being received, this function should be
     * called ONCE, exactly after the first scan and the map are received.
     * @param void
     * @return void
     */
    void initRangeLibRayCasters();

    /*****************************************************************************
     * @brief Invalidates a LDP scan's rays. If these are above or below certain
     * thresholds, then the `valid` field of their LDP is marked with 0.
     * @param[in,out] scan [LDP&] The input scan.
     * @param[in] lintel [const double&] The threshold under which rays will be
     * invalidated.
     * @param[in] sill [const double&] The threshold over which rays will be
     * invalidated.
     */
    void invalidateByClippingScan(LDP& scan,
      const double& lintel, const double& sill);

    /*****************************************************************************
     * @brief Invalidates a world and a map scan by clipping them above and below.
     * @param[in,out] world_scan [LDP&] A world scan in LDP form
     * @param[in,out] map_scan [LDP&] A map scan in LDP form
     * @param[in] lintel [const double&] The threshold under which rays will be
     * invalidated.
     * @param[in] sill [const double&] The threshold over which rays will be
     * invalidated.
     * @return void
     */
    void invalidateByClippingScans(LDP& world_scan, LDP& map_scan,
      const double& lintel, const double& sill);

    /*****************************************************************************
     * @brief Invalidates scans by checking the difference between their rays and
     * a known threshold, based on the origin operation.
     * @param[in] scan_1 [LDP&] A LDP scan (should be a world scan)
     * @param[in] scan_2 [LDP&] A LDP scan (should be a map scan)
     * @param[in] threshold [const double&] A threshold over which the difference
     * between rays of scan_1 and scan_2 will invalidate said rays if operation
     * is equal to "dft". If operation is equal to "icp", this function
     * invalidates the rays of scan_2 over [min_angle, max_angle] and those of
     * scan_1 if additionally scan_1 is to be filled.
     * @param[in] operation [const std::string&] The origin operation. Available
     * values are "icp" or "dft".
     * @return void
     */
    void invalidateDiffRays(LDP& scan_1, LDP& scan_2, const double& threshold,
      const std::string& operation);

    /*****************************************************************************
     * @brief Converts a LaserScan laser scan to a LDP structure.
     * @param[in] scan_msg [const sensor_msgs::LaserScan::Ptr&] The input
     * scan
     * @param[out] ldp [LDP&] The output LDP scan
     * @return void
     */
    void laserScanToLDP(const sensor_msgs::LaserScan::Ptr& scan_msg,
      LDP& ldp);

    void ldp2points(const LDP& scan,
      const std::tuple<double,double,double> pose,
      std::vector< std::pair<double,double> >* points);

    /*****************************************************************************
     * @brief Converts a LDP structure to a LaserScan laser scan
     * @param[in] ldp [const LDP&] The input LDP laser scan
     * @return [sensor_msgs::LaserScan::Ptr] The output LaserScan laser scan
     */
    sensor_msgs::LaserScan::Ptr ldpTolaserScan(const LDP& ldp);

    /*****************************************************************************
     * @brief Stores the map upon receipt. (The map does not change through time)
     * @param[in] map_msg [const nav_msgs::OccupancyGrid] The map
     * @return void
     */
    void mapCallback (const nav_msgs::OccupancyGrid& map);

    /*****************************************************************************
     * @brief Publishes the pipeline's latest execution time.
     * @param[in] start [const ros::Time&] The start time of the pipeline's
     * execution
     * @param[in] end [const ros::Time&] The end time of the pipeline's execution
     */
    void measureExecutionTime(const ros::Time& start, const ros::Time& end);

    /*****************************************************************************
     * @brief Checks if there are nan's in an input pose.
     * @param[in] pose_msg [const geometry_msgs::Pose::Ptr&]
     * The input pose
     * @return [bool] True if there is at least one nan in the input_pose, false
     * otherwise.
     */
    bool nanInPose(
      const geometry_msgs::Pose::Ptr& pose_msg);

    /*****************************************************************************
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
    int numRaysFromAngleRange(const double& angle_min, const double& angle_max,
      const int& num_rays, const double& new_range);

    /*****************************************************************************
     * @brief The odometry callback. Used to determine if the robot is on the move
     * or not.
     * @param[in] odom_msg [const nav_msgs::Odometry&] The odometry message.
     * @return void
     */
    void odomCallback(const nav_msgs::Odometry& odom_msg);


    /*****************************************************************************
    */
    void plotWithOctave();

    /*****************************************************************************
    */
    void plotRealScanImage();

    /*****************************************************************************
    */
    void plotVirtualScanImage();

    /*****************************************************************************
     * @brief the amcl pose callback. this is the point of entry to the pipeline
     * operation
     * @param[in] pose_msg [const geometry_msgs::PoseWithCovarianceStamped::Ptr&]
     * the amcl pose wrt to the map frame
     * @return void
     */
    void poseCallback(
      const geometry_msgs::PoseWithCovarianceStamped::Ptr& pose_msg);

    /*******************************************************************************
     * @brief The amcl cloud pose callback. This is the point of entry
     * @param[in] pose_cloud_msg [const geometry_msgs::PoseArray::Ptr&]
     * The amcl pose wrt to the map frame
     * @return void
     */
    void poseCloudCallback(
      const geometry_msgs::PoseArray::Ptr& pose_cloud_msg);

    /*****************************************************************************
     * @brief Processes two scans (a world scan and a map scan) in LDP form prior
     * to the DFT operation.
     * @param[in,out] scan_1 [LDP&] The world scan
     * @param[in,out] scan_2 [LDP&] The map scan
     */
    void preprocessDFTScans(LDP& scan_1, LDP& scan_2);

    /*****************************************************************************
     * @brief Processes two scans (a world scan and a map scan) in LDP form prior
     * to the ICP operation.
     * @param[in,out] scan_1 [LDP&] The world scan
     * @param[in,out] scan_2 [LDP&] The map scan
     * return void
     */
    void preprocessICPScans(LDP& scan_1, LDP& scan_2);

    /*****************************************************************************
     * @brief
     * @return void
     */
    void processPoseCloud();

    /*****************************************************************************
     * @brief The champion function of the ICP operation.
     * @param[in] world_scan_ldp [LDP&] The world scan in LDP form.
     * @param[in] map_scan_ldp [LDP&] The map scan in LDP form.
     * @return void
     */
    void processScan(LDP& world_scan_ldp, LDP& map_scan_ldp,
      sm_result* output, tf::Transform* f2b);

    /*****************************************************************************
     * @brief Calculate the distance between the endpoints of two rays whose
     * in-between angle has a cosine equal to `cos_angle`
     * @param[in] r1 [const  double&] The first laser range distance
     * @param[in] r2 [const  double&] The second laser range distance
     * @param[in] cos_angle [const  double&] The cosine of the angle between r1
     * and r2
     * @return [double] The distance between the endpoints of r1 and r2
     */
    double raysEndpointDistance(
      const double& r1, const double& r2, const double& cos_angle);

    /*****************************************************************************
     * @brief Transforms a single ray from a range scan into a point in the
     * laser_pose's frame of reference.
     * @param[in] laser_pose [const geometry_msgs::Pose&] The pose of the laser in
     * the map frame.
     * @param[in] scan [const sensor_msgs::LaserScan::Ptr&] The input
     * scan
     * @param[in] ray_id [const int&] The index of the ray within the input scan
     * ranges structure.
     * @return [std::pair<double,double>] The ray as a point (x,y)
     */
    std::pair<double,double> rayToPoint(
      const geometry_msgs::Pose& laser_pose,
      const sensor_msgs::LaserScan::Ptr& scan,
      const int& ray_id);

    /*****************************************************************************
    */
    void rotate( geometry_msgs::Pose::Ptr pose, const double& angle);

    /*****************************************************************************
     * @brief The laser scan callback
     * @param[in] scan_msg [const sensor_msgs::LaserScan::Ptr&] The input
     * scan message
     * @return void
     */
    void scanCallback (const sensor_msgs::LaserScan::Ptr& scan_msg);

    /*****************************************************************************
     * @brief Given the robot's pose and a choice to scan over an angle of 2π,
     * this function simulates a range scan that has the physical world
     * substituted for the map.
     * @param[in] robot_pose
     * [const geometry_msgs::Pose::Ptr&] The robot's pose.
     * @param[in] scan_method [const std::string&] Which method to use for
     * scanning the map. Currently supports vanilla (Bresenham's method)
     * and ray_marching.
     * @param[in] do_fill_map_scan [const bool&] A choice to scan over an angle of
     * 2π.
     * @return [sensor_msgs::LaserScan::Ptr] The map scan in LaserScan form.
     */
    sensor_msgs::LaserScan::Ptr scanMap(
      const geometry_msgs::Pose::Ptr& robot_pose,
      const std::string& scan_method,
      const std::string& scan_context,
      const bool& do_fill_map_scan);

    /*****************************************************************************
    */
    bool startSignalService(std_srvs::Empty::Request& req,
      std_srvs::Empty::Response& res);

    /*****************************************************************************
    */
    void storeRealScanRanges(const LDP& real_scan);

    /*****************************************************************************
    */
    void storeVirtualScanRanges(const LDP& virtual_scan);

    /*****************************************************************************
     * @brief Transforms a laser scan into the points of its ray-ends. Used to
     * visualise the transform of the map_scan and compare it against the world
     * scan @param[in] amcl_pose
     * [const geometry_msgs::Pose::Ptr&] The robot's pose
     * @param[in] scan [const sensor_msgs::LaserScan::Ptr&] The laser scan
     * (should be a map scan)
     * @param[in] transform [const tf::Transform&] The transform from the map scan
     * to the world scan
     * @return [geometry_msgs::PoseArray] An array of poses. The poses are the
     * points of the end of the rays of the map scan in the map frame.
     */
    geometry_msgs::PoseArray transformLaserScan(
      const geometry_msgs::Pose::Ptr& amcl_pose,
      const sensor_msgs::LaserScan::Ptr& scan,
      const tf::Transform& transform);

    /*****************************************************************************
     * @brief Given the first coefficient of the DFT, this function turns them
     * into errors in the x and y directions.
     * @param[in] dft_coeff [const std::vector<double>&] A vector holding the real
     * part of the first coefficient of the dft in its first position, and the
     * imaginary in the second.
     * @param[in] num_valid_rays [const int&] The number of jointly valid rays.
     * @param[in] starting_angle [const double&] The orientation of the robot.
     * return [std::vector<double>] The errors in the x (in the first position)
     * and y (in the second position) directions.
     */
    std::vector<double> turnDFTCoeffsIntoErrors(
      const std::vector<double>& dft_coeff,
      const int& num_valid_rays,
      const double& starting_angle);

    /*****************************************************************************
     * @brief Undersamples a LDP scan.
     * @param[in,out] scan [LDP&] The input scan
     * @param[in] rate [const int&] Take account of one out of every rate rays of
     * input scan
     * @return void
     */
    void undersampleLDPScan(LDP& scan, const int& rate);

    /*****************************************************************************
     * @brief Undersamples a world and a map scan in LDP scan.
     * @param[in,out] world_scan [LDP&] A world scan in LDP form
     * @param[in,out] map_scan [LDP&] A map scan in LDP form
     * @param[in] rate [const int&] Take account of one out of every rate rays of
     * the input scans
     * @return void
     */
    void undersampleLDPScans(LDP& world_scan, LDP& map_scan, const int& rate);

    /*****************************************************************************
     * @brief Checks whether a value exists within the ranges structure of a
     * geometry_msgs::LaserScan laser scan.
     * @param[in] scan [const sensor_msgs::LaserScan&] The scan
     * @param[in] value [const double&] The value to be searched in the scan
     * @return [bool]
     */
    bool valueExistsInLaserScan(const sensor_msgs::LaserScan::Ptr& scan,
      const double& value);

    /*****************************************************************************
     * @brief Visualisation of world and map scans
     * @param[in] world_scan [const LDP&] The world scan in LDP form
     * @param[in] map_scan [const LDP&] The map scan in LDP form
     * @return void
     */
    void visualiseScans(const LDP& world_scan, const LDP& map_scan);

    /*****************************************************************************
     * @brief Wraps an angle in the [-π, π] interval
     * @param[in,out] angle [double&] The angle to be expressed in [-π,π]
     * @return void
     */
    void wrapAngle(double& angle);

    /*****************************************************************************
     * @brief Wraps a pose's orientation in the [-π,π] interval
     * @param[in,out] pose [geometry_msgs::Pose::Ptr&] The
     * pose whose input will be wrapped in [-π,π]
     * @return void
     */
    void wrapPoseOrientation(
      geometry_msgs::Pose::Ptr& pose);
};

#endif // FMT_GLOBAL_LOCALISATION_H
