#!/usr/bin/env python
import os
import roslaunch
import rospy
import sys
import datetime
from shutil import copyfile

# ------------------------------------------------------------------------------
def run_experiments(num_experiments = 100):

  # Upper-most directory
  root_dir = "/home/li9i/catkin_ws/src/relief_fmt_global_localisation/"

  # Launch file
  launch_file = root_dir + "launch/avanti.launch"

  # Experiments directory
  exp_directory = root_dir + "experiments_logs/"

  # Create log-directory identified by timestamp at time of execution
  full_now = datetime.datetime.now()
  now = full_now.strftime("%Y-%m-%d_%H:%M:%S")
  base_directory = exp_directory + "N/" + str(now) + "/"
  os.makedirs(base_directory)

  # Copy the pipeline's configuration files to the log directory
  params_dir = "/home/li9i/catkin_ws/src/relief_fmt_global_localisation/configuration_files/"
  csm_params_file = "pipeline_csm.yaml"
  icp_params_file = "pipeline_icp.yaml"
  dft_params_file = "pipeline_dft.yaml"
  general_params_file = "pipeline_general.yaml"

  copyfile(params_dir + csm_params_file, base_directory + csm_params_file)
  copyfile(params_dir + icp_params_file, base_directory + icp_params_file)
  copyfile(params_dir + dft_params_file, base_directory + dft_params_file)
  copyfile(params_dir + general_params_file, base_directory + general_params_file)

  turtlebot_urdf_dir = "/home/li9i/catkin_ws/src/relief_turtlebot_packages/relief_turtlebot_description/turtlebot/urdf/"
  turtlebot_laser_noise_file = "turtlebot_gazebo.urdf.xacro"
  copyfile(turtlebot_urdf_dir + turtlebot_laser_noise_file, base_directory + turtlebot_laser_noise_file)

  # Copy amcl's params to the log directory
  amcl_params_dir = "/home/li9i/catkin_ws/src/relief_amcl_mod/configuration_files/"
  amcl_params_file = "amcl_params.yaml"
  copyfile(amcl_params_dir + amcl_params_file, base_directory + amcl_params_file)

  # Copy pipeline_localiser.cpp file
  code_dir = "/home/li9i/catkin_ws/src/relief_fmt_global_localisation/src/fmt_global_localisation_node/"
  code_file = "fmt_global_localisation.cpp"
  copyfile(code_dir + code_file, base_directory + code_file)

  # Launch num_experiments experiments
  for i in range(0,num_experiments):
    launch_experiment(launch_file, i+1)

    # Move files to individual directory: now/i
    move_files(exp_directory, base_directory, i+1)


# ------------------------------------------------------------------------------
def launch_experiment(launch_file, i):

  # launch roscore first
  uuid0 = roslaunch.rlutil.get_or_generate_uuid(None, False)
  launch0 = roslaunch.parent.ROSLaunchParent(uuid0, [], is_core=True)
  launch0.start()

  # prepare launch of individual experiment
  uuid = roslaunch.rlutil.get_or_generate_uuid(None, False)
  launch = roslaunch.parent.ROSLaunchParent(uuid, [launch_file])

  # launch experiment
  launch.start()

  #rospy.sleep(300)
  #rospy.sleep(460)
  rospy.sleep(60)

  # Shutdown experiment
  launch.shutdown()

  # Shutdown roscore
  launch0.shutdown()


# ------------------------------------------------------------------------------
def move_files(exp_directory, base_directory, idx):

  destination_directory = base_directory + str(idx)
  os.makedirs(destination_directory)

  filenames_per = []
  filenames_per.append("execution_time")
  filenames_per.append("global_pose")
  filenames_per.append("ground_truth")

  for i in range(0, len(filenames_per)):
    src = exp_directory + filenames_per[i]
    dist = base_directory + str(idx) + "/" + filenames_per[i]
    print src
    print dist
    os.rename(src, dist)

  filenames_once = []
  filenames_once.append("image_format")
  filenames_once.append("image_size")
  filenames_once.append("map")
  filenames_once.append("num_particles")

  for i in range(0, len(filenames_once)):
    src = exp_directory + filenames_once[i]
    dist = base_directory + filenames_once[i]
    print src
    print dist
    os.rename(src, dist)


# ------------------------------------------------------------------------------
def main():

  run_experiments()


# ------------------------------------------------------------------------------
if __name__== "__main__":
  main()
