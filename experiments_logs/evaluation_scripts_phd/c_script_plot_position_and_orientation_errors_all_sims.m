%clear all
%close all

%store_errors = 1;
%here = '/home/li9i/catkin_ws/src/relief_fmt_global_localisation/experiments_logs/evaluation_scripts_phd/';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% CORRIDOR
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%fmt_corridor_base_str = 'vault/fmt/Centroid-based/noise_s=125/corridor/';
%csm_corridor_base_str = 'vault/csm/corridor/';

%fmt_corridor_pose_1_dir_2 = strcat(fmt_corridor_base_str, 'pose_1/noise_s=0.01/2020-03-02_13:43:25');
%fmt_corridor_pose_1_dir_3 = strcat(fmt_corridor_base_str, 'pose_1/noise_s=0.02/2020-03-02_17:49:43');
%fmt_corridor_pose_1_dir_4 = strcat(fmt_corridor_base_str, 'pose_1/noise_s=0.05/2020-03-02_22:07:58');

%fmt_corridor_pose_2_dir_2 = strcat(fmt_corridor_base_str, 'pose_2/noise_s=0.01/2020-03-12_00:39:06');
%fmt_corridor_pose_2_dir_3 = strcat(fmt_corridor_base_str, 'pose_2/noise_s=0.02/2020-03-11_18:52:08');
%fmt_corridor_pose_2_dir_4 = strcat(fmt_corridor_base_str, 'pose_2/noise_s=0.05/2020-03-11_14:58:25');

%fmt_corridor_pose_3_dir_2 = strcat(fmt_corridor_base_str, 'pose_3/noise_s=0.01/2020-03-19_00:19:00');
%fmt_corridor_pose_3_dir_3 = strcat(fmt_corridor_base_str, 'pose_3/noise_s=0.02/2020-03-18_20:27:08');
%fmt_corridor_pose_3_dir_4 = strcat(fmt_corridor_base_str, 'pose_3/noise_s=0.05/2020-03-18_15:58:54');

%fmt_corridor_pose_1_dirs = {fmt_corridor_pose_1_dir_2, fmt_corridor_pose_1_dir_3, fmt_corridor_pose_1_dir_4};
%fmt_corridor_pose_2_dirs = {fmt_corridor_pose_2_dir_2, fmt_corridor_pose_2_dir_3, fmt_corridor_pose_2_dir_4};
%fmt_corridor_pose_3_dirs = {fmt_corridor_pose_3_dir_2, fmt_corridor_pose_3_dir_3, fmt_corridor_pose_3_dir_4};
%fmt_corridor_poses = {fmt_corridor_pose_1_dirs; fmt_corridor_pose_2_dirs; fmt_corridor_pose_3_dirs};

%csm_corridor_pose_1_dir_2 = strcat(csm_corridor_base_str, 'pose_1/noise_s=0.01/2020-02-04_10:27:18');
%csm_corridor_pose_1_dir_3 = strcat(csm_corridor_base_str, 'pose_1/noise_s=0.02/2020-02-06_15:27:04');
%csm_corridor_pose_1_dir_4 = strcat(csm_corridor_base_str, 'pose_1/noise_s=0.05/2020-02-04_12:34:10');

%csm_corridor_pose_2_dir_2 = strcat(csm_corridor_base_str, 'pose_2/noise_s=0.01/2020-03-12_18:13:57');
%csm_corridor_pose_2_dir_3 = strcat(csm_corridor_base_str, 'pose_2/noise_s=0.02/2020-03-12_22:10:31');
%csm_corridor_pose_2_dir_4 = strcat(csm_corridor_base_str, 'pose_2/noise_s=0.05/2020-03-13_09:28:56');

%csm_corridor_pose_3_dir_2 = strcat(csm_corridor_base_str, 'pose_3/noise_s=0.01/2020-03-17_14:58:06');
%csm_corridor_pose_3_dir_3 = strcat(csm_corridor_base_str, 'pose_3/noise_s=0.02/2020-03-17_18:47:18');
%csm_corridor_pose_3_dir_4 = strcat(csm_corridor_base_str, 'pose_3/noise_s=0.05/2020-03-18_00:57:45');

%csm_corridor_pose_1_dirs = {csm_corridor_pose_1_dir_2, csm_corridor_pose_1_dir_3, csm_corridor_pose_1_dir_4};
%csm_corridor_pose_2_dirs = {csm_corridor_pose_2_dir_2, csm_corridor_pose_2_dir_3, csm_corridor_pose_2_dir_4};
%csm_corridor_pose_3_dirs = {csm_corridor_pose_3_dir_2, csm_corridor_pose_3_dir_3, csm_corridor_pose_3_dir_4};
%csm_corridor_poses = {csm_corridor_pose_1_dirs; csm_corridor_pose_2_dirs; csm_corridor_pose_3_dirs};

%fmt_corridor_xy_errors = [];
%fmt_corridor_t_errors = [];
%fmt_corridor_outliers = [];

%csm_corridor_xy_errors = [];
%csm_corridor_t_errors = [];
%csm_corridor_outliers = [];


%for r=1:size(fmt_corridor_poses,1)
  %fmt_corridor_xy_errors_row = [];
  %fmt_corridor_t_errors_row = [];
  %fmt_corridor_outliers_row = [];
  %csm_corridor_xy_errors_row = [];
  %csm_corridor_t_errors_row = [];
  %csm_corridor_outliers_row = [];

  %for c=1:size(fmt_corridor_poses{1},2)
    %[fmt_xy fmt_t fmt_et fmt_o] = function_top_level_script(fmt_corridor_poses{r}{c});
    %[csm_xy csm_t csm_et csm_o] = function_top_level_script(csm_corridor_poses{r}{c});

    %fmt_corridor_xy_errors_row = [fmt_corridor_xy_errors_row, fmt_xy];
    %fmt_corridor_t_errors_row = [fmt_corridor_t_errors_row, fmt_t];
    %fmt_corridor_outliers_row = [fmt_corridor_outliers_row, fmt_o];

    %csm_corridor_xy_errors_row = [csm_corridor_xy_errors_row, csm_xy];
    %csm_corridor_t_errors_row = [csm_corridor_t_errors_row, csm_t];
    %csm_corridor_outliers_row = [csm_corridor_outliers_row, csm_o];

  %end
  %fmt_corridor_xy_errors = [fmt_corridor_xy_errors; fmt_corridor_xy_errors_row];
  %fmt_corridor_t_errors = [fmt_corridor_t_errors; fmt_corridor_t_errors_row];
  %fmt_corridor_outliers = [fmt_corridor_outliers; fmt_corridor_outliers_row];

  %csm_corridor_xy_errors = [csm_corridor_xy_errors; csm_corridor_xy_errors_row];
  %csm_corridor_t_errors = [csm_corridor_t_errors; csm_corridor_t_errors_row];
  %csm_corridor_outliers = [csm_corridor_outliers; csm_corridor_outliers_row];

%end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% home
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%fmt_home_base_str = 'vault/fmt/Centroid-based/noise_s=125/home/';
%csm_home_base_str = 'vault/csm/home/';

%fmt_home_pose_1_dir_2 = strcat(fmt_home_base_str, 'pose_1/noise_s=0.01/2020-02-29_00:41:39');
%fmt_home_pose_1_dir_3 = strcat(fmt_home_base_str, 'pose_1/noise_s=0.02/2020-02-29_14:51:19');
%fmt_home_pose_1_dir_4 = strcat(fmt_home_base_str, 'pose_1/noise_s=0.05/2020-03-01_14:51:25');

%fmt_home_pose_2_dir_2 = strcat(fmt_home_base_str, 'pose_2/noise_s=0.01/2020-03-19_22:09:40');
%fmt_home_pose_2_dir_3 = strcat(fmt_home_base_str, 'pose_2/noise_s=0.02/2020-03-20_09:25:23');
%fmt_home_pose_2_dir_4 = strcat(fmt_home_base_str, 'pose_2/noise_s=0.05/2020-03-20_16:25:12');

%fmt_home_pose_3_dir_2 = strcat(fmt_home_base_str, 'pose_3/noise_s=0.01/2020-03-22_02:29:06');
%fmt_home_pose_3_dir_3 = strcat(fmt_home_base_str, 'pose_3/noise_s=0.02/2020-03-22_11:50:58');
%fmt_home_pose_3_dir_4 = strcat(fmt_home_base_str, 'pose_3/noise_s=0.05/2020-03-22_19:33:51');

%fmt_home_pose_4_dir_2 = strcat(fmt_home_base_str, 'pose_4/noise_s=0.01/2020-03-24_16:50:29');
%fmt_home_pose_4_dir_3 = strcat(fmt_home_base_str, 'pose_4/noise_s=0.02/2020-03-24_09:45:09');
%fmt_home_pose_4_dir_4 = strcat(fmt_home_base_str, 'pose_4/noise_s=0.05/2020-03-23_21:31:05');

%fmt_home_pose_5_dir_2 = strcat(fmt_home_base_str, 'pose_5/noise_s=0.01/2020-06-13_22:52:26');
%fmt_home_pose_5_dir_3 = strcat(fmt_home_base_str, 'pose_5/noise_s=0.02/2020-06-12_12:42:45');
%fmt_home_pose_5_dir_4 = strcat(fmt_home_base_str, 'pose_5/noise_s=0.05/2020-06-12_21:18:45');

%fmt_home_pose_6_dir_2 = strcat(fmt_home_base_str, 'pose_6/noise_s=0.01/2020-03-27_23:22:45');
%fmt_home_pose_6_dir_3 = strcat(fmt_home_base_str, 'pose_6/noise_s=0.02/2020-03-27_16:22:33');
%fmt_home_pose_6_dir_4 = strcat(fmt_home_base_str, 'pose_6/noise_s=0.05/2020-03-27_09:26:12');

%fmt_home_pose_7_dir_2 = strcat(fmt_home_base_str, 'pose_7/noise_s=0.01/2020-03-29_20:45:41');
%fmt_home_pose_7_dir_3 = strcat(fmt_home_base_str, 'pose_7/noise_s=0.02/2020-03-29_13:41:55');
%fmt_home_pose_7_dir_4 = strcat(fmt_home_base_str, 'pose_7/noise_s=0.05/2020-03-28_23:09:03');

%fmt_home_pose_8_dir_2 = strcat(fmt_home_base_str, 'pose_8/noise_s=0.01/2020-06-10_13:00:10');
%fmt_home_pose_8_dir_3 = strcat(fmt_home_base_str, 'pose_8/noise_s=0.02/2020-06-11_10:09:56');
%fmt_home_pose_8_dir_4 = strcat(fmt_home_base_str, 'pose_8/noise_s=0.05/2020-06-11_18:49:26');

%fmt_home_pose_9_dir_2 = strcat(fmt_home_base_str, 'pose_9/noise_s=0.01/2020-04-03_00:41:37');
%fmt_home_pose_9_dir_3 = strcat(fmt_home_base_str, 'pose_9/noise_s=0.02/2020-04-02_17:23:49');
%fmt_home_pose_9_dir_4 = strcat(fmt_home_base_str, 'pose_9/noise_s=0.05/2020-04-02_10:20:54');

%fmt_home_pose_10_dir_2 = strcat(fmt_home_base_str, 'pose_10/noise_s=0.01/2020-04-04_19:33:55');
%fmt_home_pose_10_dir_3 = strcat(fmt_home_base_str, 'pose_10/noise_s=0.02/2020-04-05_03:36:15');
%fmt_home_pose_10_dir_4 = strcat(fmt_home_base_str, 'pose_10/noise_s=0.05/2020-04-05_14:31:27');

%fmt_home_pose_11_dir_2 = strcat(fmt_home_base_str, 'pose_11/noise_s=0.01/2020-04-08_10:11:44');
%fmt_home_pose_11_dir_3 = strcat(fmt_home_base_str, 'pose_11/noise_s=0.02/2020-04-07_23:04:27');
%fmt_home_pose_11_dir_4 = strcat(fmt_home_base_str, 'pose_11/noise_s=0.05/2020-04-07_15:27:07');

%fmt_home_pose_1_dirs = {fmt_home_pose_1_dir_2, fmt_home_pose_1_dir_3, fmt_home_pose_1_dir_4};
%fmt_home_pose_2_dirs = {fmt_home_pose_2_dir_2, fmt_home_pose_2_dir_3, fmt_home_pose_2_dir_4};
%fmt_home_pose_3_dirs = {fmt_home_pose_3_dir_2, fmt_home_pose_3_dir_3, fmt_home_pose_3_dir_4};
%fmt_home_pose_4_dirs = {fmt_home_pose_4_dir_2, fmt_home_pose_4_dir_3, fmt_home_pose_4_dir_4};
%fmt_home_pose_5_dirs = {fmt_home_pose_5_dir_2, fmt_home_pose_5_dir_3, fmt_home_pose_5_dir_4};
%fmt_home_pose_6_dirs = {fmt_home_pose_6_dir_2, fmt_home_pose_6_dir_3, fmt_home_pose_6_dir_4};
%fmt_home_pose_7_dirs = {fmt_home_pose_7_dir_2, fmt_home_pose_7_dir_3, fmt_home_pose_7_dir_4};
%fmt_home_pose_8_dirs = {fmt_home_pose_8_dir_2, fmt_home_pose_8_dir_3, fmt_home_pose_8_dir_4};
%fmt_home_pose_9_dirs = {fmt_home_pose_9_dir_2, fmt_home_pose_9_dir_3, fmt_home_pose_9_dir_4};
%fmt_home_pose_10_dirs = {fmt_home_pose_10_dir_2, fmt_home_pose_10_dir_3, fmt_home_pose_10_dir_4};
%fmt_home_pose_11_dirs = {fmt_home_pose_11_dir_2, fmt_home_pose_11_dir_3, fmt_home_pose_11_dir_4};
%fmt_home_poses = {fmt_home_pose_1_dirs;
                  %fmt_home_pose_2_dirs;
                  %fmt_home_pose_3_dirs;
                  %fmt_home_pose_4_dirs;
                  %fmt_home_pose_5_dirs;
                  %fmt_home_pose_6_dirs;
                  %fmt_home_pose_7_dirs;
                  %fmt_home_pose_8_dirs;
                  %fmt_home_pose_9_dirs;
                  %fmt_home_pose_10_dirs;
                  %fmt_home_pose_11_dirs};


%csm_home_pose_1_dir_2 = strcat(csm_home_base_str, 'pose_1/noise_s=0.01/2020-02-17_12:36:24');
%csm_home_pose_1_dir_3 = strcat(csm_home_base_str, 'pose_1/noise_s=0.02/2020-02-14_16:17:33');
%csm_home_pose_1_dir_4 = strcat(csm_home_base_str, 'pose_1/noise_s=0.05/2020-02-17_09:40:53');

%csm_home_pose_2_dir_2 = strcat(csm_home_base_str, 'pose_2/noise_s=0.01/2020-03-21_12:32:16');
%csm_home_pose_2_dir_3 = strcat(csm_home_base_str, 'pose_2/noise_s=0.02/2020-03-21_01:50:20');
%csm_home_pose_2_dir_4 = strcat(csm_home_base_str, 'pose_2/noise_s=0.05/2020-03-20_23:21:33');

%csm_home_pose_3_dir_2 = strcat(csm_home_base_str, 'pose_3/noise_s=0.01/2020-03-23_15:57:58');
%csm_home_pose_3_dir_3 = strcat(csm_home_base_str, 'pose_3/noise_s=0.02/2020-03-23_13:08:04');
%csm_home_pose_3_dir_4 = strcat(csm_home_base_str, 'pose_3/noise_s=0.05/2020-03-23_10:41:35');

%csm_home_pose_4_dir_2 = strcat(csm_home_base_str, 'pose_4/noise_s=0.01/2020-03-25_09:48:03');
%csm_home_pose_4_dir_3 = strcat(csm_home_base_str, 'pose_4/noise_s=0.02/2020-03-25_10:13:33');
%csm_home_pose_4_dir_4 = strcat(csm_home_base_str, 'pose_4/noise_s=0.05/2020-03-25_10:30:21');

%csm_home_pose_5_dir_2 = strcat(csm_home_base_str, 'pose_5/noise_s=0.01/2020-03-26_19:27:40');
%csm_home_pose_5_dir_3 = strcat(csm_home_base_str, 'pose_5/noise_s=0.02/2020-03-26_22:00:47');
%csm_home_pose_5_dir_4 = strcat(csm_home_base_str, 'pose_5/noise_s=0.05/2020-03-27_00:25:52');

%csm_home_pose_6_dir_2 = strcat(csm_home_base_str, 'pose_6/noise_s=0.01/2020-03-28_21:46:50');
%csm_home_pose_6_dir_3 = strcat(csm_home_base_str, 'pose_6/noise_s=0.02/2020-03-28_22:13:58');
%csm_home_pose_6_dir_4 = strcat(csm_home_base_str, 'pose_6/noise_s=0.05/2020-03-28_22:49:17');

%csm_home_pose_7_dir_2 = strcat(csm_home_base_str, 'pose_7/noise_s=0.01/2020-03-30_18:34:41');
%csm_home_pose_7_dir_3 = strcat(csm_home_base_str, 'pose_7/noise_s=0.02/2020-03-30_21:02:52');
%csm_home_pose_7_dir_4 = strcat(csm_home_base_str, 'pose_7/noise_s=0.05/2020-03-31_00:42:09');

%csm_home_pose_8_dir_2 = strcat(csm_home_base_str, 'pose_8/noise_s=0.01/2020-04-01_19:35:35');
%csm_home_pose_8_dir_3 = strcat(csm_home_base_str, 'pose_8/noise_s=0.02/2020-04-01_22:03:43');
%csm_home_pose_8_dir_4 = strcat(csm_home_base_str, 'pose_8/noise_s=0.05/2020-04-02_00:51:59');

%csm_home_pose_9_dir_2 = strcat(csm_home_base_str, 'pose_9/noise_s=0.01/2020-04-03_21:46:59');
%csm_home_pose_9_dir_3 = strcat(csm_home_base_str, 'pose_9/noise_s=0.02/2020-04-03_19:15:27');
%csm_home_pose_9_dir_4 = strcat(csm_home_base_str, 'pose_9/noise_s=0.05/2020-04-03_16:34:29');

%csm_home_pose_10_dir_2 = strcat(csm_home_base_str, 'pose_10/noise_s=0.01/2020-04-06_09:49:56');
%csm_home_pose_10_dir_3 = strcat(csm_home_base_str, 'pose_10/noise_s=0.02/2020-04-06_00:41:07');
%csm_home_pose_10_dir_4 = strcat(csm_home_base_str, 'pose_10/noise_s=0.05/2020-04-05_21:53:56');

%csm_home_pose_11_dir_2 = strcat(csm_home_base_str, 'pose_11/noise_s=0.01/2020-04-06_22:30:50');
%csm_home_pose_11_dir_3 = strcat(csm_home_base_str, 'pose_11/noise_s=0.02/2020-04-07_09:27:07');
%csm_home_pose_11_dir_4 = strcat(csm_home_base_str, 'pose_11/noise_s=0.05/2020-04-07_12:12:21');

%csm_home_pose_1_dirs = {csm_home_pose_1_dir_2, csm_home_pose_1_dir_3, csm_home_pose_1_dir_4};
%csm_home_pose_2_dirs = {csm_home_pose_2_dir_2, csm_home_pose_2_dir_3, csm_home_pose_2_dir_4};
%csm_home_pose_3_dirs = {csm_home_pose_3_dir_2, csm_home_pose_3_dir_3, csm_home_pose_3_dir_4};
%csm_home_pose_4_dirs = {csm_home_pose_4_dir_2, csm_home_pose_4_dir_3, csm_home_pose_4_dir_4};
%csm_home_pose_5_dirs = {csm_home_pose_5_dir_2, csm_home_pose_5_dir_3, csm_home_pose_5_dir_4};
%csm_home_pose_6_dirs = {csm_home_pose_6_dir_2, csm_home_pose_6_dir_3, csm_home_pose_6_dir_4};
%csm_home_pose_7_dirs = {csm_home_pose_7_dir_2, csm_home_pose_7_dir_3, csm_home_pose_7_dir_4};
%csm_home_pose_8_dirs = {csm_home_pose_8_dir_2, csm_home_pose_8_dir_3, csm_home_pose_8_dir_4};
%csm_home_pose_9_dirs = {csm_home_pose_9_dir_2, csm_home_pose_9_dir_3, csm_home_pose_9_dir_4};
%csm_home_pose_10_dirs = {csm_home_pose_10_dir_2, csm_home_pose_10_dir_3, csm_home_pose_10_dir_4};
%csm_home_pose_11_dirs = {csm_home_pose_11_dir_2, csm_home_pose_11_dir_3, csm_home_pose_11_dir_4};
%csm_home_poses = {csm_home_pose_1_dirs;
                  %csm_home_pose_2_dirs;
                  %csm_home_pose_3_dirs;
                  %csm_home_pose_4_dirs;
                  %csm_home_pose_5_dirs;
                  %csm_home_pose_6_dirs;
                  %csm_home_pose_7_dirs;
                  %csm_home_pose_8_dirs;
                  %csm_home_pose_9_dirs;
                  %csm_home_pose_10_dirs;
                  %csm_home_pose_11_dirs};


%fmt_home_xy_errors = [];
%fmt_home_t_errors = [];
%fmt_home_outliers = [];

%csm_home_xy_errors = [];
%csm_home_t_errors = [];
%csm_home_outliers = [];


%for r=1:size(fmt_home_poses,1)
  %fmt_home_xy_errors_row = [];
  %fmt_home_t_errors_row = [];
  %fmt_home_outliers_row = [];
  %csm_home_xy_errors_row = [];
  %csm_home_t_errors_row = [];
  %csm_home_outliers_row = [];

  %for c=1:size(fmt_home_poses{1},2)
    %[fmt_xy fmt_t fmt_et fmt_o] = function_top_level_script(fmt_home_poses{r}{c});
    %[csm_xy csm_t csm_et csm_o] = function_top_level_script(csm_home_poses{r}{c});

    %fmt_home_xy_errors_row = [fmt_home_xy_errors_row, fmt_xy];
    %fmt_home_t_errors_row = [fmt_home_t_errors_row, fmt_t];
    %fmt_home_outliers_row = [fmt_home_outliers_row, fmt_o];

    %csm_home_xy_errors_row = [csm_home_xy_errors_row, csm_xy];
    %csm_home_t_errors_row = [csm_home_t_errors_row, csm_t];
    %csm_home_outliers_row = [csm_home_outliers_row, csm_o];

  %end
  %fmt_home_xy_errors = [fmt_home_xy_errors; fmt_home_xy_errors_row];
  %fmt_home_t_errors = [fmt_home_t_errors; fmt_home_t_errors_row];
  %fmt_home_outliers = [fmt_home_outliers; fmt_home_outliers_row];

  %csm_home_xy_errors = [csm_home_xy_errors; csm_home_xy_errors_row];
  %csm_home_t_errors = [csm_home_t_errors; csm_home_t_errors_row];
  %csm_home_outliers = [csm_home_outliers; csm_home_outliers_row];

%end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% warehouse
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%fmt_warehouse_base_str = 'vault/fmt/Centroid-based/noise_s=125/warehouse/';
%csm_warehouse_base_str = 'vault/csm/warehouse/';

%fmt_warehouse_pose_1_dir_2 = strcat(fmt_warehouse_base_str, 'pose_1/noise_s=0.01/2020-03-03_19:04:07');
%fmt_warehouse_pose_1_dir_3 = strcat(fmt_warehouse_base_str, 'pose_1/noise_s=0.02/2020-03-04_09:57:09');
%fmt_warehouse_pose_1_dir_4 = strcat(fmt_warehouse_base_str, 'pose_1/noise_s=0.05/2020-03-04_16:51:48');

%fmt_warehouse_pose_2_dir_2 = strcat(fmt_warehouse_base_str, 'pose_2/noise_s=0.01/2020-04-09_21:06:46');
%fmt_warehouse_pose_2_dir_3 = strcat(fmt_warehouse_base_str, 'pose_2/noise_s=0.02/2020-04-09_12:47:12');
%fmt_warehouse_pose_2_dir_4 = strcat(fmt_warehouse_base_str, 'pose_2/noise_s=0.05/2020-04-10_16:06:36');

%fmt_warehouse_pose_3_dir_2 = strcat(fmt_warehouse_base_str, 'pose_3/noise_s=0.01/2020-04-12_03:49:15');
%fmt_warehouse_pose_3_dir_3 = strcat(fmt_warehouse_base_str, 'pose_3/noise_s=0.02/2020-04-12_13:46:23');
%fmt_warehouse_pose_3_dir_4 = strcat(fmt_warehouse_base_str, 'pose_3/noise_s=0.05/2020-04-12_21:32:37');

%fmt_warehouse_pose_4_dir_2 = strcat(fmt_warehouse_base_str, 'pose_4/noise_s=0.01/2020-04-14_10:01:20');
%fmt_warehouse_pose_4_dir_3 = strcat(fmt_warehouse_base_str, 'pose_4/noise_s=0.02/2020-04-14_17:32:49');
%fmt_warehouse_pose_4_dir_4 = strcat(fmt_warehouse_base_str, 'pose_4/noise_s=0.05/2020-04-15_02:41:05');

%fmt_warehouse_pose_5_dir_2 = strcat(fmt_warehouse_base_str, 'pose_5/noise_s=0.01/2020-04-17_09:58:04');
%fmt_warehouse_pose_5_dir_3 = strcat(fmt_warehouse_base_str, 'pose_5/noise_s=0.02/2020-04-17_18:54:25');
%fmt_warehouse_pose_5_dir_4 = strcat(fmt_warehouse_base_str, 'pose_5/noise_s=0.05/2020-04-18_11:54:10');

%fmt_warehouse_pose_6_dir_2 = strcat(fmt_warehouse_base_str, 'pose_6/noise_s=0.01/2020-04-19_20:42:25');
%fmt_warehouse_pose_6_dir_3 = strcat(fmt_warehouse_base_str, 'pose_6/noise_s=0.02/2020-04-19_12:39:20');
%fmt_warehouse_pose_6_dir_4 = strcat(fmt_warehouse_base_str, 'pose_6/noise_s=0.05/2020-04-18_20:40:12');

%fmt_warehouse_pose_7_dir_2 = strcat(fmt_warehouse_base_str, 'pose_7/noise_s=0.01/2020-04-22_21:04:50');
%fmt_warehouse_pose_7_dir_3 = strcat(fmt_warehouse_base_str, 'pose_7/noise_s=0.02/2020-04-23_10:32:30');
%fmt_warehouse_pose_7_dir_4 = strcat(fmt_warehouse_base_str, 'pose_7/noise_s=0.05/2020-04-23_17:57:47');

%fmt_warehouse_pose_1_dirs = {fmt_warehouse_pose_1_dir_2, fmt_warehouse_pose_1_dir_3, fmt_warehouse_pose_1_dir_4};
%fmt_warehouse_pose_2_dirs = {fmt_warehouse_pose_2_dir_2, fmt_warehouse_pose_2_dir_3, fmt_warehouse_pose_2_dir_4};
%fmt_warehouse_pose_3_dirs = {fmt_warehouse_pose_3_dir_2, fmt_warehouse_pose_3_dir_3, fmt_warehouse_pose_3_dir_4};
%fmt_warehouse_pose_4_dirs = {fmt_warehouse_pose_4_dir_2, fmt_warehouse_pose_4_dir_3, fmt_warehouse_pose_4_dir_4};
%fmt_warehouse_pose_5_dirs = {fmt_warehouse_pose_5_dir_2, fmt_warehouse_pose_5_dir_3, fmt_warehouse_pose_5_dir_4};
%fmt_warehouse_pose_6_dirs = {fmt_warehouse_pose_6_dir_2, fmt_warehouse_pose_6_dir_3, fmt_warehouse_pose_6_dir_4};
%fmt_warehouse_pose_7_dirs = {fmt_warehouse_pose_7_dir_2, fmt_warehouse_pose_7_dir_3, fmt_warehouse_pose_7_dir_4};
%fmt_warehouse_poses = {fmt_warehouse_pose_1_dirs;
                  %fmt_warehouse_pose_2_dirs;
                  %fmt_warehouse_pose_3_dirs;
                  %fmt_warehouse_pose_4_dirs;
                  %fmt_warehouse_pose_5_dirs;
                  %fmt_warehouse_pose_6_dirs;
                  %fmt_warehouse_pose_7_dirs};


%csm_warehouse_pose_1_dir_2 = strcat(csm_warehouse_base_str, 'pose_1/noise_s=0.01/2020-02-18_15:30:38');
%csm_warehouse_pose_1_dir_3 = strcat(csm_warehouse_base_str, 'pose_1/noise_s=0.02/2020-02-18_19:01:13');
%csm_warehouse_pose_1_dir_4 = strcat(csm_warehouse_base_str, 'pose_1/noise_s=0.05/2020-02-18_22:27:41');

%csm_warehouse_pose_2_dir_2 = strcat(csm_warehouse_base_str, 'pose_2/noise_s=0.01/2020-04-11_12:32:05');
%csm_warehouse_pose_2_dir_3 = strcat(csm_warehouse_base_str, 'pose_2/noise_s=0.02/2020-04-11_03:20:02');
%csm_warehouse_pose_2_dir_4 = strcat(csm_warehouse_base_str, 'pose_2/noise_s=0.05/2020-04-10_23:05:03');

%csm_warehouse_pose_3_dir_2 = strcat(csm_warehouse_base_str, 'pose_3/noise_s=0.01/2020-04-13_15:14:05');
%csm_warehouse_pose_3_dir_3 = strcat(csm_warehouse_base_str, 'pose_3/noise_s=0.02/2020-04-13_12:26:42');
%csm_warehouse_pose_3_dir_4 = strcat(csm_warehouse_base_str, 'pose_3/noise_s=0.05/2020-04-13_09:40:39');

%csm_warehouse_pose_4_dir_2 = strcat(csm_warehouse_base_str, 'pose_4/noise_s=0.01/2020-04-15_13:18:07');
%csm_warehouse_pose_4_dir_3 = strcat(csm_warehouse_base_str, 'pose_4/noise_s=0.02/2020-04-15_16:55:41');
%csm_warehouse_pose_4_dir_4 = strcat(csm_warehouse_base_str, 'pose_4/noise_s=0.05/2020-04-15_20:00:49');

%csm_warehouse_pose_5_dir_2 = strcat(csm_warehouse_base_str, 'pose_5/noise_s=0.01/2020-04-16_17:00:25');
%csm_warehouse_pose_5_dir_3 = strcat(csm_warehouse_base_str, 'pose_5/noise_s=0.02/2020-04-16_14:12:22');
%csm_warehouse_pose_5_dir_4 = strcat(csm_warehouse_base_str, 'pose_5/noise_s=0.05/2020-04-16_11:18:29');

%csm_warehouse_pose_6_dir_2 = strcat(csm_warehouse_base_str, 'pose_6/noise_s=0.01/2020-04-20_19:56:36');
%csm_warehouse_pose_6_dir_3 = strcat(csm_warehouse_base_str, 'pose_6/noise_s=0.02/2020-04-20_23:25:54');
%csm_warehouse_pose_6_dir_4 = strcat(csm_warehouse_base_str, 'pose_6/noise_s=0.05/2020-04-21_10:12:35');

%csm_warehouse_pose_7_dir_2 = strcat(csm_warehouse_base_str, 'pose_7/noise_s=0.01/2020-04-21_22:19:52');
%csm_warehouse_pose_7_dir_3 = strcat(csm_warehouse_base_str, 'pose_7/noise_s=0.02/2020-04-21_19:31:55');
%csm_warehouse_pose_7_dir_4 = strcat(csm_warehouse_base_str, 'pose_7/noise_s=0.05/2020-04-21_15:20:14');

%csm_warehouse_pose_1_dirs = {csm_warehouse_pose_1_dir_2, csm_warehouse_pose_1_dir_3, csm_warehouse_pose_1_dir_4};
%csm_warehouse_pose_2_dirs = {csm_warehouse_pose_2_dir_2, csm_warehouse_pose_2_dir_3, csm_warehouse_pose_2_dir_4};
%csm_warehouse_pose_3_dirs = {csm_warehouse_pose_3_dir_2, csm_warehouse_pose_3_dir_3, csm_warehouse_pose_3_dir_4};
%csm_warehouse_pose_4_dirs = {csm_warehouse_pose_4_dir_2, csm_warehouse_pose_4_dir_3, csm_warehouse_pose_4_dir_4};
%csm_warehouse_pose_5_dirs = {csm_warehouse_pose_5_dir_2, csm_warehouse_pose_5_dir_3, csm_warehouse_pose_5_dir_4};
%csm_warehouse_pose_6_dirs = {csm_warehouse_pose_6_dir_2, csm_warehouse_pose_6_dir_3, csm_warehouse_pose_6_dir_4};
%csm_warehouse_pose_7_dirs = {csm_warehouse_pose_7_dir_2, csm_warehouse_pose_7_dir_3, csm_warehouse_pose_7_dir_4};
%csm_warehouse_poses = {csm_warehouse_pose_1_dirs;
                  %csm_warehouse_pose_2_dirs;
                  %csm_warehouse_pose_3_dirs;
                  %csm_warehouse_pose_4_dirs;
                  %csm_warehouse_pose_5_dirs;
                  %csm_warehouse_pose_6_dirs;
                  %csm_warehouse_pose_7_dirs};



%fmt_warehouse_xy_errors = [];
%fmt_warehouse_t_errors = [];
%fmt_warehouse_outliers = [];

%csm_warehouse_xy_errors = [];
%csm_warehouse_t_errors = [];
%csm_warehouse_outliers = [];


%for r=1:size(fmt_warehouse_poses,1)
  %fmt_warehouse_xy_errors_row = [];
  %fmt_warehouse_t_errors_row = [];
  %fmt_warehouse_outliers_row = [];
  %csm_warehouse_xy_errors_row = [];
  %csm_warehouse_t_errors_row = [];
  %csm_warehouse_outliers_row = [];

  %for c=1:size(fmt_warehouse_poses{1},2)
    %[fmt_xy fmt_t fmt_et fmt_o] = function_top_level_script(fmt_warehouse_poses{r}{c});
    %[csm_xy csm_t csm_et csm_o] = function_top_level_script(csm_warehouse_poses{r}{c});

    %fmt_warehouse_xy_errors_row = [fmt_warehouse_xy_errors_row, fmt_xy];
    %fmt_warehouse_t_errors_row = [fmt_warehouse_t_errors_row, fmt_t];
    %fmt_warehouse_outliers_row = [fmt_warehouse_outliers_row, fmt_o];

    %csm_warehouse_xy_errors_row = [csm_warehouse_xy_errors_row, csm_xy];
    %csm_warehouse_t_errors_row = [csm_warehouse_t_errors_row, csm_t];
    %csm_warehouse_outliers_row = [csm_warehouse_outliers_row, csm_o];

  %end
  %fmt_warehouse_xy_errors = [fmt_warehouse_xy_errors; fmt_warehouse_xy_errors_row];
  %fmt_warehouse_t_errors = [fmt_warehouse_t_errors; fmt_warehouse_t_errors_row];
  %fmt_warehouse_outliers = [fmt_warehouse_outliers; fmt_warehouse_outliers_row];

  %csm_warehouse_xy_errors = [csm_warehouse_xy_errors; csm_warehouse_xy_errors_row];
  %csm_warehouse_t_errors = [csm_warehouse_t_errors; csm_warehouse_t_errors_row];
  %csm_warehouse_outliers = [csm_warehouse_outliers; csm_warehouse_outliers_row];

%end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% willowgarage
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%fmt_willowgarage_base_str = 'vault/fmt/Centroid-based/noise_s=125/willowgarage/';
%csm_willowgarage_base_str = 'vault/csm/willowgarage/';

%fmt_willowgarage_pose_1_dir_2 = strcat(fmt_willowgarage_base_str, 'pose_1/noise_s=0.01/2020-03-06_09:53:14');
%fmt_willowgarage_pose_1_dir_3 = strcat(fmt_willowgarage_base_str, 'pose_1/noise_s=0.02/2020-03-06_21:25:00');
%fmt_willowgarage_pose_1_dir_4 = strcat(fmt_willowgarage_base_str, 'pose_1/noise_s=0.05/2020-03-07_11:10:20');

%fmt_willowgarage_pose_2_dir_2 = strcat(fmt_willowgarage_base_str, 'pose_2/noise_s=0.01/2020-04-28_15:28:06');
%fmt_willowgarage_pose_2_dir_3 = strcat(fmt_willowgarage_base_str, 'pose_2/noise_s=0.02/2020-04-28_02:20:42');
%fmt_willowgarage_pose_2_dir_4 = strcat(fmt_willowgarage_base_str, 'pose_2/noise_s=0.05/2020-04-27_11:23:22');

%fmt_willowgarage_pose_3_dir_2 = strcat(fmt_willowgarage_base_str, 'pose_3/noise_s=0.01/2020-05-04_03:16:21');
%fmt_willowgarage_pose_3_dir_3 = strcat(fmt_willowgarage_base_str, 'pose_3/noise_s=0.02/2020-05-03_14:55:59');
%fmt_willowgarage_pose_3_dir_4 = strcat(fmt_willowgarage_base_str, 'pose_3/noise_s=0.05/2020-05-02_19:26:17');

%fmt_willowgarage_pose_4_dir_2 = strcat(fmt_willowgarage_base_str, 'pose_4/noise_s=0.01/2020-05-13_17:00:41');
%fmt_willowgarage_pose_4_dir_3 = strcat(fmt_willowgarage_base_str, 'pose_4/noise_s=0.02/2020-05-13_01:41:43');
%fmt_willowgarage_pose_4_dir_4 = strcat(fmt_willowgarage_base_str, 'pose_4/noise_s=0.05/2020-05-12_10:09:45');

%fmt_willowgarage_pose_5_dir_2 = strcat(fmt_willowgarage_base_str, 'pose_5/noise_s=0.01/2020-05-18_10:54:29');
%fmt_willowgarage_pose_5_dir_3 = strcat(fmt_willowgarage_base_str, 'pose_5/noise_s=0.02/2020-05-18_23:57:28');
%fmt_willowgarage_pose_5_dir_4 = strcat(fmt_willowgarage_base_str, 'pose_5/noise_s=0.05/2020-05-19_13:49:46');

%fmt_willowgarage_pose_6_dir_2 = strcat(fmt_willowgarage_base_str, 'pose_6/noise_s=0.01/2020-05-21_15:13:01');
%fmt_willowgarage_pose_6_dir_3 = strcat(fmt_willowgarage_base_str, 'pose_6/noise_s=0.02/2020-05-21_01:41:00');
%fmt_willowgarage_pose_6_dir_4 = strcat(fmt_willowgarage_base_str, 'pose_6/noise_s=0.05/2020-05-20_11:58:34');

%fmt_willowgarage_pose_7_dir_2 = strcat(fmt_willowgarage_base_str, 'pose_7/noise_s=0.01/2020-05-26_23:57:36');
%fmt_willowgarage_pose_7_dir_3 = strcat(fmt_willowgarage_base_str, 'pose_7/noise_s=0.02/2020-05-26_10:53:10');
%fmt_willowgarage_pose_7_dir_4 = strcat(fmt_willowgarage_base_str, 'pose_7/noise_s=0.05/2020-05-25_15:13:10');

%fmt_willowgarage_pose_8_dir_2 = strcat(fmt_willowgarage_base_str, 'pose_8/noise_s=0.01/2020-06-02_15:09:49');
%fmt_willowgarage_pose_8_dir_3 = strcat(fmt_willowgarage_base_str, 'pose_8/noise_s=0.02/2020-06-02_02:02:40');
%fmt_willowgarage_pose_8_dir_4 = strcat(fmt_willowgarage_base_str, 'pose_8/noise_s=0.05/2020-06-01_11:47:00');

%fmt_willowgarage_pose_9_dir_2 = strcat(fmt_willowgarage_base_str, 'pose_9/noise_s=0.01/2020-06-17_10:32:36');
%fmt_willowgarage_pose_9_dir_3 = strcat(fmt_willowgarage_base_str, 'pose_9/noise_s=0.02/2020-06-18_01:05:53');
%fmt_willowgarage_pose_9_dir_4 = strcat(fmt_willowgarage_base_str, 'pose_9/noise_s=0.05/2020-06-18_14:35:53');

%fmt_willowgarage_pose_10_dir_2 = strcat(fmt_willowgarage_base_str, 'pose_10/noise_s=0.01/2020-06-23_11:05:58');
%fmt_willowgarage_pose_10_dir_3 = strcat(fmt_willowgarage_base_str, 'pose_10/noise_s=0.02/2020-06-22_14:12:20');
%fmt_willowgarage_pose_10_dir_4 = strcat(fmt_willowgarage_base_str, 'pose_10/noise_s=0.05/2020-06-22_01:01:07');


%fmt_willowgarage_pose_1_dirs = {fmt_willowgarage_pose_1_dir_2, fmt_willowgarage_pose_1_dir_3, fmt_willowgarage_pose_1_dir_4};
%fmt_willowgarage_pose_2_dirs = {fmt_willowgarage_pose_2_dir_2, fmt_willowgarage_pose_2_dir_3, fmt_willowgarage_pose_2_dir_4};
%fmt_willowgarage_pose_3_dirs = {fmt_willowgarage_pose_3_dir_2, fmt_willowgarage_pose_3_dir_3, fmt_willowgarage_pose_3_dir_4};
%fmt_willowgarage_pose_4_dirs = {fmt_willowgarage_pose_4_dir_2, fmt_willowgarage_pose_4_dir_3, fmt_willowgarage_pose_4_dir_4};
%fmt_willowgarage_pose_5_dirs = {fmt_willowgarage_pose_5_dir_2, fmt_willowgarage_pose_5_dir_3, fmt_willowgarage_pose_5_dir_4};
%fmt_willowgarage_pose_6_dirs = {fmt_willowgarage_pose_6_dir_2, fmt_willowgarage_pose_6_dir_3, fmt_willowgarage_pose_6_dir_4};
%fmt_willowgarage_pose_7_dirs = {fmt_willowgarage_pose_7_dir_2, fmt_willowgarage_pose_7_dir_3, fmt_willowgarage_pose_7_dir_4};
%fmt_willowgarage_pose_8_dirs = {fmt_willowgarage_pose_8_dir_2, fmt_willowgarage_pose_8_dir_3, fmt_willowgarage_pose_8_dir_4};
%fmt_willowgarage_pose_9_dirs = {fmt_willowgarage_pose_9_dir_2, fmt_willowgarage_pose_9_dir_3, fmt_willowgarage_pose_9_dir_4};
%fmt_willowgarage_pose_10_dirs = {fmt_willowgarage_pose_10_dir_2, fmt_willowgarage_pose_10_dir_3, fmt_willowgarage_pose_10_dir_4};
%fmt_willowgarage_poses = {fmt_willowgarage_pose_1_dirs;
                  %fmt_willowgarage_pose_2_dirs;
                  %fmt_willowgarage_pose_3_dirs;
                  %fmt_willowgarage_pose_4_dirs;
                  %fmt_willowgarage_pose_5_dirs;
                  %fmt_willowgarage_pose_6_dirs;
                  %fmt_willowgarage_pose_7_dirs;
                  %fmt_willowgarage_pose_8_dirs;
                  %fmt_willowgarage_pose_9_dirs;
                  %fmt_willowgarage_pose_10_dirs};


%csm_willowgarage_pose_1_dir_2 = strcat(csm_willowgarage_base_str, 'pose_1/noise_s=0.01/2020-03-09_14:20:59');
%csm_willowgarage_pose_1_dir_3 = strcat(csm_willowgarage_base_str, 'pose_1/noise_s=0.02/2020-03-09_16:47:45');
%csm_willowgarage_pose_1_dir_4 = strcat(csm_willowgarage_base_str, 'pose_1/noise_s=0.05/2020-03-09_19:15:13');

%csm_willowgarage_pose_2_dir_2 = strcat(csm_willowgarage_base_str, 'pose_2/noise_s=0.01/2020-04-30_15:19:27');
%csm_willowgarage_pose_2_dir_3 = strcat(csm_willowgarage_base_str, 'pose_2/noise_s=0.02/2020-04-30_21:40:38');
%csm_willowgarage_pose_2_dir_4 = strcat(csm_willowgarage_base_str, 'pose_2/noise_s=0.05/2020-05-02_00:05:56');

%csm_willowgarage_pose_3_dir_2 = strcat(csm_willowgarage_base_str, 'pose_3/noise_s=0.01/2020-05-05_15:41:14');
%csm_willowgarage_pose_3_dir_3 = strcat(csm_willowgarage_base_str, 'pose_3/noise_s=0.02/2020-05-05_20:57:25');
%csm_willowgarage_pose_3_dir_4 = strcat(csm_willowgarage_base_str, 'pose_3/noise_s=0.05/2020-05-06_10:03:08');

%csm_willowgarage_pose_4_dir_2 = strcat(csm_willowgarage_base_str, 'pose_4/noise_s=0.01/2020-05-15_14:41:34');
%csm_willowgarage_pose_4_dir_3 = strcat(csm_willowgarage_base_str, 'pose_4/noise_s=0.02/2020-05-15_20:26:15');
%csm_willowgarage_pose_4_dir_4 = strcat(csm_willowgarage_base_str, 'pose_4/noise_s=0.05/2020-05-16_00:44:39');

%csm_willowgarage_pose_5_dir_2 = strcat(csm_willowgarage_base_str, 'pose_5/noise_s=0.01/2020-05-16_22:08:10');
%csm_willowgarage_pose_5_dir_3 = strcat(csm_willowgarage_base_str, 'pose_5/noise_s=0.02/2020-05-16_17:49:27');
%csm_willowgarage_pose_5_dir_4 = strcat(csm_willowgarage_base_str, 'pose_5/noise_s=0.05/2020-05-16_14:03:59');

%csm_willowgarage_pose_6_dir_2 = strcat(csm_willowgarage_base_str, 'pose_6/noise_s=0.01/2020-05-23_13:38:56');
%csm_willowgarage_pose_6_dir_3 = strcat(csm_willowgarage_base_str, 'pose_6/noise_s=0.02/2020-05-23_18:02:10');
%csm_willowgarage_pose_6_dir_4 = strcat(csm_willowgarage_base_str, 'pose_6/noise_s=0.05/2020-05-23_21:56:11');

%csm_willowgarage_pose_7_dir_2 = strcat(csm_willowgarage_base_str, 'pose_7/noise_s=0.01/2020-05-28_15:27:10');
%csm_willowgarage_pose_7_dir_3 = strcat(csm_willowgarage_base_str, 'pose_7/noise_s=0.02/2020-05-28_20:21:35');
%csm_willowgarage_pose_7_dir_4 = strcat(csm_willowgarage_base_str, 'pose_7/noise_s=0.05/2020-05-29_00:35:12');

%csm_willowgarage_pose_8_dir_2 = strcat(csm_willowgarage_base_str, 'pose_8/noise_s=0.01/2020-06-04_16:06:56');
%csm_willowgarage_pose_8_dir_3 = strcat(csm_willowgarage_base_str, 'pose_8/noise_s=0.02/2020-06-05_10:50:30');
%csm_willowgarage_pose_8_dir_4 = strcat(csm_willowgarage_base_str, 'pose_8/noise_s=0.05/2020-06-06_20:22:08');

%csm_willowgarage_pose_9_dir_2 = strcat(csm_willowgarage_base_str, 'pose_9/noise_s=0.01/2020-06-19_18:15:56');
%csm_willowgarage_pose_9_dir_3 = strcat(csm_willowgarage_base_str, 'pose_9/noise_s=0.02/2020-06-19_14:21:47');
%csm_willowgarage_pose_9_dir_4 = strcat(csm_willowgarage_base_str, 'pose_9/noise_s=0.05/2020-06-19_10:19:51');

%csm_willowgarage_pose_10_dir_2 = strcat(csm_willowgarage_base_str, 'pose_10/noise_s=0.01/2020-06-21_11:47:37');
%csm_willowgarage_pose_10_dir_3 = strcat(csm_willowgarage_base_str, 'pose_10/noise_s=0.02/2020-06-21_17:17:16');
%csm_willowgarage_pose_10_dir_4 = strcat(csm_willowgarage_base_str, 'pose_10/noise_s=0.05/2020-06-21_21:09:28');


%csm_willowgarage_pose_1_dirs = {csm_willowgarage_pose_1_dir_2, csm_willowgarage_pose_1_dir_3, csm_willowgarage_pose_1_dir_4};
%csm_willowgarage_pose_2_dirs = {csm_willowgarage_pose_2_dir_2, csm_willowgarage_pose_2_dir_3, csm_willowgarage_pose_2_dir_4};
%csm_willowgarage_pose_3_dirs = {csm_willowgarage_pose_3_dir_2, csm_willowgarage_pose_3_dir_3, csm_willowgarage_pose_3_dir_4};
%csm_willowgarage_pose_4_dirs = {csm_willowgarage_pose_4_dir_2, csm_willowgarage_pose_4_dir_3, csm_willowgarage_pose_4_dir_4};
%csm_willowgarage_pose_5_dirs = {csm_willowgarage_pose_5_dir_2, csm_willowgarage_pose_5_dir_3, csm_willowgarage_pose_5_dir_4};
%csm_willowgarage_pose_6_dirs = {csm_willowgarage_pose_6_dir_2, csm_willowgarage_pose_6_dir_3, csm_willowgarage_pose_6_dir_4};
%csm_willowgarage_pose_7_dirs = {csm_willowgarage_pose_7_dir_2, csm_willowgarage_pose_7_dir_3, csm_willowgarage_pose_7_dir_4};
%csm_willowgarage_pose_8_dirs = {csm_willowgarage_pose_8_dir_2, csm_willowgarage_pose_8_dir_3, csm_willowgarage_pose_8_dir_4};
%csm_willowgarage_pose_9_dirs = {csm_willowgarage_pose_9_dir_2, csm_willowgarage_pose_9_dir_3, csm_willowgarage_pose_9_dir_4};
%csm_willowgarage_pose_10_dirs = {csm_willowgarage_pose_10_dir_2, csm_willowgarage_pose_10_dir_3, csm_willowgarage_pose_10_dir_4};
%csm_willowgarage_poses = {csm_willowgarage_pose_1_dirs;
                  %csm_willowgarage_pose_2_dirs;
                  %csm_willowgarage_pose_3_dirs;
                  %csm_willowgarage_pose_4_dirs;
                  %csm_willowgarage_pose_5_dirs;
                  %csm_willowgarage_pose_6_dirs;
                  %csm_willowgarage_pose_7_dirs;
                  %csm_willowgarage_pose_8_dirs;
                  %csm_willowgarage_pose_9_dirs;
                  %csm_willowgarage_pose_10_dirs};



%fmt_willowgarage_xy_errors = [];
%fmt_willowgarage_t_errors = [];
%fmt_willowgarage_outliers = [];

%csm_willowgarage_xy_errors = [];
%csm_willowgarage_t_errors = [];
%csm_willowgarage_outliers = [];


%for r=1:size(fmt_willowgarage_poses,1)
  %fmt_willowgarage_xy_errors_row = [];
  %fmt_willowgarage_t_errors_row = [];
  %fmt_willowgarage_outliers_row = [];
  %csm_willowgarage_xy_errors_row = [];
  %csm_willowgarage_t_errors_row = [];
  %csm_willowgarage_outliers_row = [];

  %for c=1:size(fmt_willowgarage_poses{1},2)
    %[fmt_xy fmt_t fmt_et fmt_o] = function_top_level_script(fmt_willowgarage_poses{r}{c});
    %[csm_xy csm_t csm_et csm_o] = function_top_level_script(csm_willowgarage_poses{r}{c});

    %fmt_willowgarage_xy_errors_row = [fmt_willowgarage_xy_errors_row, fmt_xy];
    %fmt_willowgarage_t_errors_row = [fmt_willowgarage_t_errors_row, fmt_t];
    %fmt_willowgarage_outliers_row = [fmt_willowgarage_outliers_row, fmt_o];

    %csm_willowgarage_xy_errors_row = [csm_willowgarage_xy_errors_row, csm_xy];
    %csm_willowgarage_t_errors_row = [csm_willowgarage_t_errors_row, csm_t];
    %csm_willowgarage_outliers_row = [csm_willowgarage_outliers_row, csm_o];

  %end
  %fmt_willowgarage_xy_errors = [fmt_willowgarage_xy_errors; fmt_willowgarage_xy_errors_row];
  %fmt_willowgarage_t_errors = [fmt_willowgarage_t_errors; fmt_willowgarage_t_errors_row];
  %fmt_willowgarage_outliers = [fmt_willowgarage_outliers; fmt_willowgarage_outliers_row];

  %csm_willowgarage_xy_errors = [csm_willowgarage_xy_errors; csm_willowgarage_xy_errors_row];
  %csm_willowgarage_t_errors = [csm_willowgarage_t_errors; csm_willowgarage_t_errors_row];
  %csm_willowgarage_outliers = [csm_willowgarage_outliers; csm_willowgarage_outliers_row];

%end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% landfill
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%fmt_landfill_base_str = 'vault/fmt/Centroid-based/noise_s=125/dirtrack/';
%csm_landfill_base_str = 'vault/csm/dirtrack/';

%fmt_landfill_pose_1_dir_2 = strcat(fmt_landfill_base_str, 'pose_1/noise_s=0.01/2020-11-01_02:23:58');
%fmt_landfill_pose_1_dir_3 = strcat(fmt_landfill_base_str, 'pose_1/noise_s=0.02/2020-11-01_13:13:11');
%fmt_landfill_pose_1_dir_4 = strcat(fmt_landfill_base_str, 'pose_1/noise_s=0.05/2020-11-01_18:32:10');

%fmt_landfill_pose_2_dir_2 = strcat(fmt_landfill_base_str, 'pose_2/noise_s=0.01/2020-11-02_10:35:55');
%fmt_landfill_pose_2_dir_3 = strcat(fmt_landfill_base_str, 'pose_2/noise_s=0.02/2020-11-02_16:08:14');
%fmt_landfill_pose_2_dir_4 = strcat(fmt_landfill_base_str, 'pose_2/noise_s=0.05/2020-11-02_19:59:29');

%fmt_landfill_pose_3_dir_2 = strcat(fmt_landfill_base_str, 'pose_3/noise_s=0.01/2020-11-03_10:45:46');
%fmt_landfill_pose_3_dir_3 = strcat(fmt_landfill_base_str, 'pose_3/noise_s=0.02/2020-11-03_15:13:38');
%fmt_landfill_pose_3_dir_4 = strcat(fmt_landfill_base_str, 'pose_3/noise_s=0.05/2020-11-03_19:11:24');

%fmt_landfill_pose_4_dir_2 = strcat(fmt_landfill_base_str, 'pose_4/noise_s=0.01/2020-11-04_10:53:59');
%fmt_landfill_pose_4_dir_3 = strcat(fmt_landfill_base_str, 'pose_4/noise_s=0.02/2020-11-04_14:46:46');
%fmt_landfill_pose_4_dir_4 = strcat(fmt_landfill_base_str, 'pose_4/noise_s=0.05/2020-11-04_18:48:03');

%fmt_landfill_pose_5_dir_2 = strcat(fmt_landfill_base_str, 'pose_5/noise_s=0.01/2020-11-05_02:54:21');
%fmt_landfill_pose_5_dir_3 = strcat(fmt_landfill_base_str, 'pose_5/noise_s=0.02/2020-11-05_10:43:56');
%fmt_landfill_pose_5_dir_4 = strcat(fmt_landfill_base_str, 'pose_5/noise_s=0.05/2020-11-05_15:17:09');

%fmt_landfill_pose_6_dir_2 = strcat(fmt_landfill_base_str, 'pose_6/noise_s=0.01/2020-11-06_01:43:11');
%fmt_landfill_pose_6_dir_3 = strcat(fmt_landfill_base_str, 'pose_6/noise_s=0.02/2020-11-06_10:12:29');
%fmt_landfill_pose_6_dir_4 = strcat(fmt_landfill_base_str, 'pose_6/noise_s=0.05/2020-11-06_14:04:24');

%fmt_landfill_pose_7_dir_2 = strcat(fmt_landfill_base_str, 'pose_7/noise_s=0.01/2020-11-06_22:12:47');
%fmt_landfill_pose_7_dir_3 = strcat(fmt_landfill_base_str, 'pose_7/noise_s=0.02/2020-11-07_02:56:06');
%fmt_landfill_pose_7_dir_4 = strcat(fmt_landfill_base_str, 'pose_7/noise_s=0.05/2020-11-07_13:27:11');

%fmt_landfill_pose_1_dirs = {fmt_landfill_pose_1_dir_2, fmt_landfill_pose_1_dir_3, fmt_landfill_pose_1_dir_4};
%fmt_landfill_pose_2_dirs = {fmt_landfill_pose_2_dir_2, fmt_landfill_pose_2_dir_3, fmt_landfill_pose_2_dir_4};
%fmt_landfill_pose_3_dirs = {fmt_landfill_pose_3_dir_2, fmt_landfill_pose_3_dir_3, fmt_landfill_pose_3_dir_4};
%fmt_landfill_pose_4_dirs = {fmt_landfill_pose_4_dir_2, fmt_landfill_pose_4_dir_3, fmt_landfill_pose_4_dir_4};
%fmt_landfill_pose_5_dirs = {fmt_landfill_pose_5_dir_2, fmt_landfill_pose_5_dir_3, fmt_landfill_pose_5_dir_4};
%fmt_landfill_pose_6_dirs = {fmt_landfill_pose_6_dir_2, fmt_landfill_pose_6_dir_3, fmt_landfill_pose_6_dir_4};
%fmt_landfill_pose_7_dirs = {fmt_landfill_pose_7_dir_2, fmt_landfill_pose_7_dir_3, fmt_landfill_pose_7_dir_4};
%fmt_landfill_poses = {fmt_landfill_pose_1_dirs;
                  %fmt_landfill_pose_2_dirs;
                  %fmt_landfill_pose_3_dirs;
                  %fmt_landfill_pose_4_dirs;
                  %fmt_landfill_pose_5_dirs;
                  %fmt_landfill_pose_6_dirs;
                  %fmt_landfill_pose_7_dirs};


%csm_landfill_pose_1_dir_2 = strcat(csm_landfill_base_str, 'pose_1/noise_s=0.01/2020-11-07_23:52:27');
%csm_landfill_pose_1_dir_3 = strcat(csm_landfill_base_str, 'pose_1/noise_s=0.02/2020-11-07_21:48:38');
%csm_landfill_pose_1_dir_4 = strcat(csm_landfill_base_str, 'pose_1/noise_s=0.05/2020-11-07_17:31:00');

%csm_landfill_pose_2_dir_2 = strcat(csm_landfill_base_str, 'pose_2/noise_s=0.01/2020-11-08_14:44:27');
%csm_landfill_pose_2_dir_3 = strcat(csm_landfill_base_str, 'pose_2/noise_s=0.02/2020-11-08_17:27:11');
%csm_landfill_pose_2_dir_4 = strcat(csm_landfill_base_str, 'pose_2/noise_s=0.05/2020-11-08_20:12:34');

%csm_landfill_pose_3_dir_2 = strcat(csm_landfill_base_str, 'pose_3/noise_s=0.01/2020-11-09_10:07:28');
%csm_landfill_pose_3_dir_3 = strcat(csm_landfill_base_str, 'pose_3/noise_s=0.02/2020-11-09_12:12:11');
%csm_landfill_pose_3_dir_4 = strcat(csm_landfill_base_str, 'pose_3/noise_s=0.05/2020-11-09_14:18:56');

%csm_landfill_pose_4_dir_2 = strcat(csm_landfill_base_str, 'pose_4/noise_s=0.01/2020-11-09_18:24:57');
%csm_landfill_pose_4_dir_3 = strcat(csm_landfill_base_str, 'pose_4/noise_s=0.02/2020-11-09_20:54:44');
%csm_landfill_pose_4_dir_4 = strcat(csm_landfill_base_str, 'pose_4/noise_s=0.05/2020-11-09_23:07:32');

%csm_landfill_pose_5_dir_2 = strcat(csm_landfill_base_str, 'pose_5/noise_s=0.01/2020-11-10_10:35:26');
%csm_landfill_pose_5_dir_3 = strcat(csm_landfill_base_str, 'pose_5/noise_s=0.02/2020-11-10_12:37:31');
%csm_landfill_pose_5_dir_4 = strcat(csm_landfill_base_str, 'pose_5/noise_s=0.05/2020-11-10_14:57:32');

%csm_landfill_pose_6_dir_2 = strcat(csm_landfill_base_str, 'pose_6/noise_s=0.01/2020-11-10_19:11:36');
%csm_landfill_pose_6_dir_3 = strcat(csm_landfill_base_str, 'pose_6/noise_s=0.02/2020-11-10_21:29:43');
%csm_landfill_pose_6_dir_4 = strcat(csm_landfill_base_str, 'pose_6/noise_s=0.05/2020-11-10_23:57:44');

%csm_landfill_pose_7_dir_2 = strcat(csm_landfill_base_str, 'pose_7/noise_s=0.01/2020-11-11_11:06:06');
%csm_landfill_pose_7_dir_3 = strcat(csm_landfill_base_str, 'pose_7/noise_s=0.02/2020-11-11_13:12:29');
%csm_landfill_pose_7_dir_4 = strcat(csm_landfill_base_str, 'pose_7/noise_s=0.05/2020-11-11_15:12:33');

%csm_landfill_pose_1_dirs = {csm_landfill_pose_1_dir_2, csm_landfill_pose_1_dir_3, csm_landfill_pose_1_dir_4};
%csm_landfill_pose_2_dirs = {csm_landfill_pose_2_dir_2, csm_landfill_pose_2_dir_3, csm_landfill_pose_2_dir_4};
%csm_landfill_pose_3_dirs = {csm_landfill_pose_3_dir_2, csm_landfill_pose_3_dir_3, csm_landfill_pose_3_dir_4};
%csm_landfill_pose_4_dirs = {csm_landfill_pose_4_dir_2, csm_landfill_pose_4_dir_3, csm_landfill_pose_4_dir_4};
%csm_landfill_pose_5_dirs = {csm_landfill_pose_5_dir_2, csm_landfill_pose_5_dir_3, csm_landfill_pose_5_dir_4};
%csm_landfill_pose_6_dirs = {csm_landfill_pose_6_dir_2, csm_landfill_pose_6_dir_3, csm_landfill_pose_6_dir_4};
%csm_landfill_pose_7_dirs = {csm_landfill_pose_7_dir_2, csm_landfill_pose_7_dir_3, csm_landfill_pose_7_dir_4};
%csm_landfill_poses = {csm_landfill_pose_1_dirs;
                  %csm_landfill_pose_2_dirs;
                  %csm_landfill_pose_3_dirs;
                  %csm_landfill_pose_4_dirs;
                  %csm_landfill_pose_5_dirs;
                  %csm_landfill_pose_6_dirs;
                  %csm_landfill_pose_7_dirs};



%fmt_landfill_xy_errors = [];
%fmt_landfill_t_errors = [];
%fmt_landfill_outliers = [];

%csm_landfill_xy_errors = [];
%csm_landfill_t_errors = [];
%csm_landfill_outliers = [];


%for r=1:size(fmt_landfill_poses,1)
  %fmt_landfill_xy_errors_row = [];
  %fmt_landfill_t_errors_row = [];
  %fmt_landfill_outliers_row = [];
  %csm_landfill_xy_errors_row = [];
  %csm_landfill_t_errors_row = [];
  %csm_landfill_outliers_row = [];

  %for c=1:size(fmt_landfill_poses{1},2)
    %[fmt_xy fmt_t fmt_et fmt_o] = function_top_level_script(fmt_landfill_poses{r}{c});
    %[csm_xy csm_t csm_et csm_o] = function_top_level_script(csm_landfill_poses{r}{c});

    %fmt_landfill_xy_errors_row = [fmt_landfill_xy_errors_row, fmt_xy];
    %fmt_landfill_t_errors_row = [fmt_landfill_t_errors_row, fmt_t];
    %fmt_landfill_outliers_row = [fmt_landfill_outliers_row, fmt_o];

    %csm_landfill_xy_errors_row = [csm_landfill_xy_errors_row, csm_xy];
    %csm_landfill_t_errors_row = [csm_landfill_t_errors_row, csm_t];
    %csm_landfill_outliers_row = [csm_landfill_outliers_row, csm_o];

  %end
  %fmt_landfill_xy_errors = [fmt_landfill_xy_errors; fmt_landfill_xy_errors_row];
  %fmt_landfill_t_errors = [fmt_landfill_t_errors; fmt_landfill_t_errors_row];
  %fmt_landfill_outliers = [fmt_landfill_outliers; fmt_landfill_outliers_row];

  %csm_landfill_xy_errors = [csm_landfill_xy_errors; csm_landfill_xy_errors_row];
  %csm_landfill_t_errors = [csm_landfill_t_errors; csm_landfill_t_errors_row];
  %csm_landfill_outliers = [csm_landfill_outliers; csm_landfill_outliers_row];
%end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% POSITION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cd(here);
xaxis = [1 2 3];
c = colours2();
linewidth = 3;
s = [];

h = figure(1);
set(h,'position',[1 1 240 600]);
title('Mean inlier location error [m]');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s(1) = subplot(5,2,1);
hold on;
plot(xaxis, csm_corridor_xy_errors(1,:), 'marker', '.', 'color', [c{1}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_corridor_xy_errors(2,:), 'marker', '.', 'color', [c{2}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_corridor_xy_errors(3,:), 'marker', '.', 'color', [c{3}(2,:)], 'linewidth', linewidth);

xlim([0.5 3.5]);
ylim([0.0 0.05]);
title('PLICP');
set(gca, 'XTick', [1 2 3]);
set(gca, 'xticklabel', {'\\scriptsize  $0.01$', '\\scriptsize  $0.02$', '\\scriptsize  $0.05$'});
set(gca, 'YTick', [0.0 0.01 0.02 0.03 0.04 0.05]);
set(gca, 'yticklabel', {'\\small $0.0$', '\\small $0.01$', '\\small $0.02$', '\\small $0.03$', '\\small $0.04$', '\\small $0.05$'});
set(gca, 'ylabel', '\small CORRIDOR');
set(gca,'xticklabel',[])
box on;

s(2) = subplot(5,2,2);
hold on;
plot(xaxis, fmt_corridor_xy_errors(1,:), 'marker', '.', 'color', [c{1}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_corridor_xy_errors(2,:), 'marker', '.', 'color', [c{2}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_corridor_xy_errors(3,:), 'marker', '.', 'color', [c{3}(2,:)], 'linewidth', linewidth);

xlim([0.5 3.5]);
ylim([0.0 0.05]);
title('PGL-FMIC');
set(gca, 'XTick', [1 2 3]);
set(gca, 'xticklabel', {'\\scriptsize  $0.01$', '\\scriptsize  $0.02$', '\\scriptsize  $0.05$'});
set(gca, 'YTick', [0.0 0.01 0.02 0.03 0.04 0.05]);
set(gca, 'yticklabel', {'\\small $0.0$', '\\small $0.01$', '\\small $0.02$', '\\small $0.03$', '\\small $0.04$', '\\small $0.05$'});
set(gca,'xticklabel',[])
box on;




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s(3) = subplot(5,2,3);
hold on;
plot(xaxis, csm_home_xy_errors(1,:), 'marker',  '.', 'color', [c{1}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_home_xy_errors(2,:), 'marker',  '.', 'color', [c{2}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_home_xy_errors(3,:), 'marker',  '.', 'color', [c{3}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_home_xy_errors(4,:), 'marker',  '.', 'color', [c{4}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_home_xy_errors(5,:), 'marker',  '.', 'color', [c{5}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_home_xy_errors(6,:), 'marker',  '.', 'color', [c{6}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_home_xy_errors(7,:), 'marker',  '.', 'color', [c{7}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_home_xy_errors(8,:), 'marker',  '.', 'color', [c{8}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_home_xy_errors(9,:), 'marker',  '.', 'color', [c{9}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_home_xy_errors(10,:), 'marker', '.', 'color',[c{10}(2,:)]);
plot(xaxis, csm_home_xy_errors(11,:), 'marker', '.', 'color',[c{11}(2,:)]);

xlim([0.5 3.5]);
set(gca, 'XTick', [1 2 3]);
set(gca, 'xticklabel', {'\\scriptsize  $0.01$', '\\scriptsize  $0.02$', '\\scriptsize  $0.05$'});
set(gca, 'YTick', [0.0 0.05 0.1 0.15 0.2 0.25]);
set(gca, 'yticklabel', {'\\small $0.0$', '\\small $0.05$', '\\small $0.10$', '\\small $0.15$', '\\small $0.20$', '\\small $0.25$'});
set(gca,'xticklabel',[])
set(gca, 'ylabel', '\small HOME');
box on;

s(4) = subplot(5,2,4);
hold on;
plot(xaxis, fmt_home_xy_errors(1,:), 'marker',  '.', 'color', [c{1}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_home_xy_errors(2,:), 'marker',  '.', 'color', [c{2}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_home_xy_errors(3,:), 'marker',  '.', 'color', [c{3}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_home_xy_errors(4,:), 'marker',  '.', 'color', [c{4}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_home_xy_errors(5,:), 'marker',  '.', 'color', [c{5}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_home_xy_errors(6,:), 'marker',  '.', 'color', [c{6}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_home_xy_errors(7,:), 'marker',  '.', 'color', [c{7}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_home_xy_errors(8,:), 'marker',  '.', 'color', [c{8}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_home_xy_errors(9,:), 'marker',  '.', 'color', [c{9}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_home_xy_errors(10,:), 'marker', '.', 'color',[c{10}(2,:)]);
plot(xaxis, fmt_home_xy_errors(11,:), 'marker', '.', 'color',[c{11}(2,:)]);

xlim([0.5 3.5]);
set(gca, 'XTick', [1 2 3]);
set(gca, 'xticklabel', {'\\scriptsize  $0.01$', '\\scriptsize  $0.02$', '\\scriptsize  $0.05$'});
set(gca, 'YTick', [0.0 0.05 0.1 0.15 0.2 0.25]);
set(gca, 'yticklabel', {'\\small $0.0$', '\\small $0.05$', '\\small $0.10$', '\\small $0.15$', '\\small $0.20$', '\\small $0.25$'});
set(gca,'xticklabel',[])
box on;





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s(5) = subplot(5,2,5);
hold on;
plot(xaxis, csm_warehouse_xy_errors(1,:), 'marker', '.', 'color', [c{1}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_warehouse_xy_errors(2,:), 'marker', '.', 'color', [c{2}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_warehouse_xy_errors(3,:), 'marker', '.', 'color', [c{3}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_warehouse_xy_errors(4,:), 'marker', '.', 'color', [c{4}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_warehouse_xy_errors(5,:), 'marker', '.', 'color', [c{5}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_warehouse_xy_errors(6,:), 'marker', '.', 'color', [c{6}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_warehouse_xy_errors(7,:), 'marker', '.', 'color', [c{7}(2,:)], 'linewidth', linewidth);

xlim([0.5 4.5]);
set(gca, 'XTick', [1 2 3]);
set(gca, 'xticklabel', {'\\scriptsize  $0.01$', '\\scriptsize  $0.02$', '\\scriptsize  $0.05$'});
set(gca, 'YTick', [0.785 0.79 0.795 0.80 0.805 0.81]);
set(gca, 'yticklabel', {'\\small $0.785$', '\\small $0.790$', '\\small $0.795$', '\\small $0.800$', '\\small $0.805$', '\\small $0.810$'});
set(gca,'xticklabel',[])
set(gca, 'ylabel', '\small WAREHOUSE');
box on;

s(6) = subplot(5,2,6);
hold on;
plot(xaxis, fmt_warehouse_xy_errors(1,:), 'marker', '.', 'color', [c{1}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_warehouse_xy_errors(2,:), 'marker', '.', 'color', [c{2}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_warehouse_xy_errors(3,:), 'marker', '.', 'color', [c{3}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_warehouse_xy_errors(4,:), 'marker', '.', 'color', [c{4}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_warehouse_xy_errors(5,:), 'marker', '.', 'color', [c{5}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_warehouse_xy_errors(6,:), 'marker', '.', 'color', [c{6}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_warehouse_xy_errors(7,:), 'marker', '.', 'color', [c{7}(2,:)], 'linewidth', linewidth);

xlim([0.5 3.5]);
ylim([0.0 0.15])
set(gca, 'XTick', [1 2 3]);
set(gca, 'xticklabel', {'\\scriptsize  $0.01$', '\\scriptsize  $0.02$', '\\scriptsize  $0.05$'});
set(gca, 'YTick', [0.0 0.03 0.05 0.07 0.09 0.11 0.13 0.15]);
set(gca, 'yticklabel', {'\\small $0.0$', '\\small $0.03$', '\\small $0.05$', '\\small $0.07$', '\\small $0.09$', '\\small $0.11$', '\\small $0.13$', '\\small $0.15$'});
set(gca,'xticklabel',[])
box on;





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s(7) = subplot(5,2,7);
hold on;
plot(xaxis, csm_willowgarage_xy_errors(1,:), 'marker',  '.', 'color', [c{1}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_willowgarage_xy_errors(2,:), 'marker',  '.', 'color', [c{2}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_willowgarage_xy_errors(3,:), 'marker',  '.', 'color', [c{3}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_willowgarage_xy_errors(4,:), 'marker',  '.', 'color', [c{4}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_willowgarage_xy_errors(5,:), 'marker',  '.', 'color', [c{5}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_willowgarage_xy_errors(6,:), 'marker',  '.', 'color', [c{6}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_willowgarage_xy_errors(7,:), 'marker',  '.', 'color', [c{7}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_willowgarage_xy_errors(8,:), 'marker',  '.', 'color', [c{8}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_willowgarage_xy_errors(9,:), 'marker',  '.', 'color', [c{9}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_willowgarage_xy_errors(10,:), 'marker', '.', 'color',[c{10}(2,:)], 'linewidth', linewidth);

xlim([0.5 3.5]);
ylim([0 0.45]);
set(gca, 'XTick', [1 2 3]);
set(gca, 'xticklabel', {'\\scriptsize  $0.01$', '\\scriptsize  $0.02$', '\\scriptsize  $0.05$'});
set(gca, 'YTick', [0.0 0.1 0.2 0.3 0.4]);
set(gca, 'yticklabel', {'\\small $0.0$', '\\small $0.10$', '\\small $0.20$', '\\small $0.30$', '\\small $0.40$'});
set(gca,'xticklabel',[])
set(gca, 'ylabel', '\small WILLOWGARAGE');
box on;

s(8) = subplot(5,2,8);
hold on;
plot(xaxis, fmt_willowgarage_xy_errors(1,:), 'marker',  '.', 'color', [c{1}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_willowgarage_xy_errors(2,:), 'marker',  '.', 'color', [c{2}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_willowgarage_xy_errors(3,:), 'marker',  '.', 'color', [c{3}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_willowgarage_xy_errors(4,:), 'marker',  '.', 'color', [c{4}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_willowgarage_xy_errors(5,:), 'marker',  '.', 'color', [c{5}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_willowgarage_xy_errors(6,:), 'marker',  '.', 'color', [c{6}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_willowgarage_xy_errors(7,:), 'marker',  '.', 'color', [c{7}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_willowgarage_xy_errors(8,:), 'marker',  '.', 'color', [c{8}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_willowgarage_xy_errors(9,:), 'marker',  '.', 'color', [c{9}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_willowgarage_xy_errors(10,:), 'marker', '.', 'color',[c{10}(2,:)], 'linewidth', linewidth);

xlim([0.5 3.5]);
ylim([0 0.45]);
set(gca, 'XTick', [1 2 3]);
set(gca, 'xticklabel', {'\\scriptsize  $0.01$', '\\scriptsize  $0.02$', '\\scriptsize  $0.05$'});
set(gca, 'YTick', [0.0 0.1 0.2 0.3 0.4]);
set(gca, 'yticklabel', {'\\small $0.0$', '\\small $0.10$', '\\small $0.20$', '\\small $0.30$', '\\small $0.40$'});
set(gca,'xticklabel',[])
box on;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s(9) = subplot(5,2,9);
hold on;
plot(xaxis, csm_landfill_xy_errors(1,:), 'marker', '.', 'color', [c{1}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_landfill_xy_errors(2,:), 'marker', '.', 'color', [c{2}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_landfill_xy_errors(3,:), 'marker', '.', 'color', [c{3}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_landfill_xy_errors(4,:), 'marker', '.', 'color', [c{4}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_landfill_xy_errors(5,:), 'marker', '.', 'color', [c{5}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_landfill_xy_errors(6,:), 'marker', '.', 'color', [c{6}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_landfill_xy_errors(7,:), 'marker', '.', 'color', [c{7}(2,:)], 'linewidth', linewidth);

xlim([0.5 3.5]);
ylim([0.25 0.45]);
box on
set(gca, 'XTick', [1 2 3]);
set(gca, 'xticklabel', {'\\scriptsize  $0.01$', '\\scriptsize  $0.02$', '\\scriptsize  $0.05$'});
set(gca, 'YTick', [0.25 0.30 0.35 0.40 0.45]);
set(gca, 'yticklabel', {'\\small $0.25$', '\\small $0.30$', '\\small $0.35$', '\\small $0.40$', '\\small $0.45$'});
set(gca, 'ylabel', '\small LANDFILL');

s(10) = subplot(5,2,10);
hold on;
plot(xaxis, fmt_landfill_xy_errors(1,:), 'marker', '.', 'color', [c{1}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_landfill_xy_errors(2,:), 'marker', '.', 'color', [c{2}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_landfill_xy_errors(3,:), 'marker', '.', 'color', [c{3}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_landfill_xy_errors(4,:), 'marker', '.', 'color', [c{4}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_landfill_xy_errors(5,:), 'marker', '.', 'color', [c{5}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_landfill_xy_errors(6,:), 'marker', '.', 'color', [c{6}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_landfill_xy_errors(7,:), 'marker', '.', 'color', [c{7}(2,:)], 'linewidth', linewidth);

xlim([0.5 3.5]);
ylim([0.25 0.45]);
box on
set(gca, 'XTick', [1 2 3]);
set(gca, 'xticklabel', {'\\scriptsize  $0.01$', '\\scriptsize  $0.02$', '\\scriptsize  $0.05$'});
set(gca, 'YTick', [0.25 0.30 0.35 0.40 0.45]);
set(gca, 'yticklabel', {'\\small $0.25$', '\\small $0.30$', '\\small $0.35$', '\\small $0.40$', '\\small $0.45$'});
set(gca, 'xlabel', '\small $d$ [m]: Θόρυβος μέτρησης $\mathcal{N}(0.0,d)$');



ps = [];
for i=1:size(s,2)
  ps = [ps; get(s(i), 'position')];
end

current_vspace = ps(1,2) - ps(10,2);
z = current_vspace/40;

set(s(1), 'position',  [ps(1,:)]  + [0 0 0 0])
set(s(2), 'position',  [ps(2,:)]  + [0 0 0 0])
set(s(3), 'position',  [ps(3,:)]  + [0 z 0 0])
set(s(4), 'position',  [ps(4,:)]  + [0 z 0 0])
set(s(5), 'position',  [ps(5,:)]  + [0 2*z 0 0])
set(s(6), 'position',  [ps(6,:)]  + [0 2*z 0 0])
set(s(7), 'position',  [ps(7,:)]  + [0 3*z 0 0])
set(s(8), 'position',  [ps(8,:)]  + [0 3*z 0 0])
set(s(9), 'position',  [ps(9,:)]  + [0 4*z 0 0])
set(s(10), 'position', [ps(10,:)] + [0 4*z 0 0])



if (store_errors == 1)
  img_file = strcat(pwd, '/figures/simulations_location_errors.eps');
  drawnow ("epslatex", img_file, false);
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ORIENTATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cd(here);
xaxis = [1 2 3];
c = colours2();
linewidth = 3;
s = [];

h = figure(2);
set(h,'position',[1 1 240 600]);
title('Mean inlier orientation error [rad]');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s(1) = subplot(5,2,1);
hold on;
plot(xaxis, csm_corridor_t_errors(1,:), 'marker', '.', 'color', [c{1}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_corridor_t_errors(2,:), 'marker', '.', 'color', [c{2}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_corridor_t_errors(3,:), 'marker', '.', 'color', [c{3}(2,:)], 'linewidth', linewidth);

xlim([0.5 3.5]);
ylim([0.0 0.012]);
set(gca, 'XTick', [1 2 3]);
set(gca, 'xticklabel', {'\\scriptsize  $0.01$', '\\scriptsize  $0.02$', '\\scriptsize  $0.05$'});
set(gca, 'YTick', [0.0 0.002 0.004 0.006 0.008 0.010 0.012]);
set(gca, 'yticklabel', {'\\small $0.0$', '\\small $0.002$','\\small $0.004$','\\small $0.006$','\\small $0.008$','\\small $0.010$','\\small $0.012$'});
set(gca, 'ylabel', '\small CORRIDOR');
title('PLICP');
set(gca,'xticklabel',[])
box on;

s(2) = subplot(5,2,2);
hold on;
plot(xaxis, fmt_corridor_t_errors(1,:), 'marker', '.', 'color', [c{1}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_corridor_t_errors(2,:), 'marker', '.', 'color', [c{2}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_corridor_t_errors(3,:), 'marker', '.', 'color', [c{3}(2,:)], 'linewidth', linewidth);

xlim([0.5 3.5]);
ylim([0.0 0.012]);
set(gca, 'XTick', [1 2 3]);
set(gca, 'xticklabel', {'\\scriptsize  $0.01$', '\\scriptsize  $0.02$', '\\scriptsize  $0.05$'});
set(gca, 'YTick', [0.0 0.002 0.004 0.006 0.008 0.010 0.012]);
set(gca, 'yticklabel', {'\\small $0.0$', '\\small $0.002$','\\small $0.004$','\\small $0.006$','\\small $0.008$','\\small $0.010$','\\small $0.012$'});
title('PGL-FMIC');
set(gca,'xticklabel',[])
box on;




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s(3) = subplot(5,2,3);
hold on;
plot(xaxis, csm_home_t_errors(1,:), 'marker',  '.', 'color', [c{1}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_home_t_errors(2,:), 'marker',  '.', 'color', [c{2}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_home_t_errors(3,:), 'marker',  '.', 'color', [c{3}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_home_t_errors(4,:), 'marker',  '.', 'color', [c{4}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_home_t_errors(5,:), 'marker',  '.', 'color', [c{5}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_home_t_errors(6,:), 'marker',  '.', 'color', [c{6}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_home_t_errors(7,:), 'marker',  '.', 'color', [c{7}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_home_t_errors(8,:), 'marker',  '.', 'color', [c{8}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_home_t_errors(9,:), 'marker',  '.', 'color', [c{9}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_home_t_errors(10,:), 'marker', '.', 'color',[c{10}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_home_t_errors(11,:), 'marker', '.', 'color',[c{11}(2,:)], 'linewidth', linewidth);

xlim([0.5 3.5]);
ylim([0 0.015])
set(gca, 'XTick', [1 2 3]);
set(gca, 'xticklabel', {'\\scriptsize  $0.01$', '\\scriptsize  $0.02$', '\\scriptsize  $0.05$'});
set(gca, 'YTick', [0.0 0.005 0.01 0.015]);
set(gca, 'yticklabel', {'\\small $0.0$', '\\small $0.005$', '\\small $0.01$', '\\small $0.015$'});
set(gca, 'xticklabel',[])
set(gca, 'ylabel', '\small HOME');
box on;

s(4) = subplot(5,2,4);
hold on;
plot(xaxis, fmt_home_t_errors(1,:), 'marker',  '.', 'color', [c{1}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_home_t_errors(2,:), 'marker',  '.', 'color', [c{2}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_home_t_errors(3,:), 'marker',  '.', 'color', [c{3}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_home_t_errors(4,:), 'marker',  '.', 'color', [c{4}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_home_t_errors(5,:), 'marker',  '.', 'color', [c{5}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_home_t_errors(6,:), 'marker',  '.', 'color', [c{6}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_home_t_errors(7,:), 'marker',  '.', 'color', [c{7}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_home_t_errors(8,:), 'marker',  '.', 'color', [c{8}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_home_t_errors(9,:), 'marker',  '.', 'color', [c{9}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_home_t_errors(10,:), 'marker', '.', 'color',[c{10}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_home_t_errors(11,:), 'marker', '.', 'color',[c{11}(2,:)], 'linewidth', linewidth);

xlim([0.5 3.5]);
ylim([0 0.015])
set(gca, 'XTick', [1 2 3]);
set(gca, 'xticklabel', {'\\scriptsize  $0.01$', '\\scriptsize  $0.02$', '\\scriptsize  $0.05$'});
set(gca, 'YTick', [0.0 0.005 0.01 0.015]);
set(gca, 'yticklabel', {'\\small $0.0$', '\\small $0.005$', '\\small $0.01$', '\\small $0.015$'});
set(gca, 'xticklabel',[])
box on;





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s(5) = subplot(5,2,5);
hold on;
plot(xaxis, csm_warehouse_t_errors(1,:), 'marker', '.', 'color', [c{1}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_warehouse_t_errors(2,:), 'marker', '.', 'color', [c{2}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_warehouse_t_errors(3,:), 'marker', '.', 'color', [c{3}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_warehouse_t_errors(4,:), 'marker', '.', 'color', [c{4}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_warehouse_t_errors(5,:), 'marker', '.', 'color', [c{5}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_warehouse_t_errors(6,:), 'marker', '.', 'color', [c{6}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_warehouse_t_errors(7,:), 'marker', '.', 'color', [c{7}(2,:)], 'linewidth', linewidth);

xlim([0.5 3.5]);
set(gca, 'XTick', [1 2 3]);
set(gca, 'xticklabel', {'\\scriptsize  $0.01$', '\\scriptsize  $0.02$', '\\scriptsize  $0.05$'});
set(gca, 'YTick', [3.04 3.06 3.08 3.10 3.12 3.14 3.16]);
set(gca, 'yticklabel', {'\\small $3.04$', '\\small $3.06$', '\\small $3.08$', '\\small $3.10$', '\\small $3.12$', '\\small $3.14$', '\\small $3.16$'});
set(gca,'xticklabel',[])
set(gca, 'ylabel', '\small WAREHOUSE');
box on;

s(6) = subplot(5,2,6);
hold on;
plot(xaxis, fmt_warehouse_t_errors(1,:), 'marker', '.', 'color', [c{1}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_warehouse_t_errors(2,:), 'marker', '.', 'color', [c{2}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_warehouse_t_errors(3,:), 'marker', '.', 'color', [c{3}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_warehouse_t_errors(4,:), 'marker', '.', 'color', [c{4}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_warehouse_t_errors(5,:), 'marker', '.', 'color', [c{5}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_warehouse_t_errors(6,:), 'marker', '.', 'color', [c{6}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_warehouse_t_errors(7,:), 'marker', '.', 'color', [c{7}(2,:)], 'linewidth', linewidth);

xlim([0.5 3.5]);
ylim([0 0.02])
set(gca, 'XTick', [1 2 3]);
set(gca, 'xticklabel', { '\\scriptsize  $0.01$', '\\scriptsize  $0.02$', '\\scriptsize  $0.05$'});
set(gca, 'YTick', [0.0 0.005 0.01 0.015 0.02]);
set(gca, 'yticklabel', {'\\small $0.0$', '\\small $0.005$', '\\small $0.010$', '\\small $0.015$', '\\small $0.020$'});
set(gca,'xticklabel',[])
box on;





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s(7) = subplot(5,2,7);
hold on;
plot(xaxis, csm_willowgarage_t_errors(1,:), 'marker',  '.', 'color', [c{1}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_willowgarage_t_errors(2,:), 'marker',  '.', 'color', [c{2}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_willowgarage_t_errors(3,:), 'marker',  '.', 'color', [c{3}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_willowgarage_t_errors(4,:), 'marker',  '.', 'color', [c{4}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_willowgarage_t_errors(5,:), 'marker',  '.', 'color', [c{5}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_willowgarage_t_errors(6,:), 'marker',  '.', 'color', [c{6}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_willowgarage_t_errors(7,:), 'marker',  '.', 'color', [c{7}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_willowgarage_t_errors(8,:), 'marker',  '.', 'color', [c{8}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_willowgarage_t_errors(9,:), 'marker',  '.', 'color', [c{9}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_willowgarage_t_errors(10,:), 'marker', '.', 'color',[c{10}(2,:)], 'linewidth', linewidth);

xlim([0.5 3.5]);
ylim([0 1.2])
set(gca, 'XTick', [1 2 3]);
set(gca, 'xticklabel', {'\\scriptsize  $0.01$', '\\scriptsize  $0.02$', '\\scriptsize  $0.05$'});
set(gca, 'YTick', [0.0 0.5 1.0 1.2]);
set(gca, 'yticklabel', {'\\small $0.0$', '\\small $0.50$', '\\small $1.0$', '\\small $1.2$'});
set(gca, 'ylabel', '\small WILLOWGARAGE');
set(gca,'xticklabel',[])
box on;

s(8) = subplot(5,2,8);
hold on;
plot(xaxis, fmt_willowgarage_t_errors(1,:), 'marker',  '.', 'color', [c{1}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_willowgarage_t_errors(2,:), 'marker',  '.', 'color', [c{2}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_willowgarage_t_errors(3,:), 'marker',  '.', 'color', [c{3}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_willowgarage_t_errors(4,:), 'marker',  '.', 'color', [c{4}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_willowgarage_t_errors(5,:), 'marker',  '.', 'color', [c{5}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_willowgarage_t_errors(6,:), 'marker',  '.', 'color', [c{6}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_willowgarage_t_errors(7,:), 'marker',  '.', 'color', [c{7}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_willowgarage_t_errors(8,:), 'marker',  '.', 'color', [c{8}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_willowgarage_t_errors(9,:), 'marker',  '.', 'color', [c{9}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_willowgarage_t_errors(10,:), 'marker', '.', 'color',[c{10}(2,:)], 'linewidth', linewidth);

xlim([0.5 3.5]);
ylim([0 0.15])
set(gca, 'XTick', [1 2 3]);
set(gca, 'xticklabel', {'\\scriptsize  $0.01$', '\\scriptsize  $0.02$', '\\scriptsize  $0.05$'});
set(gca, 'YTick', [0.0 0.02 0.05 0.10 0.15]);
set(gca, 'yticklabel', {'\\small $0.0$', '\\small $0.02$', '\\small $0.05$', '\\small $0.10$', '\\small $0.15$'});
set(gca,'xticklabel',[])
box on;




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s(9) = subplot(5,2,9);
hold on;
plot(xaxis, csm_landfill_t_errors(1,:), 'marker', '.', 'color', [c{1}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_landfill_t_errors(2,:), 'marker', '.', 'color', [c{2}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_landfill_t_errors(3,:), 'marker', '.', 'color', [c{3}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_landfill_t_errors(4,:), 'marker', '.', 'color', [c{4}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_landfill_t_errors(5,:), 'marker', '.', 'color', [c{5}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_landfill_t_errors(6,:), 'marker', '.', 'color', [c{6}(2,:)], 'linewidth', linewidth);
plot(xaxis, csm_landfill_t_errors(7,:), 'marker', '.', 'color', [c{7}(2,:)], 'linewidth', linewidth);

xlim([0.5 3.5]);
ylim([0.0 0.025])
set(gca, 'XTick', [1 2 3]);
set(gca, 'xticklabel', {'\\scriptsize  $0.01$', '\\scriptsize  $0.02$', '\\scriptsize  $0.05$'});
set(gca, 'YTick', [0.0 0.005 0.01 0.015 0.02 0.025]);
set(gca, 'yticklabel', {'\\small $0.0$', '\\small $0.005$', '\\small $0.010$', '\\small $0.015$', '\\small $0.020$', '\\small $0.025$'});
set(gca, 'ylabel', '\small LANDFILL');
box on

s(10) = subplot(5,2,10);
hold on;
plot(xaxis, fmt_landfill_t_errors(1,:), 'marker', '.', 'color', [c{1}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_landfill_t_errors(2,:), 'marker', '.', 'color', [c{2}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_landfill_t_errors(3,:), 'marker', '.', 'color', [c{3}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_landfill_t_errors(4,:), 'marker', '.', 'color', [c{4}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_landfill_t_errors(5,:), 'marker', '.', 'color', [c{5}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_landfill_t_errors(6,:), 'marker', '.', 'color', [c{6}(2,:)], 'linewidth', linewidth);
plot(xaxis, fmt_landfill_t_errors(7,:), 'marker', '.', 'color', [c{7}(2,:)], 'linewidth', linewidth);

xlim([0.5 3.5]);
ylim([0.0 0.025])
set(gca, 'XTick', [1 2 3]);
set(gca, 'xticklabel', {'\\scriptsize  $0.01$', '\\scriptsize  $0.02$', '\\scriptsize  $0.05$'});
set(gca, 'YTick', [0.0 0.005 0.01 0.015 0.02 0.025]);
set(gca, 'yticklabel', {'\\small $0.0$', '\\small $0.005$', '\\small $0.010$', '\\small $0.015$', '\\small $0.020$', '\\small $0.025$'});
set(gca, 'xlabel', '\small $d$ [m]: Θόρυβος μέτρησης $\mathcal{N}(0.0,d)$');
box on



ps = [];
for i=1:size(s,2)
  ps = [ps; get(s(i), 'position')];
end

current_vspace = ps(1,2) - ps(10,2);
z = current_vspace/40;

set(s(1), 'position',  [ps(1,:)]  + [0 0 0 0])
set(s(2), 'position',  [ps(2,:)]  + [0 0 0 0])
set(s(3), 'position',  [ps(3,:)]  + [0 z 0 0])
set(s(4), 'position',  [ps(4,:)]  + [0 z 0 0])
set(s(5), 'position',  [ps(5,:)]  + [0 2*z 0 0])
set(s(6), 'position',  [ps(6,:)]  + [0 2*z 0 0])
set(s(7), 'position',  [ps(7,:)]  + [0 3*z 0 0])
set(s(8), 'position',  [ps(8,:)]  + [0 3*z 0 0])
set(s(9), 'position',  [ps(9,:)]  + [0 4*z 0 0])
set(s(10), 'position', [ps(10,:)] + [0 4*z 0 0])



if (store_errors == 1)
  img_file = strcat(pwd, '/figures/simulations_orientation_errors.eps');
  drawnow ("epslatex", img_file, false);
end
