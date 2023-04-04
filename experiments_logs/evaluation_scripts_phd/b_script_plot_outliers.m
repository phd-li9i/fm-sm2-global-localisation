clear all
close all

store_outliers = 1;
here = '/home/li9i/catkin_ws/src/relief_fmt_global_localisation/experiments_logs/evaluation_scripts_phd/';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CORRIDOR
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fmt_corridor_base_str = 'vault/fmt/Centroid-based/noise_s=125/corridor/';
csm_corridor_base_str = 'vault/csm/corridor/';

fmt_corridor_pose_1_dir_2 = strcat(fmt_corridor_base_str, 'pose_1/noise_s=0.01/2020-03-02_13:43:25');
fmt_corridor_pose_1_dir_3 = strcat(fmt_corridor_base_str, 'pose_1/noise_s=0.02/2020-03-02_17:49:43');
fmt_corridor_pose_1_dir_4 = strcat(fmt_corridor_base_str, 'pose_1/noise_s=0.05/2020-03-02_22:07:58');

fmt_corridor_pose_2_dir_2 = strcat(fmt_corridor_base_str, 'pose_2/noise_s=0.01/2020-03-12_00:39:06');
fmt_corridor_pose_2_dir_3 = strcat(fmt_corridor_base_str, 'pose_2/noise_s=0.02/2020-03-11_18:52:08');
fmt_corridor_pose_2_dir_4 = strcat(fmt_corridor_base_str, 'pose_2/noise_s=0.05/2020-03-11_14:58:25');

fmt_corridor_pose_3_dir_2 = strcat(fmt_corridor_base_str, 'pose_3/noise_s=0.01/2020-03-19_00:19:00');
fmt_corridor_pose_3_dir_3 = strcat(fmt_corridor_base_str, 'pose_3/noise_s=0.02/2020-03-18_20:27:08');
fmt_corridor_pose_3_dir_4 = strcat(fmt_corridor_base_str, 'pose_3/noise_s=0.05/2020-03-18_15:58:54');

fmt_corridor_pose_1_dirs = {fmt_corridor_pose_1_dir_2, fmt_corridor_pose_1_dir_3, fmt_corridor_pose_1_dir_4};
fmt_corridor_pose_2_dirs = {fmt_corridor_pose_2_dir_2, fmt_corridor_pose_2_dir_3, fmt_corridor_pose_2_dir_4};
fmt_corridor_pose_3_dirs = {fmt_corridor_pose_3_dir_2, fmt_corridor_pose_3_dir_3, fmt_corridor_pose_3_dir_4};
fmt_corridor_poses = {fmt_corridor_pose_1_dirs; fmt_corridor_pose_2_dirs; fmt_corridor_pose_3_dirs};

csm_corridor_pose_1_dir_2 = strcat(csm_corridor_base_str, 'pose_1/noise_s=0.01/2020-02-04_10:27:18');
csm_corridor_pose_1_dir_3 = strcat(csm_corridor_base_str, 'pose_1/noise_s=0.02/2020-02-06_15:27:04');
csm_corridor_pose_1_dir_4 = strcat(csm_corridor_base_str, 'pose_1/noise_s=0.05/2020-02-04_12:34:10');

csm_corridor_pose_2_dir_2 = strcat(csm_corridor_base_str, 'pose_2/noise_s=0.01/2020-03-12_18:13:57');
csm_corridor_pose_2_dir_3 = strcat(csm_corridor_base_str, 'pose_2/noise_s=0.02/2020-03-12_22:10:31');
csm_corridor_pose_2_dir_4 = strcat(csm_corridor_base_str, 'pose_2/noise_s=0.05/2020-03-13_09:28:56');

csm_corridor_pose_3_dir_2 = strcat(csm_corridor_base_str, 'pose_3/noise_s=0.01/2020-03-17_14:58:06');
csm_corridor_pose_3_dir_3 = strcat(csm_corridor_base_str, 'pose_3/noise_s=0.02/2020-03-17_18:47:18');
csm_corridor_pose_3_dir_4 = strcat(csm_corridor_base_str, 'pose_3/noise_s=0.05/2020-03-18_00:57:45');

csm_corridor_pose_1_dirs = {csm_corridor_pose_1_dir_2, csm_corridor_pose_1_dir_3, csm_corridor_pose_1_dir_4};
csm_corridor_pose_2_dirs = {csm_corridor_pose_2_dir_2, csm_corridor_pose_2_dir_3, csm_corridor_pose_2_dir_4};
csm_corridor_pose_3_dirs = {csm_corridor_pose_3_dir_2, csm_corridor_pose_3_dir_3, csm_corridor_pose_3_dir_4};
csm_corridor_poses = {csm_corridor_pose_1_dirs; csm_corridor_pose_2_dirs; csm_corridor_pose_3_dirs};

fmt_corridor_xy_errors = [];
fmt_corridor_t_errors = [];
fmt_corridor_outliers = [];

csm_corridor_xy_errors = [];
csm_corridor_t_errors = [];
csm_corridor_outliers = [];


for r=1:size(fmt_corridor_poses,1)
  fmt_corridor_xy_errors_row = [];
  fmt_corridor_t_errors_row = [];
  fmt_corridor_outliers_row = [];
  csm_corridor_xy_errors_row = [];
  csm_corridor_t_errors_row = [];
  csm_corridor_outliers_row = [];

  for c=1:size(fmt_corridor_poses{1},2)
    [fmt_xy fmt_t fmt_et fmt_o] = function_top_level_script(fmt_corridor_poses{r}{c});
    [csm_xy csm_t csm_et csm_o] = function_top_level_script(csm_corridor_poses{r}{c});

    fmt_corridor_xy_errors_row = [fmt_corridor_xy_errors_row, fmt_xy];
    fmt_corridor_t_errors_row = [fmt_corridor_t_errors_row, fmt_t];
    fmt_corridor_outliers_row = [fmt_corridor_outliers_row, fmt_o];

    csm_corridor_xy_errors_row = [csm_corridor_xy_errors_row, csm_xy];
    csm_corridor_t_errors_row = [csm_corridor_t_errors_row, csm_t];
    csm_corridor_outliers_row = [csm_corridor_outliers_row, csm_o];

  end
  fmt_corridor_xy_errors = [fmt_corridor_xy_errors; fmt_corridor_xy_errors_row];
  fmt_corridor_t_errors = [fmt_corridor_t_errors; fmt_corridor_t_errors_row];
  fmt_corridor_outliers = [fmt_corridor_outliers; fmt_corridor_outliers_row];

  csm_corridor_xy_errors = [csm_corridor_xy_errors; csm_corridor_xy_errors_row];
  csm_corridor_t_errors = [csm_corridor_t_errors; csm_corridor_t_errors_row];
  csm_corridor_outliers = [csm_corridor_outliers; csm_corridor_outliers_row];

end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% home
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fmt_home_base_str = 'vault/fmt/Centroid-based/noise_s=125/home/';
csm_home_base_str = 'vault/csm/home/';

fmt_home_pose_1_dir_2 = strcat(fmt_home_base_str, 'pose_1/noise_s=0.01/2020-02-29_00:41:39');
fmt_home_pose_1_dir_3 = strcat(fmt_home_base_str, 'pose_1/noise_s=0.02/2020-02-29_14:51:19');
fmt_home_pose_1_dir_4 = strcat(fmt_home_base_str, 'pose_1/noise_s=0.05/2020-03-01_14:51:25');

fmt_home_pose_2_dir_2 = strcat(fmt_home_base_str, 'pose_2/noise_s=0.01/2020-03-19_22:09:40');
fmt_home_pose_2_dir_3 = strcat(fmt_home_base_str, 'pose_2/noise_s=0.02/2020-03-20_09:25:23');
fmt_home_pose_2_dir_4 = strcat(fmt_home_base_str, 'pose_2/noise_s=0.05/2020-03-20_16:25:12');

fmt_home_pose_3_dir_2 = strcat(fmt_home_base_str, 'pose_3/noise_s=0.01/2020-03-22_02:29:06');
fmt_home_pose_3_dir_3 = strcat(fmt_home_base_str, 'pose_3/noise_s=0.02/2020-03-22_11:50:58');
fmt_home_pose_3_dir_4 = strcat(fmt_home_base_str, 'pose_3/noise_s=0.05/2020-03-22_19:33:51');

fmt_home_pose_4_dir_2 = strcat(fmt_home_base_str, 'pose_4/noise_s=0.01/2020-03-24_16:50:29');
fmt_home_pose_4_dir_3 = strcat(fmt_home_base_str, 'pose_4/noise_s=0.02/2020-03-24_09:45:09');
fmt_home_pose_4_dir_4 = strcat(fmt_home_base_str, 'pose_4/noise_s=0.05/2020-03-23_21:31:05');

fmt_home_pose_5_dir_2 = strcat(fmt_home_base_str, 'pose_5/noise_s=0.01/2020-06-13_22:52:26');
fmt_home_pose_5_dir_3 = strcat(fmt_home_base_str, 'pose_5/noise_s=0.02/2020-06-12_12:42:45');
fmt_home_pose_5_dir_4 = strcat(fmt_home_base_str, 'pose_5/noise_s=0.05/2020-06-12_21:18:45');

fmt_home_pose_6_dir_2 = strcat(fmt_home_base_str, 'pose_6/noise_s=0.01/2020-03-27_23:22:45');
fmt_home_pose_6_dir_3 = strcat(fmt_home_base_str, 'pose_6/noise_s=0.02/2020-03-27_16:22:33');
fmt_home_pose_6_dir_4 = strcat(fmt_home_base_str, 'pose_6/noise_s=0.05/2020-03-27_09:26:12');

fmt_home_pose_7_dir_2 = strcat(fmt_home_base_str, 'pose_7/noise_s=0.01/2020-03-29_20:45:41');
fmt_home_pose_7_dir_3 = strcat(fmt_home_base_str, 'pose_7/noise_s=0.02/2020-03-29_13:41:55');
fmt_home_pose_7_dir_4 = strcat(fmt_home_base_str, 'pose_7/noise_s=0.05/2020-03-28_23:09:03');

fmt_home_pose_8_dir_2 = strcat(fmt_home_base_str, 'pose_8/noise_s=0.01/2020-06-10_13:00:10');
fmt_home_pose_8_dir_3 = strcat(fmt_home_base_str, 'pose_8/noise_s=0.02/2020-06-11_10:09:56');
fmt_home_pose_8_dir_4 = strcat(fmt_home_base_str, 'pose_8/noise_s=0.05/2020-06-11_18:49:26');

fmt_home_pose_9_dir_2 = strcat(fmt_home_base_str, 'pose_9/noise_s=0.01/2020-04-03_00:41:37');
fmt_home_pose_9_dir_3 = strcat(fmt_home_base_str, 'pose_9/noise_s=0.02/2020-04-02_17:23:49');
fmt_home_pose_9_dir_4 = strcat(fmt_home_base_str, 'pose_9/noise_s=0.05/2020-04-02_10:20:54');

fmt_home_pose_10_dir_2 = strcat(fmt_home_base_str, 'pose_10/noise_s=0.01/2020-04-04_19:33:55');
fmt_home_pose_10_dir_3 = strcat(fmt_home_base_str, 'pose_10/noise_s=0.02/2020-04-05_03:36:15');
fmt_home_pose_10_dir_4 = strcat(fmt_home_base_str, 'pose_10/noise_s=0.05/2020-04-05_14:31:27');

fmt_home_pose_11_dir_2 = strcat(fmt_home_base_str, 'pose_11/noise_s=0.01/2020-04-08_10:11:44');
fmt_home_pose_11_dir_3 = strcat(fmt_home_base_str, 'pose_11/noise_s=0.02/2020-04-07_23:04:27');
fmt_home_pose_11_dir_4 = strcat(fmt_home_base_str, 'pose_11/noise_s=0.05/2020-04-07_15:27:07');

fmt_home_pose_1_dirs = {fmt_home_pose_1_dir_2, fmt_home_pose_1_dir_3, fmt_home_pose_1_dir_4};
fmt_home_pose_2_dirs = {fmt_home_pose_2_dir_2, fmt_home_pose_2_dir_3, fmt_home_pose_2_dir_4};
fmt_home_pose_3_dirs = {fmt_home_pose_3_dir_2, fmt_home_pose_3_dir_3, fmt_home_pose_3_dir_4};
fmt_home_pose_4_dirs = {fmt_home_pose_4_dir_2, fmt_home_pose_4_dir_3, fmt_home_pose_4_dir_4};
fmt_home_pose_5_dirs = {fmt_home_pose_5_dir_2, fmt_home_pose_5_dir_3, fmt_home_pose_5_dir_4};
fmt_home_pose_6_dirs = {fmt_home_pose_6_dir_2, fmt_home_pose_6_dir_3, fmt_home_pose_6_dir_4};
fmt_home_pose_7_dirs = {fmt_home_pose_7_dir_2, fmt_home_pose_7_dir_3, fmt_home_pose_7_dir_4};
fmt_home_pose_8_dirs = {fmt_home_pose_8_dir_2, fmt_home_pose_8_dir_3, fmt_home_pose_8_dir_4};
fmt_home_pose_9_dirs = {fmt_home_pose_9_dir_2, fmt_home_pose_9_dir_3, fmt_home_pose_9_dir_4};
fmt_home_pose_10_dirs = {fmt_home_pose_10_dir_2, fmt_home_pose_10_dir_3, fmt_home_pose_10_dir_4};
fmt_home_pose_11_dirs = {fmt_home_pose_11_dir_2, fmt_home_pose_11_dir_3, fmt_home_pose_11_dir_4};
fmt_home_poses = {fmt_home_pose_1_dirs;
                  fmt_home_pose_2_dirs;
                  fmt_home_pose_3_dirs;
                  fmt_home_pose_4_dirs;
                  fmt_home_pose_5_dirs;
                  fmt_home_pose_6_dirs;
                  fmt_home_pose_7_dirs;
                  fmt_home_pose_8_dirs;
                  fmt_home_pose_9_dirs;
                  fmt_home_pose_10_dirs;
                  fmt_home_pose_11_dirs};


csm_home_pose_1_dir_2 = strcat(csm_home_base_str, 'pose_1/noise_s=0.01/2020-02-17_12:36:24');
csm_home_pose_1_dir_3 = strcat(csm_home_base_str, 'pose_1/noise_s=0.02/2020-02-14_16:17:33');
csm_home_pose_1_dir_4 = strcat(csm_home_base_str, 'pose_1/noise_s=0.05/2020-02-17_09:40:53');

csm_home_pose_2_dir_2 = strcat(csm_home_base_str, 'pose_2/noise_s=0.01/2020-03-21_12:32:16');
csm_home_pose_2_dir_3 = strcat(csm_home_base_str, 'pose_2/noise_s=0.02/2020-03-21_01:50:20');
csm_home_pose_2_dir_4 = strcat(csm_home_base_str, 'pose_2/noise_s=0.05/2020-03-20_23:21:33');

csm_home_pose_3_dir_2 = strcat(csm_home_base_str, 'pose_3/noise_s=0.01/2020-03-23_15:57:58');
csm_home_pose_3_dir_3 = strcat(csm_home_base_str, 'pose_3/noise_s=0.02/2020-03-23_13:08:04');
csm_home_pose_3_dir_4 = strcat(csm_home_base_str, 'pose_3/noise_s=0.05/2020-03-23_10:41:35');

csm_home_pose_4_dir_2 = strcat(csm_home_base_str, 'pose_4/noise_s=0.01/2020-03-25_09:48:03');
csm_home_pose_4_dir_3 = strcat(csm_home_base_str, 'pose_4/noise_s=0.02/2020-03-25_10:13:33');
csm_home_pose_4_dir_4 = strcat(csm_home_base_str, 'pose_4/noise_s=0.05/2020-03-25_10:30:21');

csm_home_pose_5_dir_2 = strcat(csm_home_base_str, 'pose_5/noise_s=0.01/2020-03-26_19:27:40');
csm_home_pose_5_dir_3 = strcat(csm_home_base_str, 'pose_5/noise_s=0.02/2020-03-26_22:00:47');
csm_home_pose_5_dir_4 = strcat(csm_home_base_str, 'pose_5/noise_s=0.05/2020-03-27_00:25:52');

csm_home_pose_6_dir_2 = strcat(csm_home_base_str, 'pose_6/noise_s=0.01/2020-03-28_21:46:50');
csm_home_pose_6_dir_3 = strcat(csm_home_base_str, 'pose_6/noise_s=0.02/2020-03-28_22:13:58');
csm_home_pose_6_dir_4 = strcat(csm_home_base_str, 'pose_6/noise_s=0.05/2020-03-28_22:49:17');

csm_home_pose_7_dir_2 = strcat(csm_home_base_str, 'pose_7/noise_s=0.01/2020-03-30_18:34:41');
csm_home_pose_7_dir_3 = strcat(csm_home_base_str, 'pose_7/noise_s=0.02/2020-03-30_21:02:52');
csm_home_pose_7_dir_4 = strcat(csm_home_base_str, 'pose_7/noise_s=0.05/2020-03-31_00:42:09');

csm_home_pose_8_dir_2 = strcat(csm_home_base_str, 'pose_8/noise_s=0.01/2020-04-01_19:35:35');
csm_home_pose_8_dir_3 = strcat(csm_home_base_str, 'pose_8/noise_s=0.02/2020-04-01_22:03:43');
csm_home_pose_8_dir_4 = strcat(csm_home_base_str, 'pose_8/noise_s=0.05/2020-04-02_00:51:59');

csm_home_pose_9_dir_2 = strcat(csm_home_base_str, 'pose_9/noise_s=0.01/2020-04-03_21:46:59');
csm_home_pose_9_dir_3 = strcat(csm_home_base_str, 'pose_9/noise_s=0.02/2020-04-03_19:15:27');
csm_home_pose_9_dir_4 = strcat(csm_home_base_str, 'pose_9/noise_s=0.05/2020-04-03_16:34:29');

csm_home_pose_10_dir_2 = strcat(csm_home_base_str, 'pose_10/noise_s=0.01/2020-04-06_09:49:56');
csm_home_pose_10_dir_3 = strcat(csm_home_base_str, 'pose_10/noise_s=0.02/2020-04-06_00:41:07');
csm_home_pose_10_dir_4 = strcat(csm_home_base_str, 'pose_10/noise_s=0.05/2020-04-05_21:53:56');

csm_home_pose_11_dir_2 = strcat(csm_home_base_str, 'pose_11/noise_s=0.01/2020-04-06_22:30:50');
csm_home_pose_11_dir_3 = strcat(csm_home_base_str, 'pose_11/noise_s=0.02/2020-04-07_09:27:07');
csm_home_pose_11_dir_4 = strcat(csm_home_base_str, 'pose_11/noise_s=0.05/2020-04-07_12:12:21');

csm_home_pose_1_dirs = {csm_home_pose_1_dir_2, csm_home_pose_1_dir_3, csm_home_pose_1_dir_4};
csm_home_pose_2_dirs = {csm_home_pose_2_dir_2, csm_home_pose_2_dir_3, csm_home_pose_2_dir_4};
csm_home_pose_3_dirs = {csm_home_pose_3_dir_2, csm_home_pose_3_dir_3, csm_home_pose_3_dir_4};
csm_home_pose_4_dirs = {csm_home_pose_4_dir_2, csm_home_pose_4_dir_3, csm_home_pose_4_dir_4};
csm_home_pose_5_dirs = {csm_home_pose_5_dir_2, csm_home_pose_5_dir_3, csm_home_pose_5_dir_4};
csm_home_pose_6_dirs = {csm_home_pose_6_dir_2, csm_home_pose_6_dir_3, csm_home_pose_6_dir_4};
csm_home_pose_7_dirs = {csm_home_pose_7_dir_2, csm_home_pose_7_dir_3, csm_home_pose_7_dir_4};
csm_home_pose_8_dirs = {csm_home_pose_8_dir_2, csm_home_pose_8_dir_3, csm_home_pose_8_dir_4};
csm_home_pose_9_dirs = {csm_home_pose_9_dir_2, csm_home_pose_9_dir_3, csm_home_pose_9_dir_4};
csm_home_pose_10_dirs = {csm_home_pose_10_dir_2, csm_home_pose_10_dir_3, csm_home_pose_10_dir_4};
csm_home_pose_11_dirs = {csm_home_pose_11_dir_2, csm_home_pose_11_dir_3, csm_home_pose_11_dir_4};
csm_home_poses = {csm_home_pose_1_dirs;
                  csm_home_pose_2_dirs;
                  csm_home_pose_3_dirs;
                  csm_home_pose_4_dirs;
                  csm_home_pose_5_dirs;
                  csm_home_pose_6_dirs;
                  csm_home_pose_7_dirs;
                  csm_home_pose_8_dirs;
                  csm_home_pose_9_dirs;
                  csm_home_pose_10_dirs;
                  csm_home_pose_11_dirs};


fmt_home_xy_errors = [];
fmt_home_t_errors = [];
fmt_home_outliers = [];

csm_home_xy_errors = [];
csm_home_t_errors = [];
csm_home_outliers = [];


for r=1:size(fmt_home_poses,1)
  fmt_home_xy_errors_row = [];
  fmt_home_t_errors_row = [];
  fmt_home_outliers_row = [];
  csm_home_xy_errors_row = [];
  csm_home_t_errors_row = [];
  csm_home_outliers_row = [];

  for c=1:size(fmt_home_poses{1},2)
    [fmt_xy fmt_t fmt_et fmt_o] = function_top_level_script(fmt_home_poses{r}{c});
    [csm_xy csm_t csm_et csm_o] = function_top_level_script(csm_home_poses{r}{c});

    fmt_home_xy_errors_row = [fmt_home_xy_errors_row, fmt_xy];
    fmt_home_t_errors_row = [fmt_home_t_errors_row, fmt_t];
    fmt_home_outliers_row = [fmt_home_outliers_row, fmt_o];

    csm_home_xy_errors_row = [csm_home_xy_errors_row, csm_xy];
    csm_home_t_errors_row = [csm_home_t_errors_row, csm_t];
    csm_home_outliers_row = [csm_home_outliers_row, csm_o];

  end
  fmt_home_xy_errors = [fmt_home_xy_errors; fmt_home_xy_errors_row];
  fmt_home_t_errors = [fmt_home_t_errors; fmt_home_t_errors_row];
  fmt_home_outliers = [fmt_home_outliers; fmt_home_outliers_row];

  csm_home_xy_errors = [csm_home_xy_errors; csm_home_xy_errors_row];
  csm_home_t_errors = [csm_home_t_errors; csm_home_t_errors_row];
  csm_home_outliers = [csm_home_outliers; csm_home_outliers_row];

end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% warehouse
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fmt_warehouse_base_str = 'vault/fmt/Centroid-based/noise_s=125/warehouse/';
csm_warehouse_base_str = 'vault/csm/warehouse/';

fmt_warehouse_pose_1_dir_2 = strcat(fmt_warehouse_base_str, 'pose_1/noise_s=0.01/2020-03-03_19:04:07');
fmt_warehouse_pose_1_dir_3 = strcat(fmt_warehouse_base_str, 'pose_1/noise_s=0.02/2020-03-04_09:57:09');
fmt_warehouse_pose_1_dir_4 = strcat(fmt_warehouse_base_str, 'pose_1/noise_s=0.05/2020-03-04_16:51:48');

fmt_warehouse_pose_2_dir_2 = strcat(fmt_warehouse_base_str, 'pose_2/noise_s=0.01/2020-04-09_21:06:46');
fmt_warehouse_pose_2_dir_3 = strcat(fmt_warehouse_base_str, 'pose_2/noise_s=0.02/2020-04-09_12:47:12');
fmt_warehouse_pose_2_dir_4 = strcat(fmt_warehouse_base_str, 'pose_2/noise_s=0.05/2020-04-10_16:06:36');

fmt_warehouse_pose_3_dir_2 = strcat(fmt_warehouse_base_str, 'pose_3/noise_s=0.01/2020-04-12_03:49:15');
fmt_warehouse_pose_3_dir_3 = strcat(fmt_warehouse_base_str, 'pose_3/noise_s=0.02/2020-04-12_13:46:23');
fmt_warehouse_pose_3_dir_4 = strcat(fmt_warehouse_base_str, 'pose_3/noise_s=0.05/2020-04-12_21:32:37');

fmt_warehouse_pose_4_dir_2 = strcat(fmt_warehouse_base_str, 'pose_4/noise_s=0.01/2020-04-14_10:01:20');
fmt_warehouse_pose_4_dir_3 = strcat(fmt_warehouse_base_str, 'pose_4/noise_s=0.02/2020-04-14_17:32:49');
fmt_warehouse_pose_4_dir_4 = strcat(fmt_warehouse_base_str, 'pose_4/noise_s=0.05/2020-04-15_02:41:05');

fmt_warehouse_pose_5_dir_2 = strcat(fmt_warehouse_base_str, 'pose_5/noise_s=0.01/2020-04-17_09:58:04');
fmt_warehouse_pose_5_dir_3 = strcat(fmt_warehouse_base_str, 'pose_5/noise_s=0.02/2020-04-17_18:54:25');
fmt_warehouse_pose_5_dir_4 = strcat(fmt_warehouse_base_str, 'pose_5/noise_s=0.05/2020-04-18_11:54:10');

fmt_warehouse_pose_6_dir_2 = strcat(fmt_warehouse_base_str, 'pose_6/noise_s=0.01/2020-04-19_20:42:25');
fmt_warehouse_pose_6_dir_3 = strcat(fmt_warehouse_base_str, 'pose_6/noise_s=0.02/2020-04-19_12:39:20');
fmt_warehouse_pose_6_dir_4 = strcat(fmt_warehouse_base_str, 'pose_6/noise_s=0.05/2020-04-18_20:40:12');

fmt_warehouse_pose_7_dir_2 = strcat(fmt_warehouse_base_str, 'pose_7/noise_s=0.01/2020-04-22_21:04:50');
fmt_warehouse_pose_7_dir_3 = strcat(fmt_warehouse_base_str, 'pose_7/noise_s=0.02/2020-04-23_10:32:30');
fmt_warehouse_pose_7_dir_4 = strcat(fmt_warehouse_base_str, 'pose_7/noise_s=0.05/2020-04-23_17:57:47');

fmt_warehouse_pose_1_dirs = {fmt_warehouse_pose_1_dir_2, fmt_warehouse_pose_1_dir_3, fmt_warehouse_pose_1_dir_4};
fmt_warehouse_pose_2_dirs = {fmt_warehouse_pose_2_dir_2, fmt_warehouse_pose_2_dir_3, fmt_warehouse_pose_2_dir_4};
fmt_warehouse_pose_3_dirs = {fmt_warehouse_pose_3_dir_2, fmt_warehouse_pose_3_dir_3, fmt_warehouse_pose_3_dir_4};
fmt_warehouse_pose_4_dirs = {fmt_warehouse_pose_4_dir_2, fmt_warehouse_pose_4_dir_3, fmt_warehouse_pose_4_dir_4};
fmt_warehouse_pose_5_dirs = {fmt_warehouse_pose_5_dir_2, fmt_warehouse_pose_5_dir_3, fmt_warehouse_pose_5_dir_4};
fmt_warehouse_pose_6_dirs = {fmt_warehouse_pose_6_dir_2, fmt_warehouse_pose_6_dir_3, fmt_warehouse_pose_6_dir_4};
fmt_warehouse_pose_7_dirs = {fmt_warehouse_pose_7_dir_2, fmt_warehouse_pose_7_dir_3, fmt_warehouse_pose_7_dir_4};
fmt_warehouse_poses = {fmt_warehouse_pose_1_dirs;
                  fmt_warehouse_pose_2_dirs;
                  fmt_warehouse_pose_3_dirs;
                  fmt_warehouse_pose_4_dirs;
                  fmt_warehouse_pose_5_dirs;
                  fmt_warehouse_pose_6_dirs;
                  fmt_warehouse_pose_7_dirs};


csm_warehouse_pose_1_dir_2 = strcat(csm_warehouse_base_str, 'pose_1/noise_s=0.01/2020-02-18_15:30:38');
csm_warehouse_pose_1_dir_3 = strcat(csm_warehouse_base_str, 'pose_1/noise_s=0.02/2020-02-18_19:01:13');
csm_warehouse_pose_1_dir_4 = strcat(csm_warehouse_base_str, 'pose_1/noise_s=0.05/2020-02-18_22:27:41');

csm_warehouse_pose_2_dir_2 = strcat(csm_warehouse_base_str, 'pose_2/noise_s=0.01/2020-04-11_12:32:05');
csm_warehouse_pose_2_dir_3 = strcat(csm_warehouse_base_str, 'pose_2/noise_s=0.02/2020-04-11_03:20:02');
csm_warehouse_pose_2_dir_4 = strcat(csm_warehouse_base_str, 'pose_2/noise_s=0.05/2020-04-10_23:05:03');

csm_warehouse_pose_3_dir_2 = strcat(csm_warehouse_base_str, 'pose_3/noise_s=0.01/2020-04-13_15:14:05');
csm_warehouse_pose_3_dir_3 = strcat(csm_warehouse_base_str, 'pose_3/noise_s=0.02/2020-04-13_12:26:42');
csm_warehouse_pose_3_dir_4 = strcat(csm_warehouse_base_str, 'pose_3/noise_s=0.05/2020-04-13_09:40:39');

csm_warehouse_pose_4_dir_2 = strcat(csm_warehouse_base_str, 'pose_4/noise_s=0.01/2020-04-15_13:18:07');
csm_warehouse_pose_4_dir_3 = strcat(csm_warehouse_base_str, 'pose_4/noise_s=0.02/2020-04-15_16:55:41');
csm_warehouse_pose_4_dir_4 = strcat(csm_warehouse_base_str, 'pose_4/noise_s=0.05/2020-04-15_20:00:49');

csm_warehouse_pose_5_dir_2 = strcat(csm_warehouse_base_str, 'pose_5/noise_s=0.01/2020-04-16_17:00:25');
csm_warehouse_pose_5_dir_3 = strcat(csm_warehouse_base_str, 'pose_5/noise_s=0.02/2020-04-16_14:12:22');
csm_warehouse_pose_5_dir_4 = strcat(csm_warehouse_base_str, 'pose_5/noise_s=0.05/2020-04-16_11:18:29');

csm_warehouse_pose_6_dir_2 = strcat(csm_warehouse_base_str, 'pose_6/noise_s=0.01/2020-04-20_19:56:36');
csm_warehouse_pose_6_dir_3 = strcat(csm_warehouse_base_str, 'pose_6/noise_s=0.02/2020-04-20_23:25:54');
csm_warehouse_pose_6_dir_4 = strcat(csm_warehouse_base_str, 'pose_6/noise_s=0.05/2020-04-21_10:12:35');

csm_warehouse_pose_7_dir_2 = strcat(csm_warehouse_base_str, 'pose_7/noise_s=0.01/2020-04-21_22:19:52');
csm_warehouse_pose_7_dir_3 = strcat(csm_warehouse_base_str, 'pose_7/noise_s=0.02/2020-04-21_19:31:55');
csm_warehouse_pose_7_dir_4 = strcat(csm_warehouse_base_str, 'pose_7/noise_s=0.05/2020-04-21_15:20:14');

csm_warehouse_pose_1_dirs = {csm_warehouse_pose_1_dir_2, csm_warehouse_pose_1_dir_3, csm_warehouse_pose_1_dir_4};
csm_warehouse_pose_2_dirs = {csm_warehouse_pose_2_dir_2, csm_warehouse_pose_2_dir_3, csm_warehouse_pose_2_dir_4};
csm_warehouse_pose_3_dirs = {csm_warehouse_pose_3_dir_2, csm_warehouse_pose_3_dir_3, csm_warehouse_pose_3_dir_4};
csm_warehouse_pose_4_dirs = {csm_warehouse_pose_4_dir_2, csm_warehouse_pose_4_dir_3, csm_warehouse_pose_4_dir_4};
csm_warehouse_pose_5_dirs = {csm_warehouse_pose_5_dir_2, csm_warehouse_pose_5_dir_3, csm_warehouse_pose_5_dir_4};
csm_warehouse_pose_6_dirs = {csm_warehouse_pose_6_dir_2, csm_warehouse_pose_6_dir_3, csm_warehouse_pose_6_dir_4};
csm_warehouse_pose_7_dirs = {csm_warehouse_pose_7_dir_2, csm_warehouse_pose_7_dir_3, csm_warehouse_pose_7_dir_4};
csm_warehouse_poses = {csm_warehouse_pose_1_dirs;
                  csm_warehouse_pose_2_dirs;
                  csm_warehouse_pose_3_dirs;
                  csm_warehouse_pose_4_dirs;
                  csm_warehouse_pose_5_dirs;
                  csm_warehouse_pose_6_dirs;
                  csm_warehouse_pose_7_dirs};



fmt_warehouse_xy_errors = [];
fmt_warehouse_t_errors = [];
fmt_warehouse_outliers = [];

csm_warehouse_xy_errors = [];
csm_warehouse_t_errors = [];
csm_warehouse_outliers = [];


for r=1:size(fmt_warehouse_poses,1)
  fmt_warehouse_xy_errors_row = [];
  fmt_warehouse_t_errors_row = [];
  fmt_warehouse_outliers_row = [];
  csm_warehouse_xy_errors_row = [];
  csm_warehouse_t_errors_row = [];
  csm_warehouse_outliers_row = [];

  for c=1:size(fmt_warehouse_poses{1},2)
    [fmt_xy fmt_t fmt_et fmt_o] = function_top_level_script(fmt_warehouse_poses{r}{c});
    [csm_xy csm_t csm_et csm_o] = function_top_level_script(csm_warehouse_poses{r}{c});

    fmt_warehouse_xy_errors_row = [fmt_warehouse_xy_errors_row, fmt_xy];
    fmt_warehouse_t_errors_row = [fmt_warehouse_t_errors_row, fmt_t];
    fmt_warehouse_outliers_row = [fmt_warehouse_outliers_row, fmt_o];

    csm_warehouse_xy_errors_row = [csm_warehouse_xy_errors_row, csm_xy];
    csm_warehouse_t_errors_row = [csm_warehouse_t_errors_row, csm_t];
    csm_warehouse_outliers_row = [csm_warehouse_outliers_row, csm_o];

  end
  fmt_warehouse_xy_errors = [fmt_warehouse_xy_errors; fmt_warehouse_xy_errors_row];
  fmt_warehouse_t_errors = [fmt_warehouse_t_errors; fmt_warehouse_t_errors_row];
  fmt_warehouse_outliers = [fmt_warehouse_outliers; fmt_warehouse_outliers_row];

  csm_warehouse_xy_errors = [csm_warehouse_xy_errors; csm_warehouse_xy_errors_row];
  csm_warehouse_t_errors = [csm_warehouse_t_errors; csm_warehouse_t_errors_row];
  csm_warehouse_outliers = [csm_warehouse_outliers; csm_warehouse_outliers_row];

end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% willowgarage
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fmt_willowgarage_base_str = 'vault/fmt/Centroid-based/noise_s=125/willowgarage/';
csm_willowgarage_base_str = 'vault/csm/willowgarage/';

fmt_willowgarage_pose_1_dir_2 = strcat(fmt_willowgarage_base_str, 'pose_1/noise_s=0.01/2020-03-06_09:53:14');
fmt_willowgarage_pose_1_dir_3 = strcat(fmt_willowgarage_base_str, 'pose_1/noise_s=0.02/2020-03-06_21:25:00');
fmt_willowgarage_pose_1_dir_4 = strcat(fmt_willowgarage_base_str, 'pose_1/noise_s=0.05/2020-03-07_11:10:20');

fmt_willowgarage_pose_2_dir_2 = strcat(fmt_willowgarage_base_str, 'pose_2/noise_s=0.01/2020-04-28_15:28:06');
fmt_willowgarage_pose_2_dir_3 = strcat(fmt_willowgarage_base_str, 'pose_2/noise_s=0.02/2020-04-28_02:20:42');
fmt_willowgarage_pose_2_dir_4 = strcat(fmt_willowgarage_base_str, 'pose_2/noise_s=0.05/2020-04-27_11:23:22');

fmt_willowgarage_pose_3_dir_2 = strcat(fmt_willowgarage_base_str, 'pose_3/noise_s=0.01/2020-05-04_03:16:21');
fmt_willowgarage_pose_3_dir_3 = strcat(fmt_willowgarage_base_str, 'pose_3/noise_s=0.02/2020-05-03_14:55:59');
fmt_willowgarage_pose_3_dir_4 = strcat(fmt_willowgarage_base_str, 'pose_3/noise_s=0.05/2020-05-02_19:26:17');

fmt_willowgarage_pose_4_dir_2 = strcat(fmt_willowgarage_base_str, 'pose_4/noise_s=0.01/2020-05-13_17:00:41');
fmt_willowgarage_pose_4_dir_3 = strcat(fmt_willowgarage_base_str, 'pose_4/noise_s=0.02/2020-05-13_01:41:43');
fmt_willowgarage_pose_4_dir_4 = strcat(fmt_willowgarage_base_str, 'pose_4/noise_s=0.05/2020-05-12_10:09:45');

fmt_willowgarage_pose_5_dir_2 = strcat(fmt_willowgarage_base_str, 'pose_5/noise_s=0.01/2020-05-18_10:54:29');
fmt_willowgarage_pose_5_dir_3 = strcat(fmt_willowgarage_base_str, 'pose_5/noise_s=0.02/2020-05-18_23:57:28');
fmt_willowgarage_pose_5_dir_4 = strcat(fmt_willowgarage_base_str, 'pose_5/noise_s=0.05/2020-05-19_13:49:46');

fmt_willowgarage_pose_6_dir_2 = strcat(fmt_willowgarage_base_str, 'pose_6/noise_s=0.01/2020-05-21_15:13:01');
fmt_willowgarage_pose_6_dir_3 = strcat(fmt_willowgarage_base_str, 'pose_6/noise_s=0.02/2020-05-21_01:41:00');
fmt_willowgarage_pose_6_dir_4 = strcat(fmt_willowgarage_base_str, 'pose_6/noise_s=0.05/2020-05-20_11:58:34');

fmt_willowgarage_pose_7_dir_2 = strcat(fmt_willowgarage_base_str, 'pose_7/noise_s=0.01/2020-05-26_23:57:36');
fmt_willowgarage_pose_7_dir_3 = strcat(fmt_willowgarage_base_str, 'pose_7/noise_s=0.02/2020-05-26_10:53:10');
fmt_willowgarage_pose_7_dir_4 = strcat(fmt_willowgarage_base_str, 'pose_7/noise_s=0.05/2020-05-25_15:13:10');

fmt_willowgarage_pose_8_dir_2 = strcat(fmt_willowgarage_base_str, 'pose_8/noise_s=0.01/2020-06-02_15:09:49');
fmt_willowgarage_pose_8_dir_3 = strcat(fmt_willowgarage_base_str, 'pose_8/noise_s=0.02/2020-06-02_02:02:40');
fmt_willowgarage_pose_8_dir_4 = strcat(fmt_willowgarage_base_str, 'pose_8/noise_s=0.05/2020-06-01_11:47:00');

fmt_willowgarage_pose_9_dir_2 = strcat(fmt_willowgarage_base_str, 'pose_9/noise_s=0.01/2020-06-17_10:32:36');
fmt_willowgarage_pose_9_dir_3 = strcat(fmt_willowgarage_base_str, 'pose_9/noise_s=0.02/2020-06-18_01:05:53');
fmt_willowgarage_pose_9_dir_4 = strcat(fmt_willowgarage_base_str, 'pose_9/noise_s=0.05/2020-06-18_14:35:53');

fmt_willowgarage_pose_10_dir_2 = strcat(fmt_willowgarage_base_str, 'pose_10/noise_s=0.01/2020-06-23_11:05:58');
fmt_willowgarage_pose_10_dir_3 = strcat(fmt_willowgarage_base_str, 'pose_10/noise_s=0.02/2020-06-22_14:12:20');
fmt_willowgarage_pose_10_dir_4 = strcat(fmt_willowgarage_base_str, 'pose_10/noise_s=0.05/2020-06-22_01:01:07');


fmt_willowgarage_pose_1_dirs = {fmt_willowgarage_pose_1_dir_2, fmt_willowgarage_pose_1_dir_3, fmt_willowgarage_pose_1_dir_4};
fmt_willowgarage_pose_2_dirs = {fmt_willowgarage_pose_2_dir_2, fmt_willowgarage_pose_2_dir_3, fmt_willowgarage_pose_2_dir_4};
fmt_willowgarage_pose_3_dirs = {fmt_willowgarage_pose_3_dir_2, fmt_willowgarage_pose_3_dir_3, fmt_willowgarage_pose_3_dir_4};
fmt_willowgarage_pose_4_dirs = {fmt_willowgarage_pose_4_dir_2, fmt_willowgarage_pose_4_dir_3, fmt_willowgarage_pose_4_dir_4};
fmt_willowgarage_pose_5_dirs = {fmt_willowgarage_pose_5_dir_2, fmt_willowgarage_pose_5_dir_3, fmt_willowgarage_pose_5_dir_4};
fmt_willowgarage_pose_6_dirs = {fmt_willowgarage_pose_6_dir_2, fmt_willowgarage_pose_6_dir_3, fmt_willowgarage_pose_6_dir_4};
fmt_willowgarage_pose_7_dirs = {fmt_willowgarage_pose_7_dir_2, fmt_willowgarage_pose_7_dir_3, fmt_willowgarage_pose_7_dir_4};
fmt_willowgarage_pose_8_dirs = {fmt_willowgarage_pose_8_dir_2, fmt_willowgarage_pose_8_dir_3, fmt_willowgarage_pose_8_dir_4};
fmt_willowgarage_pose_9_dirs = {fmt_willowgarage_pose_9_dir_2, fmt_willowgarage_pose_9_dir_3, fmt_willowgarage_pose_9_dir_4};
fmt_willowgarage_pose_10_dirs = {fmt_willowgarage_pose_10_dir_2, fmt_willowgarage_pose_10_dir_3, fmt_willowgarage_pose_10_dir_4};
fmt_willowgarage_poses = {fmt_willowgarage_pose_1_dirs;
                  fmt_willowgarage_pose_2_dirs;
                  fmt_willowgarage_pose_3_dirs;
                  fmt_willowgarage_pose_4_dirs;
                  fmt_willowgarage_pose_5_dirs;
                  fmt_willowgarage_pose_6_dirs;
                  fmt_willowgarage_pose_7_dirs;
                  fmt_willowgarage_pose_8_dirs;
                  fmt_willowgarage_pose_9_dirs;
                  fmt_willowgarage_pose_10_dirs};


csm_willowgarage_pose_1_dir_2 = strcat(csm_willowgarage_base_str, 'pose_1/noise_s=0.01/2020-03-09_14:20:59');
csm_willowgarage_pose_1_dir_3 = strcat(csm_willowgarage_base_str, 'pose_1/noise_s=0.02/2020-03-09_16:47:45');
csm_willowgarage_pose_1_dir_4 = strcat(csm_willowgarage_base_str, 'pose_1/noise_s=0.05/2020-03-09_19:15:13');

csm_willowgarage_pose_2_dir_2 = strcat(csm_willowgarage_base_str, 'pose_2/noise_s=0.01/2020-04-30_15:19:27');
csm_willowgarage_pose_2_dir_3 = strcat(csm_willowgarage_base_str, 'pose_2/noise_s=0.02/2020-04-30_21:40:38');
csm_willowgarage_pose_2_dir_4 = strcat(csm_willowgarage_base_str, 'pose_2/noise_s=0.05/2020-05-02_00:05:56');

csm_willowgarage_pose_3_dir_2 = strcat(csm_willowgarage_base_str, 'pose_3/noise_s=0.01/2020-05-05_15:41:14');
csm_willowgarage_pose_3_dir_3 = strcat(csm_willowgarage_base_str, 'pose_3/noise_s=0.02/2020-05-05_20:57:25');
csm_willowgarage_pose_3_dir_4 = strcat(csm_willowgarage_base_str, 'pose_3/noise_s=0.05/2020-05-06_10:03:08');

csm_willowgarage_pose_4_dir_2 = strcat(csm_willowgarage_base_str, 'pose_4/noise_s=0.01/2020-05-15_14:41:34');
csm_willowgarage_pose_4_dir_3 = strcat(csm_willowgarage_base_str, 'pose_4/noise_s=0.02/2020-05-15_20:26:15');
csm_willowgarage_pose_4_dir_4 = strcat(csm_willowgarage_base_str, 'pose_4/noise_s=0.05/2020-05-16_00:44:39');

csm_willowgarage_pose_5_dir_2 = strcat(csm_willowgarage_base_str, 'pose_5/noise_s=0.01/2020-05-16_22:08:10');
csm_willowgarage_pose_5_dir_3 = strcat(csm_willowgarage_base_str, 'pose_5/noise_s=0.02/2020-05-16_17:49:27');
csm_willowgarage_pose_5_dir_4 = strcat(csm_willowgarage_base_str, 'pose_5/noise_s=0.05/2020-05-16_14:03:59');

csm_willowgarage_pose_6_dir_2 = strcat(csm_willowgarage_base_str, 'pose_6/noise_s=0.01/2020-05-23_13:38:56');
csm_willowgarage_pose_6_dir_3 = strcat(csm_willowgarage_base_str, 'pose_6/noise_s=0.02/2020-05-23_18:02:10');
csm_willowgarage_pose_6_dir_4 = strcat(csm_willowgarage_base_str, 'pose_6/noise_s=0.05/2020-05-23_21:56:11');

csm_willowgarage_pose_7_dir_2 = strcat(csm_willowgarage_base_str, 'pose_7/noise_s=0.01/2020-05-28_15:27:10');
csm_willowgarage_pose_7_dir_3 = strcat(csm_willowgarage_base_str, 'pose_7/noise_s=0.02/2020-05-28_20:21:35');
csm_willowgarage_pose_7_dir_4 = strcat(csm_willowgarage_base_str, 'pose_7/noise_s=0.05/2020-05-29_00:35:12');

csm_willowgarage_pose_8_dir_2 = strcat(csm_willowgarage_base_str, 'pose_8/noise_s=0.01/2020-06-04_16:06:56');
csm_willowgarage_pose_8_dir_3 = strcat(csm_willowgarage_base_str, 'pose_8/noise_s=0.02/2020-06-05_10:50:30');
csm_willowgarage_pose_8_dir_4 = strcat(csm_willowgarage_base_str, 'pose_8/noise_s=0.05/2020-06-06_20:22:08');

csm_willowgarage_pose_9_dir_2 = strcat(csm_willowgarage_base_str, 'pose_9/noise_s=0.01/2020-06-19_18:15:56');
csm_willowgarage_pose_9_dir_3 = strcat(csm_willowgarage_base_str, 'pose_9/noise_s=0.02/2020-06-19_14:21:47');
csm_willowgarage_pose_9_dir_4 = strcat(csm_willowgarage_base_str, 'pose_9/noise_s=0.05/2020-06-19_10:19:51');

csm_willowgarage_pose_10_dir_2 = strcat(csm_willowgarage_base_str, 'pose_10/noise_s=0.01/2020-06-21_11:47:37');
csm_willowgarage_pose_10_dir_3 = strcat(csm_willowgarage_base_str, 'pose_10/noise_s=0.02/2020-06-21_17:17:16');
csm_willowgarage_pose_10_dir_4 = strcat(csm_willowgarage_base_str, 'pose_10/noise_s=0.05/2020-06-21_21:09:28');


csm_willowgarage_pose_1_dirs = {csm_willowgarage_pose_1_dir_2, csm_willowgarage_pose_1_dir_3, csm_willowgarage_pose_1_dir_4};
csm_willowgarage_pose_2_dirs = {csm_willowgarage_pose_2_dir_2, csm_willowgarage_pose_2_dir_3, csm_willowgarage_pose_2_dir_4};
csm_willowgarage_pose_3_dirs = {csm_willowgarage_pose_3_dir_2, csm_willowgarage_pose_3_dir_3, csm_willowgarage_pose_3_dir_4};
csm_willowgarage_pose_4_dirs = {csm_willowgarage_pose_4_dir_2, csm_willowgarage_pose_4_dir_3, csm_willowgarage_pose_4_dir_4};
csm_willowgarage_pose_5_dirs = {csm_willowgarage_pose_5_dir_2, csm_willowgarage_pose_5_dir_3, csm_willowgarage_pose_5_dir_4};
csm_willowgarage_pose_6_dirs = {csm_willowgarage_pose_6_dir_2, csm_willowgarage_pose_6_dir_3, csm_willowgarage_pose_6_dir_4};
csm_willowgarage_pose_7_dirs = {csm_willowgarage_pose_7_dir_2, csm_willowgarage_pose_7_dir_3, csm_willowgarage_pose_7_dir_4};
csm_willowgarage_pose_8_dirs = {csm_willowgarage_pose_8_dir_2, csm_willowgarage_pose_8_dir_3, csm_willowgarage_pose_8_dir_4};
csm_willowgarage_pose_9_dirs = {csm_willowgarage_pose_9_dir_2, csm_willowgarage_pose_9_dir_3, csm_willowgarage_pose_9_dir_4};
csm_willowgarage_pose_10_dirs = {csm_willowgarage_pose_10_dir_2, csm_willowgarage_pose_10_dir_3, csm_willowgarage_pose_10_dir_4};
csm_willowgarage_poses = {csm_willowgarage_pose_1_dirs;
                  csm_willowgarage_pose_2_dirs;
                  csm_willowgarage_pose_3_dirs;
                  csm_willowgarage_pose_4_dirs;
                  csm_willowgarage_pose_5_dirs;
                  csm_willowgarage_pose_6_dirs;
                  csm_willowgarage_pose_7_dirs;
                  csm_willowgarage_pose_8_dirs;
                  csm_willowgarage_pose_9_dirs;
                  csm_willowgarage_pose_10_dirs};



fmt_willowgarage_xy_errors = [];
fmt_willowgarage_t_errors = [];
fmt_willowgarage_outliers = [];

csm_willowgarage_xy_errors = [];
csm_willowgarage_t_errors = [];
csm_willowgarage_outliers = [];


for r=1:size(fmt_willowgarage_poses,1)
  fmt_willowgarage_xy_errors_row = [];
  fmt_willowgarage_t_errors_row = [];
  fmt_willowgarage_outliers_row = [];
  csm_willowgarage_xy_errors_row = [];
  csm_willowgarage_t_errors_row = [];
  csm_willowgarage_outliers_row = [];

  for c=1:size(fmt_willowgarage_poses{1},2)
    [fmt_xy fmt_t fmt_et fmt_o] = function_top_level_script(fmt_willowgarage_poses{r}{c});
    [csm_xy csm_t csm_et csm_o] = function_top_level_script(csm_willowgarage_poses{r}{c});

    fmt_willowgarage_xy_errors_row = [fmt_willowgarage_xy_errors_row, fmt_xy];
    fmt_willowgarage_t_errors_row = [fmt_willowgarage_t_errors_row, fmt_t];
    fmt_willowgarage_outliers_row = [fmt_willowgarage_outliers_row, fmt_o];

    csm_willowgarage_xy_errors_row = [csm_willowgarage_xy_errors_row, csm_xy];
    csm_willowgarage_t_errors_row = [csm_willowgarage_t_errors_row, csm_t];
    csm_willowgarage_outliers_row = [csm_willowgarage_outliers_row, csm_o];

  end
  fmt_willowgarage_xy_errors = [fmt_willowgarage_xy_errors; fmt_willowgarage_xy_errors_row];
  fmt_willowgarage_t_errors = [fmt_willowgarage_t_errors; fmt_willowgarage_t_errors_row];
  fmt_willowgarage_outliers = [fmt_willowgarage_outliers; fmt_willowgarage_outliers_row];

  csm_willowgarage_xy_errors = [csm_willowgarage_xy_errors; csm_willowgarage_xy_errors_row];
  csm_willowgarage_t_errors = [csm_willowgarage_t_errors; csm_willowgarage_t_errors_row];
  csm_willowgarage_outliers = [csm_willowgarage_outliers; csm_willowgarage_outliers_row];

end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% landfill
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fmt_landfill_base_str = 'vault/fmt/Centroid-based/noise_s=125/dirtrack/';
csm_landfill_base_str = 'vault/csm/dirtrack/';

fmt_landfill_pose_1_dir_2 = strcat(fmt_landfill_base_str, 'pose_1/noise_s=0.01/2020-11-01_02:23:58');
fmt_landfill_pose_1_dir_3 = strcat(fmt_landfill_base_str, 'pose_1/noise_s=0.02/2020-11-01_13:13:11');
fmt_landfill_pose_1_dir_4 = strcat(fmt_landfill_base_str, 'pose_1/noise_s=0.05/2020-11-01_18:32:10');

fmt_landfill_pose_2_dir_2 = strcat(fmt_landfill_base_str, 'pose_2/noise_s=0.01/2020-11-02_10:35:55');
fmt_landfill_pose_2_dir_3 = strcat(fmt_landfill_base_str, 'pose_2/noise_s=0.02/2020-11-02_16:08:14');
fmt_landfill_pose_2_dir_4 = strcat(fmt_landfill_base_str, 'pose_2/noise_s=0.05/2020-11-02_19:59:29');

fmt_landfill_pose_3_dir_2 = strcat(fmt_landfill_base_str, 'pose_3/noise_s=0.01/2020-11-03_10:45:46');
fmt_landfill_pose_3_dir_3 = strcat(fmt_landfill_base_str, 'pose_3/noise_s=0.02/2020-11-03_15:13:38');
fmt_landfill_pose_3_dir_4 = strcat(fmt_landfill_base_str, 'pose_3/noise_s=0.05/2020-11-03_19:11:24');

fmt_landfill_pose_4_dir_2 = strcat(fmt_landfill_base_str, 'pose_4/noise_s=0.01/2020-11-04_10:53:59');
fmt_landfill_pose_4_dir_3 = strcat(fmt_landfill_base_str, 'pose_4/noise_s=0.02/2020-11-04_14:46:46');
fmt_landfill_pose_4_dir_4 = strcat(fmt_landfill_base_str, 'pose_4/noise_s=0.05/2020-11-04_18:48:03');

fmt_landfill_pose_5_dir_2 = strcat(fmt_landfill_base_str, 'pose_5/noise_s=0.01/2020-11-05_02:54:21');
fmt_landfill_pose_5_dir_3 = strcat(fmt_landfill_base_str, 'pose_5/noise_s=0.02/2020-11-05_10:43:56');
fmt_landfill_pose_5_dir_4 = strcat(fmt_landfill_base_str, 'pose_5/noise_s=0.05/2020-11-05_15:17:09');

fmt_landfill_pose_6_dir_2 = strcat(fmt_landfill_base_str, 'pose_6/noise_s=0.01/2020-11-06_01:43:11');
fmt_landfill_pose_6_dir_3 = strcat(fmt_landfill_base_str, 'pose_6/noise_s=0.02/2020-11-06_10:12:29');
fmt_landfill_pose_6_dir_4 = strcat(fmt_landfill_base_str, 'pose_6/noise_s=0.05/2020-11-06_14:04:24');

fmt_landfill_pose_7_dir_2 = strcat(fmt_landfill_base_str, 'pose_7/noise_s=0.01/2020-11-06_22:12:47');
fmt_landfill_pose_7_dir_3 = strcat(fmt_landfill_base_str, 'pose_7/noise_s=0.02/2020-11-07_02:56:06');
fmt_landfill_pose_7_dir_4 = strcat(fmt_landfill_base_str, 'pose_7/noise_s=0.05/2020-11-07_13:27:11');

fmt_landfill_pose_1_dirs = {fmt_landfill_pose_1_dir_2, fmt_landfill_pose_1_dir_3, fmt_landfill_pose_1_dir_4};
fmt_landfill_pose_2_dirs = {fmt_landfill_pose_2_dir_2, fmt_landfill_pose_2_dir_3, fmt_landfill_pose_2_dir_4};
fmt_landfill_pose_3_dirs = {fmt_landfill_pose_3_dir_2, fmt_landfill_pose_3_dir_3, fmt_landfill_pose_3_dir_4};
fmt_landfill_pose_4_dirs = {fmt_landfill_pose_4_dir_2, fmt_landfill_pose_4_dir_3, fmt_landfill_pose_4_dir_4};
fmt_landfill_pose_5_dirs = {fmt_landfill_pose_5_dir_2, fmt_landfill_pose_5_dir_3, fmt_landfill_pose_5_dir_4};
fmt_landfill_pose_6_dirs = {fmt_landfill_pose_6_dir_2, fmt_landfill_pose_6_dir_3, fmt_landfill_pose_6_dir_4};
fmt_landfill_pose_7_dirs = {fmt_landfill_pose_7_dir_2, fmt_landfill_pose_7_dir_3, fmt_landfill_pose_7_dir_4};
fmt_landfill_poses = {fmt_landfill_pose_1_dirs;
                  fmt_landfill_pose_2_dirs;
                  fmt_landfill_pose_3_dirs;
                  fmt_landfill_pose_4_dirs;
                  fmt_landfill_pose_5_dirs;
                  fmt_landfill_pose_6_dirs;
                  fmt_landfill_pose_7_dirs};


csm_landfill_pose_1_dir_2 = strcat(csm_landfill_base_str, 'pose_1/noise_s=0.01/2020-11-07_23:52:27');
csm_landfill_pose_1_dir_3 = strcat(csm_landfill_base_str, 'pose_1/noise_s=0.02/2020-11-07_21:48:38');
csm_landfill_pose_1_dir_4 = strcat(csm_landfill_base_str, 'pose_1/noise_s=0.05/2020-11-07_17:31:00');

csm_landfill_pose_2_dir_2 = strcat(csm_landfill_base_str, 'pose_2/noise_s=0.01/2020-11-08_14:44:27');
csm_landfill_pose_2_dir_3 = strcat(csm_landfill_base_str, 'pose_2/noise_s=0.02/2020-11-08_17:27:11');
csm_landfill_pose_2_dir_4 = strcat(csm_landfill_base_str, 'pose_2/noise_s=0.05/2020-11-08_20:12:34');

csm_landfill_pose_3_dir_2 = strcat(csm_landfill_base_str, 'pose_3/noise_s=0.01/2020-11-09_10:07:28');
csm_landfill_pose_3_dir_3 = strcat(csm_landfill_base_str, 'pose_3/noise_s=0.02/2020-11-09_12:12:11');
csm_landfill_pose_3_dir_4 = strcat(csm_landfill_base_str, 'pose_3/noise_s=0.05/2020-11-09_14:18:56');

csm_landfill_pose_4_dir_2 = strcat(csm_landfill_base_str, 'pose_4/noise_s=0.01/2020-11-09_18:24:57');
csm_landfill_pose_4_dir_3 = strcat(csm_landfill_base_str, 'pose_4/noise_s=0.02/2020-11-09_20:54:44');
csm_landfill_pose_4_dir_4 = strcat(csm_landfill_base_str, 'pose_4/noise_s=0.05/2020-11-09_23:07:32');

csm_landfill_pose_5_dir_2 = strcat(csm_landfill_base_str, 'pose_5/noise_s=0.01/2020-11-10_10:35:26');
csm_landfill_pose_5_dir_3 = strcat(csm_landfill_base_str, 'pose_5/noise_s=0.02/2020-11-10_12:37:31');
csm_landfill_pose_5_dir_4 = strcat(csm_landfill_base_str, 'pose_5/noise_s=0.05/2020-11-10_14:57:32');

csm_landfill_pose_6_dir_2 = strcat(csm_landfill_base_str, 'pose_6/noise_s=0.01/2020-11-10_19:11:36');
csm_landfill_pose_6_dir_3 = strcat(csm_landfill_base_str, 'pose_6/noise_s=0.02/2020-11-10_21:29:43');
csm_landfill_pose_6_dir_4 = strcat(csm_landfill_base_str, 'pose_6/noise_s=0.05/2020-11-10_23:57:44');

csm_landfill_pose_7_dir_2 = strcat(csm_landfill_base_str, 'pose_7/noise_s=0.01/2020-11-11_11:06:06');
csm_landfill_pose_7_dir_3 = strcat(csm_landfill_base_str, 'pose_7/noise_s=0.02/2020-11-11_13:12:29');
csm_landfill_pose_7_dir_4 = strcat(csm_landfill_base_str, 'pose_7/noise_s=0.05/2020-11-11_15:12:33');

csm_landfill_pose_1_dirs = {csm_landfill_pose_1_dir_2, csm_landfill_pose_1_dir_3, csm_landfill_pose_1_dir_4};
csm_landfill_pose_2_dirs = {csm_landfill_pose_2_dir_2, csm_landfill_pose_2_dir_3, csm_landfill_pose_2_dir_4};
csm_landfill_pose_3_dirs = {csm_landfill_pose_3_dir_2, csm_landfill_pose_3_dir_3, csm_landfill_pose_3_dir_4};
csm_landfill_pose_4_dirs = {csm_landfill_pose_4_dir_2, csm_landfill_pose_4_dir_3, csm_landfill_pose_4_dir_4};
csm_landfill_pose_5_dirs = {csm_landfill_pose_5_dir_2, csm_landfill_pose_5_dir_3, csm_landfill_pose_5_dir_4};
csm_landfill_pose_6_dirs = {csm_landfill_pose_6_dir_2, csm_landfill_pose_6_dir_3, csm_landfill_pose_6_dir_4};
csm_landfill_pose_7_dirs = {csm_landfill_pose_7_dir_2, csm_landfill_pose_7_dir_3, csm_landfill_pose_7_dir_4};
csm_landfill_poses = {csm_landfill_pose_1_dirs;
                  csm_landfill_pose_2_dirs;
                  csm_landfill_pose_3_dirs;
                  csm_landfill_pose_4_dirs;
                  csm_landfill_pose_5_dirs;
                  csm_landfill_pose_6_dirs;
                  csm_landfill_pose_7_dirs};



fmt_landfill_xy_errors = [];
fmt_landfill_t_errors = [];
fmt_landfill_outliers = [];

csm_landfill_xy_errors = [];
csm_landfill_t_errors = [];
csm_landfill_outliers = [];


for r=1:size(fmt_landfill_poses,1)
  fmt_landfill_xy_errors_row = [];
  fmt_landfill_t_errors_row = [];
  fmt_landfill_outliers_row = [];
  csm_landfill_xy_errors_row = [];
  csm_landfill_t_errors_row = [];
  csm_landfill_outliers_row = [];

  for c=1:size(fmt_landfill_poses{1},2)
    [fmt_xy fmt_t fmt_et fmt_o] = function_top_level_script(fmt_landfill_poses{r}{c});
    [csm_xy csm_t csm_et csm_o] = function_top_level_script(csm_landfill_poses{r}{c});

    fmt_landfill_xy_errors_row = [fmt_landfill_xy_errors_row, fmt_xy];
    fmt_landfill_t_errors_row = [fmt_landfill_t_errors_row, fmt_t];
    fmt_landfill_outliers_row = [fmt_landfill_outliers_row, fmt_o];

    csm_landfill_xy_errors_row = [csm_landfill_xy_errors_row, csm_xy];
    csm_landfill_t_errors_row = [csm_landfill_t_errors_row, csm_t];
    csm_landfill_outliers_row = [csm_landfill_outliers_row, csm_o];

  end
  fmt_landfill_xy_errors = [fmt_landfill_xy_errors; fmt_landfill_xy_errors_row];
  fmt_landfill_t_errors = [fmt_landfill_t_errors; fmt_landfill_t_errors_row];
  fmt_landfill_outliers = [fmt_landfill_outliers; fmt_landfill_outliers_row];

  csm_landfill_xy_errors = [csm_landfill_xy_errors; csm_landfill_xy_errors_row];
  csm_landfill_t_errors = [csm_landfill_t_errors; csm_landfill_t_errors_row];
  csm_landfill_outliers = [csm_landfill_outliers; csm_landfill_outliers_row];
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% csal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fmt_csal_base_str = 'vault/fmt/Centroid-based/noise_s=125/csal/';
csm_csal_base_str = 'vault/csm/csal/';

fmt_csal_pose_1_dir_2 = strcat(fmt_csal_base_str, 'pose_1');

fmt_csal_pose_2_dir_2 = strcat(fmt_csal_base_str, 'pose_2');

fmt_csal_pose_3_dir_2 = strcat(fmt_csal_base_str, 'pose_3');

fmt_csal_pose_4_dir_2 = strcat(fmt_csal_base_str, 'pose_4');

fmt_csal_pose_5_dir_2 = strcat(fmt_csal_base_str, 'pose_5');

fmt_csal_pose_6_dir_2 = strcat(fmt_csal_base_str, 'pose_6');

fmt_csal_pose_7_dir_2 = strcat(fmt_csal_base_str, 'pose_7');

fmt_csal_pose_8_dir_2 = strcat(fmt_csal_base_str, 'pose_8');

fmt_csal_pose_9_dir_2 = strcat(fmt_csal_base_str, 'pose_9');

fmt_csal_pose_10_dir_2 = strcat(fmt_csal_base_str, 'pose_10');

fmt_csal_pose_11_dir_2 = strcat(fmt_csal_base_str, 'pose_11');

fmt_csal_pose_1_dirs = {fmt_csal_pose_1_dir_2};
fmt_csal_pose_2_dirs = {fmt_csal_pose_2_dir_2};
fmt_csal_pose_3_dirs = {fmt_csal_pose_3_dir_2};
fmt_csal_pose_4_dirs = {fmt_csal_pose_4_dir_2};
fmt_csal_pose_5_dirs = {fmt_csal_pose_5_dir_2};
fmt_csal_pose_6_dirs = {fmt_csal_pose_6_dir_2};
fmt_csal_pose_7_dirs = {fmt_csal_pose_7_dir_2};
fmt_csal_pose_8_dirs = {fmt_csal_pose_8_dir_2};
fmt_csal_pose_9_dirs = {fmt_csal_pose_9_dir_2};
fmt_csal_pose_10_dirs = {fmt_csal_pose_10_dir_2};
fmt_csal_pose_11_dirs = {fmt_csal_pose_11_dir_2};
fmt_csal_poses = {fmt_csal_pose_1_dirs;
                  fmt_csal_pose_2_dirs;
                  fmt_csal_pose_3_dirs;
                  fmt_csal_pose_4_dirs;
                  fmt_csal_pose_5_dirs;
                  fmt_csal_pose_6_dirs;
                  fmt_csal_pose_7_dirs;
                  fmt_csal_pose_8_dirs;
                  fmt_csal_pose_9_dirs;
                  fmt_csal_pose_10_dirs;
                  fmt_csal_pose_11_dirs};


csm_csal_pose_1_dir_2 = strcat(csm_csal_base_str, 'pose_1');

csm_csal_pose_2_dir_2 = strcat(csm_csal_base_str, 'pose_2');

csm_csal_pose_3_dir_2 = strcat(csm_csal_base_str, 'pose_3');

csm_csal_pose_4_dir_2 = strcat(csm_csal_base_str, 'pose_4');

csm_csal_pose_5_dir_2 = strcat(csm_csal_base_str, 'pose_5');

csm_csal_pose_6_dir_2 = strcat(csm_csal_base_str, 'pose_6');

csm_csal_pose_7_dir_2 = strcat(csm_csal_base_str, 'pose_7');

csm_csal_pose_8_dir_2 = strcat(csm_csal_base_str, 'pose_8');

csm_csal_pose_9_dir_2 = strcat(csm_csal_base_str, 'pose_9');

csm_csal_pose_10_dir_2 = strcat(csm_csal_base_str, 'pose_10');

csm_csal_pose_11_dir_2 = strcat(csm_csal_base_str, 'pose_11');

csm_csal_pose_1_dirs = {csm_csal_pose_1_dir_2};
csm_csal_pose_2_dirs = {csm_csal_pose_2_dir_2};
csm_csal_pose_3_dirs = {csm_csal_pose_3_dir_2};
csm_csal_pose_4_dirs = {csm_csal_pose_4_dir_2};
csm_csal_pose_5_dirs = {csm_csal_pose_5_dir_2};
csm_csal_pose_6_dirs = {csm_csal_pose_6_dir_2};
csm_csal_pose_7_dirs = {csm_csal_pose_7_dir_2};
csm_csal_pose_8_dirs = {csm_csal_pose_8_dir_2};
csm_csal_pose_9_dirs = {csm_csal_pose_9_dir_2};
csm_csal_pose_10_dirs = {csm_csal_pose_10_dir_2};
csm_csal_pose_11_dirs = {csm_csal_pose_11_dir_2};
csm_csal_poses = {csm_csal_pose_1_dirs;
                  csm_csal_pose_2_dirs;
                  csm_csal_pose_3_dirs;
                  csm_csal_pose_4_dirs;
                  csm_csal_pose_5_dirs;
                  csm_csal_pose_6_dirs;
                  csm_csal_pose_7_dirs;
                  csm_csal_pose_8_dirs;
                  csm_csal_pose_9_dirs;
                  csm_csal_pose_10_dirs;
                  csm_csal_pose_11_dirs};


fmt_csal_xy_errors = [];
fmt_csal_t_errors = [];
fmt_csal_outliers = [];

csm_csal_xy_errors = [];
csm_csal_t_errors = [];
csm_csal_outliers = [];


for r=1:size(fmt_csal_poses,1)
  fmt_csal_xy_errors_row = [];
  fmt_csal_t_errors_row = [];
  fmt_csal_outliers_row = [];
  csm_csal_xy_errors_row = [];
  csm_csal_t_errors_row = [];
  csm_csal_outliers_row = [];

  for c=1:size(fmt_csal_poses{1},2)
    [fmt_xy fmt_t fmt_et fmt_o] = function_top_level_script(fmt_csal_poses{r}{c});
    [csm_xy csm_t csm_et csm_o] = function_top_level_script(csm_csal_poses{r}{c});

    fmt_csal_xy_errors_row = [fmt_csal_xy_errors_row, fmt_xy];
    fmt_csal_t_errors_row = [fmt_csal_t_errors_row, fmt_t];
    fmt_csal_outliers_row = [fmt_csal_outliers_row, fmt_o];

    csm_csal_xy_errors_row = [csm_csal_xy_errors_row, csm_xy];
    csm_csal_t_errors_row = [csm_csal_t_errors_row, csm_t];
    csm_csal_outliers_row = [csm_csal_outliers_row, csm_o];

  end
  fmt_csal_xy_errors = [fmt_csal_xy_errors; fmt_csal_xy_errors_row];
  fmt_csal_t_errors = [fmt_csal_t_errors; fmt_csal_t_errors_row];
  fmt_csal_outliers = [fmt_csal_outliers; fmt_csal_outliers_row];

  csm_csal_xy_errors = [csm_csal_xy_errors; csm_csal_xy_errors_row];
  csm_csal_t_errors = [csm_csal_t_errors; csm_csal_t_errors_row];
  csm_csal_outliers = [csm_csal_outliers; csm_csal_outliers_row];

end





cd(here)
c = colours2();
s = [];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f = figure(1);
set(f,'position',[1 1 550 600]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s(1) = subplot(6,2,1);
hold on
for i=1:3
  for p = 1:3
    h = bar([8*i+2*p], csm_corridor_outliers(i,p));
    set (h, "facecolor", [c{i}(p,:)]);
  end
end
ylim([0 100])
xlim([10-2 30+2])
set(gca, 'XTick', [12 20 28]);
set(gca, 'xticklabel', {'\\small $\\bm{p}_a^C$', '\\small $\\bm{p}_b^C$', '\\small $\\bm{p}_c^C$'});
set(gca, 'YTick', [0 25 50 75 100])
set(gca, 'yticklabel', {'\\small $0\\%$', '\\small $25\\%$','\\small $50\\%$','\\small $75\\%$', '\\small $100\\%$'});
set(gca, 'title', 'PLICP');
set(gca, 'ylabel', '\small CORRIDOR');
box on
%grid

s(2) = subplot(6,2,2);
hold on;
for i=1:3
  for p = 1:3
    h = bar([8*i+2*p], fmt_corridor_outliers(i,p));
    set (h, "facecolor", [c{i}(p,:)]);
  end
end
ylim([0 100])
xlim([10-2 30+2])
set(gca, 'XTick', [12 20 28]);
set(gca, 'xticklabel', {'\\small $\\bm{p}_a^C$', '\\small $\\bm{p}_b^C$', '\\small $\\bm{p}_c^C$'});
set(gca, 'YTick', [0 25 50 75 100])
set(gca, 'yticklabel', {'\\small $0\\%$', '\\small $25\\%$','\\small $50\\%$','\\small $75\\%$', '\\small $100\\%$'});
set(gca, 'title', 'PGL-FMIC');
box on
%grid


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s(3) = subplot(6,2,3);
hold on
for i=1:11
  for p = 1:3
    h = bar([8*i+2*p], csm_home_outliers(i,p));
    set (h, "facecolor", [c{i}(p,:)]);
  end
end
ylim([0 100])
xlim([10-2 94+2])
set(gca, 'XTick', [12 20 28 36 44 52 60 68 76 84 92]);
set(gca, 'xticklabel', {'\\small $\\bm{p}_a^H$', '\\small $\\bm{p}_b^H$', '\\small $\\bm{p}_c^H$', '\\small $\\bm{p}_d^H$', '\\small $\\bm{p}_e^H$', '\\small $\\bm{p}_f^H$', '\\small $\\bm{p}_g^H$', '\\small $\\bm{p}_h^H$', '\\small $\\bm{p}_i^H$', '\\small $\\bm{p}_j^H$', '\\small $\\bm{p}_k^H$' });
set(gca, 'YTick', [0 25 50 75 100])
set(gca, 'yticklabel', {'\\small $0\\%$', '\\small $25\\%$','\\small $50\\%$','\\small $75\\%$', '\\small $100\\%$'});
set(gca, 'ylabel', '\small HOME');
%grid
box on

s(4) = subplot(6,2,4);
hold on;
for i=1:11
  for p = 1:3
    h = bar([8*i+2*p], fmt_home_outliers(i,p));
    set (h, "facecolor", [c{i}(p,:)]);
  end
end
ylim([0 100])
xlim([10-2 94+2])
set(gca, 'XTick', [12 20 28 36 44 52 60 68 76 84 92]);
set(gca, 'xticklabel', {'\\small $\\bm{p}_a^H$', '\\small $\\bm{p}_b^H$', '\\small $\\bm{p}_c^H$', '\\small $\\bm{p}_d^H$', '\\small $\\bm{p}_e^H$', '\\small $\\bm{p}_f^H$', '\\small $\\bm{p}_g^H$', '\\small $\\bm{p}_h^H$', '\\small $\\bm{p}_i^H$', '\\small $\\bm{p}_j^H$', '\\small $\\bm{p}_k^H$' });
set(gca, 'xticklabel', []);
set(gca, 'YTick', [0 25 50 75 100])
set(gca, 'yticklabel', {'\\small $0\\%$', '\\small $25\\%$','\\small $50\\%$','\\small $75\\%$', '\\small $100\\%$'});
%grid
box on



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s(5) = subplot(6,2,5);
hold on
for i=1:7
  for p = 1:3
    h = bar([8*i+2*p], csm_warehouse_outliers(i,p));
    set (h, "facecolor", [c{i}(p,:)]);
  end
end
ylim([0 100])
xlim([10-2 62+2])
set(gca, 'XTick', [12 20 28 36 44 52 60]);
set(gca, 'xticklabel', {'\\small $\\bm{p}_a^W$', '\\small $\\bm{p}_b^W$', '\\small $\\bm{p}_c^W$', '\\small $\\bm{p}_d^W$', '\\small $\\bm{p}_e^W$', '\\small $\\bm{p}_f^W$', '\\small $\\bm{p}_g^W$'});
set(gca, 'YTick', [0 25 50 75 100])
set(gca, 'yticklabel', {'\\small $0\\%$', '\\small $25\\%$','\\small $50\\%$','\\small $75\\%$', '\\small $100\\%$'});
set(gca, 'ylabel', '\small WAREHOUSE');
%grid
box on

s(6) = subplot(6,2,6);
hold on;
for i=1:7
  for p = 1:3
    h = bar([8*i+2*p], fmt_warehouse_outliers(i,p));
    set (h, "facecolor", [c{i}(p,:)]);
  end
end
ylim([0 100])
xlim([10-2 62+2])
set(gca, 'XTick', [12 20 28 36 44 52 60]);
set(gca, 'xticklabel', {'\\small $\\bm{p}_a^W$', '\\small $\\bm{p}_b^W$', '\\small $\\bm{p}_c^W$', '\\small $\\bm{p}_d^W$', '\\small $\\bm{p}_e^W$', '\\small $\\bm{p}_f^W$', '\\small $\\bm{p}_g^W$'});
set(gca, 'YTick', [0 25 50 75 100])
set(gca, 'yticklabel', {'\\small $0\\%$', '\\small $25\\%$','\\small $50\\%$','\\small $75\\%$', '\\small $100\\%$'});
%grid
box on

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s(7) = subplot(6,2,7);
hold on
for i=1:10
  for p = 1:3
    h = bar([8*i+2*p], csm_willowgarage_outliers(i,p));
    set (h, "facecolor", [c{i}(p,:)]);
  end
end
ylim([0 100])
xlim([10-2 86+2])
set(gca, 'XTick', [12 20 28 36 44 52 60 68 76 84]);
set(gca, 'xticklabel', {'\\small $\\bm{p}_a^G$', '\\small $\\bm{p}_b^G$', '\\small $\\bm{p}_c^G$', '\\small $\\bm{p}_d^G$', '\\small $\\bm{p}_e^G$', '\\small $\\bm{p}_f^G$', '\\small $\\bm{p}_g^G$', '\\small $\\bm{p}_h^G$', '\\small $\\bm{p}_i^G$', '\\small $\\bm{p}_j^G$'});
set(gca, 'YTick', [0 25 50 75 100])
set(gca, 'yticklabel', {'\\small $0\\%$', '\\small $25\\%$','\\small $50\\%$','\\small $75\\%$', '\\small $100\\%$'});
set(gca, 'ylabel', '\small WILLOWGARAGE');
%grid
box on


s(8) = subplot(6,2,8);
hold on;
for i=1:10
  for p = 1:3
    h = bar([8*i+2*p], fmt_willowgarage_outliers(i,p));
    set (h, "facecolor", [c{i}(p,:)]);
  end
end
ylim([0 100])
xlim([10-2 86+2])
set(gca, 'XTick', [12 20 28 36 44 52 60 68 76 84]);
set(gca, 'xticklabel', {'\\small $\\bm{p}_a^G$', '\\small $\\bm{p}_b^G$', '\\small $\\bm{p}_c^G$', '\\small $\\bm{p}_d^G$', '\\small $\\bm{p}_e^G$', '\\small $\\bm{p}_f^G$', '\\small $\\bm{p}_g^G$', '\\small $\\bm{p}_h^G$', '\\small $\\bm{p}_i^G$', '\\small $\\bm{p}_j^G$'});
set(gca, 'YTick', [0 25 50 75 100])
set(gca, 'yticklabel', {'\\small $0\\%$', '\\small $25\\%$','\\small $50\\%$','\\small $75\\%$', '\\small $100\\%$'});
%grid
box on

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s(9) = subplot(6,2,9);
hold on
for i=1:7
  for p = 1:3
    h = bar([8*i+2*p], csm_landfill_outliers(i,p));
    set (h, "facecolor", [c{i}(p,:)]);
  end
end
ylim([0 100])
xlim([10-2 62+2])
set(gca, 'XTick', [12 20 28 36 44 52 60]);
set(gca, 'xticklabel', {'\\small $\\bm{p}_a^L$', '\\small $\\bm{p}_b^L$', '\\small $\\bm{p}_c^L$', '\\small $\\bm{p}_d^L$', '\\small $\\bm{p}_e^L$', '\\small $\\bm{p}_f^L$', '\\small $\\bm{p}_g^L$'});
set(gca, 'YTick', [0 25 50 75 100])
set(gca, 'yticklabel', {'\\small $0\\%$', '\\small $25\\%$','\\small $50\\%$','\\small $75\\%$', '\\small $100\\%$'});
set(gca, 'ylabel', '\small LANDFILL');
%grid
box on

s(10) = subplot(6,2,10);
hold on;
for i=1:7
  for p = 1:3
    h = bar([8*i+2*p], fmt_landfill_outliers(i,p));
    set (h, "facecolor", [c{i}(p,:)]);
  end
end
ylim([0 100])
xlim([10-2 62+2])
set(gca, 'XTick', [12 20 28 36 44 52 60]);
set(gca, 'xticklabel', {'\\small $\\bm{p}_a^L$', '\\small $\\bm{p}_b^L$', '\\small $\\bm{p}_c^L$', '\\small $\\bm{p}_d^L$', '\\small $\\bm{p}_e^L$', '\\small $\\bm{p}_f^L$', '\\small $\\bm{p}_g^L$'});
set(gca, 'YTick', [0 25 50 75 100])
set(gca, 'yticklabel', {'\\small $0\\%$', '\\small $25\\%$','\\small $50\\%$','\\small $75\\%$', '\\small $100\\%$'});
%grid
box on



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s(11) = subplot(6,2,11);
hold on
for i=1:11
  h = bar([2*i], csm_csal_outliers(i));
  set (h, "facecolor", [c{i}(2,:)]);
end
ylim([0 5])
xlim([2-1 22+1])
set(gca, 'XTick', 2*[1:11]);
set(gca, 'xticklabel', {'\\small $\\bm{p}_a^A$', '\\small $\\bm{p}_b^A$', '\\small $\\bm{p}_c^A$', '\\small $\\bm{p}_d^A$', '\\small $\\bm{p}_e^A$', '\\small $\\bm{p}_f^A$', '\\small $\\bm{p}_g^A$', '\\small $\\bm{p}_h^A$', '\\small $\\bm{p}_i^A$', '\\small $\\bm{p}_j^A$', '\\small $\\bm{p}_k^A$' });
set(gca, 'YTick', [0 1 2 3 4 5])
set(gca, 'yticklabel', {'\\small $0\\%$', '\\small $20\\%$','\\small $40\\%$','\\small $60\\%$', '\\small $80\\%$', '\\small $100\\%$'});
set(gca, 'ylabel', '\small CSAL');
set(gca, 'xlabel', 'Σημαίνον στάσης');
%grid
box on


s(12) = subplot(6,2,12);
hold on;
for i=1:11
  h = bar([2*i], fmt_csal_outliers(i));
  set (h, "facecolor", [c{i}(2,:)]);
end
ylim([0 5])
xlim([2-1 22+1])
set(gca, 'XTick', 2*[1:11]);
set(gca, 'xticklabel', {'\\small $\\bm{p}_a^A$', '\\small $\\bm{p}_b^A$', '\\small $\\bm{p}_c^A$', '\\small $\\bm{p}_d^A$', '\\small $\\bm{p}_e^A$', '\\small $\\bm{p}_f^A$', '\\small $\\bm{p}_g^A$', '\\small $\\bm{p}_h^A$', '\\small $\\bm{p}_i^A$', '\\small $\\bm{p}_j^A$', '\\small $\\bm{p}_k^A$' });
set(gca, 'YTick', [0 1 2 3 4 5])
set(gca, 'yticklabel', {'\\small $0\\%$', '\\small $20\\%$','\\small $40\\%$','\\small $60\\%$', '\\small $80\\%$', '\\small $100\\%$'});
%grid
box on

ps = [];
for i = 1:12
  ps = [ps; get(s(i), 'position')];
end

current_xspace = ps(1,1) + ps(1,3) - ps(2,1);
w = -current_xspace/10;

set(s(1), 'position',  [ps(1,:)]  + [+w 0 0 0])
set(s(2), 'position',  [ps(2,:)]  + [-w 0 0 0])
set(s(3), 'position',  [ps(3,:)]  + [+w 0 0 0])
set(s(4), 'position',  [ps(4,:)]  + [-w 0 0 0])
set(s(5), 'position',  [ps(5,:)]  + [+w 0 0 0])
set(s(6), 'position',  [ps(6,:)]  + [-w 0 0 0])
set(s(7), 'position',  [ps(7,:)]  + [+w 0 0 0])
set(s(8), 'position',  [ps(8,:)]  + [-w 0 0 0])
set(s(9), 'position',  [ps(9,:)]  + [+w 0 0 0])
set(s(10), 'position', [ps(10,:)] + [-w 0 0 0])
set(s(11), 'position', [ps(11,:)] + [+w 0 0 0])
set(s(12), 'position', [ps(12,:)] + [-w 0 0 0])


if (store_outliers == 1)
  img_file = strcat(pwd, '/figures/outliers.eps');
  drawnow ("epslatex", img_file, false);
end
