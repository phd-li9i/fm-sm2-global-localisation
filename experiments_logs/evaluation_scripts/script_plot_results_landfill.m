clear all
close all

store_outliers = 1;

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

    fmt_landfill_outliers_row = [fmt_landfill_outliers_row, fmt_o];
    csm_landfill_outliers_row = [csm_landfill_outliers_row, csm_o];

  end
  fmt_landfill_outliers = [fmt_landfill_outliers; fmt_landfill_outliers_row];
  csm_landfill_outliers = [csm_landfill_outliers; csm_landfill_outliers_row];

end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h = figure(3);
set(h,'position',[1 1 250 150]);
hold on;
subplot(2,1,1);
h1 = bar(fmt_landfill_outliers);
set (h1(1), "facecolor", [252,141,89]/255);
set (h1(2), "facecolor", [255,255,191]/255);
set (h1(3), "facecolor", [145,191,219]/255);

ylim([0 100])
set(gca, 'XTick', [1 2 3 4 5 6 7]);
set(gca, 'xticklabel', {'$\\bm{p}_a^L$', '$\\bm{p}_b^L$', '$\\bm{p}_c^L$', '$\\bm{p}_d^L$', '$\\bm{p}_e^L$', '$\\bm{p}_f^L$', '$\\bm{p}_g^L$'});
set(gca, 'xticklabel', []);
set(gca, 'YTick', [0 25 50 75 100])
set(gca, 'yticklabel', {'$0\\%$', '$25\\%$','$50\\%$','$75\\%$', '$100\\%$'});

set(gca, 'ylabel', 'PGL-FMIC');
title('Percentage of outliers per noise level');
grid

subplot(2,1,2);
h2 = bar(csm_landfill_outliers);
set (h2(1), "facecolor", [166,206,227]/255);
set (h2(2), "facecolor", [31,120,180]/255);
set (h2(3), "facecolor", [178,223,138]/255);

ylim([0 100])
set(gca, 'XTick', [1 2 3 4 5 6 7]);
set(gca, 'XTick', [1 2 3 4 5 6 7]);
set(gca, 'xticklabel', {'$\\bm{p}_a^L$', '$\\bm{p}_b^L$', '$\\bm{p}_c^L$', '$\\bm{p}_d^L$', '$\\bm{p}_e^L$', '$\\bm{p}_f^L$', '$\\bm{p}_g^L$'});
set(gca, 'YTick', [0 25 50 75 100])
set(gca, 'yticklabel', {'$0\\%$', '$25\\%$','$50\\%$','$75\\%$', '$100\\%$'});

set(gca, 'ylabel', 'PL-ICP');
set(gca, 'xlabel', 'Identifier of tested pose');
grid

if (store_outliers == 1)
  img_file = strcat('/media/ext/backup_files/AUTh/RELIEF/relief-fmt-global-localisation-paper/figures/results/simulation/landfill/outliers.eps');
  drawnow ("epslatex", img_file, false);
end
