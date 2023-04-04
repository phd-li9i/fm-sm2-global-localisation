clear all
close all

store_outliers = 1;

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
h = figure(3);
set(h,'position',[1 1 250 150]);
hold on;
subplot(2,1,1);
h1 = bar(fmt_willowgarage_outliers);
set (h1(1), "facecolor", [252,141,89]/255);
set (h1(2), "facecolor", [255,255,191]/255);
set (h1(3), "facecolor", [145,191,219]/255);

set(gca, 'XTick', [1 2 3 4 5 6 7 8 9 10]);
%set(gca, 'xticklabel', {'$\\bm{p}_a^G$', '$\\bm{p}_b^G$', '$\\bm{p}_c^G$', '$\\bm{p}_d^G$', '$\\bm{p}_e^G$', '$\\bm{p}_f^G$', '$\\bm{p}_g^G$', '$\\bm{p}_h^G$', '$\\bm{p}_i^G$', '$\\bm{p}_j^G$'});
set(gca, 'xticklabel', []);
set(gca, 'YTick', [0 25 50 75 100])
set(gca, 'yticklabel', {'$0\\%$', '$25\\%$','$50\\%$','$75\\%$', '$100\\%$'});

set(gca, 'ylabel', 'PGL-FMIC');
title('Percentage of outliers per noise level');
xlim([0, 11])
ylim([0, 100])
grid

subplot(2,1,2);
h2 = bar(csm_willowgarage_outliers);
set (h2(1), "facecolor", [166,206,227]/255);
set (h2(2), "facecolor", [31,120,180]/255);
set (h2(3), "facecolor", [178,223,138]/255);

set(gca, 'XTick', [1 2 3 4 5 6 7 8 9 10]);
set(gca, 'xticklabel', {'$\\bm{p}_a^G$', '$\\bm{p}_b^G$', '$\\bm{p}_c^G$', '$\\bm{p}_d^G$', '$\\bm{p}_e^G$', '$\\bm{p}_f^G$', '$\\bm{p}_g^G$', '$\\bm{p}_h^G$', '$\\bm{p}_i^G$', '$\\bm{p}_j^G$'});
set(gca, 'YTick', [0 25 50 75 100])
set(gca, 'yticklabel', {'$0\\%$', '$25\\%$','$50\\%$','$75\\%$', '$100\\%$'});

set(gca, 'ylabel', 'PL-ICP');
set(gca, 'xlabel', 'Identifier of tested pose');
xlim([0, 11])
ylim([0, 100])
grid

if (store_outliers == 1)
  img_file = strcat('/media/ext/backup_files/AUTh/RELIEF/relief-fmt-global-localisation-paper/figures/results/simulation/willowgarage/outliers.eps');
  drawnow ("epslatex", img_file, false);
end
