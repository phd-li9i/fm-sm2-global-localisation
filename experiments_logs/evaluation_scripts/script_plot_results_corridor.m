clear all
close all

store_outliers = 1;

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

    fmt_corridor_outliers_row = [fmt_corridor_outliers_row, fmt_o];
    csm_corridor_outliers_row = [csm_corridor_outliers_row, csm_o];

  end
  fmt_corridor_outliers = [fmt_corridor_outliers; fmt_corridor_outliers_row];
  csm_corridor_outliers = [csm_corridor_outliers; csm_corridor_outliers_row];

end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h = figure(3);
set(h,'position',[1 1 250 150]);
hold on;
subplot(2,1,1);
h1 = bar(fmt_corridor_outliers);
set (h1(1), "facecolor", [252,141,89]/255);
set (h1(2), "facecolor", [255,255,191]/255);
set (h1(3), "facecolor", [145,191,219]/255);

ylim([0 100])
set(gca, 'XTick', [1 2 3]);
%set(gca, 'YTick', [0 1 10])
%set(gca, 'xticklabel', {'$\\bm{p}_a^C$', '$\\bm{p}_b^C$', '$\\bm{p}_c^C$'});
set(gca, 'xticklabel', []);
%set(gca, 'yticklabel', {'$0$', '$1$', '$10$'});
set(gca, 'YTick', [0 25 50 75 100])
set(gca, 'yticklabel', {'$0\\%$', '$25\\%$','$50\\%$','$75\\%$', '$100\\%$'});
set(gca, 'xticklabel', {'$\\bm{p}_a^C$', '$\\bm{p}_b^C$', '$\\bm{p}_c^C$'});
set(gca, 'ylabel', 'PGL-FMIC');
title('Percentage of outliers per noise level')
grid

subplot(2,1,2);
h2 = bar(csm_corridor_outliers);
set (h2(1), "facecolor", [166,206,227]/255);
set (h2(2), "facecolor", [31,120,180]/255);
set (h2(3), "facecolor", [178,223,138]/255);

ylim([0 100])
set(gca, 'XTick', [1 2 3]);
%set(gca, 'YTick', [0 34 41 59 94 100])
%set(gca, 'yticklabel', {'$0$', '$34$', '$41$', '$59$', '$94$', '$100$'});
set(gca, 'YTick', [0 25 50 75 100])
set(gca, 'yticklabel', {'$0\\%$', '$25\\%$','$50\\%$','$75\\%$', '$100\\%$'});
set(gca, 'xticklabel', {'$\\bm{p}_a^C$', '$\\bm{p}_b^C$', '$\\bm{p}_c^C$'});
set(gca, 'ylabel', 'PL-ICP');
set(gca, 'xlabel', 'Identifier of tested pose');
grid

if (store_outliers == 1)
  img_file = strcat('/media/ext/backup_files/AUTh/RELIEF/relief-fmt-global-localisation-paper/figures/results/simulation/corridor/outliers.eps');
  drawnow ("epslatex", img_file, false);
end
