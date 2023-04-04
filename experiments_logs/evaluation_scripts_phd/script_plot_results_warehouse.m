clear all
close all

store_outliers = 1;

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

    fmt_warehouse_outliers_row = [fmt_warehouse_outliers_row, fmt_o];
    csm_warehouse_outliers_row = [csm_warehouse_outliers_row, csm_o];

  end
  fmt_warehouse_outliers = [fmt_warehouse_outliers; fmt_warehouse_outliers_row];
  csm_warehouse_outliers = [csm_warehouse_outliers; csm_warehouse_outliers_row];

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h = figure(3);
set(h,'position',[1 1 250 150]);
hold on;
subplot(2,1,1);
h1 = bar(fmt_warehouse_outliers);
set (h1(1), "facecolor", [252,141,89]/255);
set (h1(2), "facecolor", [255,255,191]/255);
set (h1(3), "facecolor", [145,191,219]/255);

set(gca, 'XTick', [1 2 3 4 5 6 7]);
%set(gca, 'xticklabel', {'$\\bm{p}_a^W$', '$\\bm{p}_b^W$', '$\\bm{p}_c^W$', '$\\bm{p}_d^W$', '$\\bm{p}_e^W$', '$\\bm{p}_f^W$', '$\\bm{p}_g^W$'});
set(gca, 'xticklabel', []);
set(gca, 'YTick', [0 25 50 75 100])
set(gca, 'yticklabel', {'$0\\%$', '$25\\%$','$50\\%$','$75\\%$', '$100\\%$'});
set(gca, 'ylabel', 'PGL-FMIC');
title('Percentage of outliers per noise level');
grid

subplot(2,1,2);
h2 = bar(csm_warehouse_outliers);
set (h2(1), "facecolor", [166,206,227]/255);
set (h2(2), "facecolor", [31,120,180]/255);
set (h2(3), "facecolor", [178,223,138]/255);

set(gca, 'XTick', [1 2 3 4 5 6 7]);
set(gca, 'XTick', [1 2 3 4 5 6 7]);
set(gca, 'xticklabel', {'$\\bm{p}_a^W$', '$\\bm{p}_b^W$', '$\\bm{p}_c^W$', '$\\bm{p}_d^W$', '$\\bm{p}_e^W$', '$\\bm{p}_f^W$', '$\\bm{p}_g^W$'});
set(gca, 'YTick', [0 25 50 75 100])
set(gca, 'yticklabel', {'$0\\%$', '$25\\%$','$50\\%$','$75\\%$', '$100\\%$'});
set(gca, 'ylabel', 'PL-ICP');
set(gca, 'xlabel', 'Identifier of tested pose');
grid

if (store_outliers == 1)
  img_file = strcat('/media/ext/backup_files/AUTh/RELIEF/relief-fmt-global-localisation-paper/figures/results/simulation/warehouse/outliers.eps');
  drawnow ("epslatex", img_file, false);
end
