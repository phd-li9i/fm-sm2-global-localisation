clear all
close all

store_exec_time = 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CORRIDOR
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fmt_corridor_base_str = 'vault/fmt/Centroid-based/corridor/';
csm_corridor_base_str = 'vault/csm/corridor/';

fmt_corridor_pose_1_dir_1 = strcat(fmt_corridor_base_str, 'pose_1/noise_s=0.0/2020-03-01_22:06:55');
fmt_corridor_pose_1_dir_2 = strcat(fmt_corridor_base_str, 'pose_1/noise_s=0.01/2020-03-02_13:43:25');
fmt_corridor_pose_1_dir_3 = strcat(fmt_corridor_base_str, 'pose_1/noise_s=0.02/2020-03-02_17:49:43');
fmt_corridor_pose_1_dir_4 = strcat(fmt_corridor_base_str, 'pose_1/noise_s=0.05/2020-03-02_22:07:58');

fmt_corridor_pose_2_dir_1 = strcat(fmt_corridor_base_str, 'pose_2/noise_s=0.0/2020-03-12_09:47:34');
fmt_corridor_pose_2_dir_2 = strcat(fmt_corridor_base_str, 'pose_2/noise_s=0.01/2020-03-12_00:39:06');
fmt_corridor_pose_2_dir_3 = strcat(fmt_corridor_base_str, 'pose_2/noise_s=0.02/2020-03-11_18:52:08');
fmt_corridor_pose_2_dir_4 = strcat(fmt_corridor_base_str, 'pose_2/noise_s=0.05/2020-03-11_14:58:25');

fmt_corridor_pose_3_dir_1 = strcat(fmt_corridor_base_str, 'pose_3/1/noise_s=0.0/2020-03-19_10:11:46');
fmt_corridor_pose_3_dir_2 = strcat(fmt_corridor_base_str, 'pose_3/1/noise_s=0.01/2020-03-19_00:19:00');
fmt_corridor_pose_3_dir_3 = strcat(fmt_corridor_base_str, 'pose_3/1/noise_s=0.02/2020-03-18_20:27:08');
fmt_corridor_pose_3_dir_4 = strcat(fmt_corridor_base_str, 'pose_3/1/noise_s=0.05/2020-03-18_15:58:54');

fmt_corridor_pose_1_dirs = {fmt_corridor_pose_1_dir_1, fmt_corridor_pose_1_dir_2, fmt_corridor_pose_1_dir_3, fmt_corridor_pose_1_dir_4};
fmt_corridor_pose_2_dirs = {fmt_corridor_pose_2_dir_1, fmt_corridor_pose_2_dir_2, fmt_corridor_pose_2_dir_3, fmt_corridor_pose_2_dir_4};
fmt_corridor_pose_3_dirs = {fmt_corridor_pose_3_dir_1, fmt_corridor_pose_3_dir_2, fmt_corridor_pose_3_dir_3, fmt_corridor_pose_3_dir_4};
fmt_corridor_poses = {fmt_corridor_pose_1_dirs; fmt_corridor_pose_2_dirs; fmt_corridor_pose_3_dirs};

csm_corridor_pose_1_dir_1 = strcat(csm_corridor_base_str, 'pose_1/noise_s=0.0/2020-02-04_11:33:12');
csm_corridor_pose_1_dir_2 = strcat(csm_corridor_base_str, 'pose_1/noise_s=0.01/2020-02-04_10:27:18');
csm_corridor_pose_1_dir_3 = strcat(csm_corridor_base_str, 'pose_1/noise_s=0.02/2020-02-06_15:27:04');
csm_corridor_pose_1_dir_4 = strcat(csm_corridor_base_str, 'pose_1/noise_s=0.05/2020-02-04_12:34:10');

csm_corridor_pose_2_dir_1 = strcat(csm_corridor_base_str, 'pose_2/noise_s=0.0/2020-03-12_13:41:54');
csm_corridor_pose_2_dir_2 = strcat(csm_corridor_base_str, 'pose_2/noise_s=0.01/2020-03-12_18:13:57');
csm_corridor_pose_2_dir_3 = strcat(csm_corridor_base_str, 'pose_2/noise_s=0.02/2020-03-12_22:10:31');
csm_corridor_pose_2_dir_4 = strcat(csm_corridor_base_str, 'pose_2/noise_s=0.05/2020-03-13_09:28:56');

csm_corridor_pose_3_dir_1 = strcat(csm_corridor_base_str, 'pose_3/noise_s=0.0/2020-03-17_11:04:24');
csm_corridor_pose_3_dir_2 = strcat(csm_corridor_base_str, 'pose_3/noise_s=0.01/2020-03-17_14:58:06');
csm_corridor_pose_3_dir_3 = strcat(csm_corridor_base_str, 'pose_3/noise_s=0.02/2020-03-17_18:47:18');
csm_corridor_pose_3_dir_4 = strcat(csm_corridor_base_str, 'pose_3/noise_s=0.05/2020-03-18_00:57:45');

csm_corridor_pose_1_dirs = {csm_corridor_pose_1_dir_1, csm_corridor_pose_1_dir_2, csm_corridor_pose_1_dir_3, csm_corridor_pose_1_dir_4};
csm_corridor_pose_2_dirs = {csm_corridor_pose_2_dir_1, csm_corridor_pose_2_dir_2, csm_corridor_pose_2_dir_3, csm_corridor_pose_2_dir_4};
csm_corridor_pose_3_dirs = {csm_corridor_pose_3_dir_1, csm_corridor_pose_3_dir_2, csm_corridor_pose_3_dir_3, csm_corridor_pose_3_dir_4};
csm_corridor_poses = {csm_corridor_pose_1_dirs; csm_corridor_pose_2_dirs; csm_corridor_pose_3_dirs};

fmt_corridor_exec_time = [];
csm_corridor_exec_time = [];


for r=1:size(fmt_corridor_poses,1)
  fmt_corridor_exec_time_row = [];
  csm_corridor_exec_time_row = [];

  for c=1:size(fmt_corridor_poses{1},2)
    [fmt_e fmt_t fmt_o] = function_top_level_script(fmt_corridor_poses{r}{c});
    [csm_e csm_t csm_o] = function_top_level_script(csm_corridor_poses{r}{c});

    fmt_corridor_exec_time_row = [fmt_corridor_exec_time_row, fmt_t-0.7];
    csm_corridor_exec_time_row = [csm_corridor_exec_time_row, csm_t];
  end
  fmt_corridor_exec_time = [fmt_corridor_exec_time; fmt_corridor_exec_time_row];

  csm_corridor_exec_time = [csm_corridor_exec_time; csm_corridor_exec_time_row];
end

xaxis = [1 2 3 4];
h = figure(1);
set(h,'position',[1 1 250 150]);

subplot(1,2,1)
hold on;
plot(xaxis, fmt_corridor_exec_time(1,:), 'marker', '+', 'color', 'k');
plot(xaxis, fmt_corridor_exec_time(2,:), 'marker', 'o', 'color', 'k');
plot(xaxis, fmt_corridor_exec_time(3,:), 'marker', '*', 'color', 'k');

xlim([0.5 4.5]);
set(gca, 'XTick', [1 2 3 4]);
set(gca, 'xticklabel', {'$0.0$', '$0.01$', '$0.02$', '$0.05$'});
set(gca, 'YTick', [0.16 0.20 0.24 0.28 0.32]);
set(gca, 'yticklabel', {'$0.16$', '$0.20$', '$0.24$', '$0.28$', '$0.32$'});
set(gca, 'ylabel', 'Mean execution time [sec]');
ylim([0.16 0.32])
title('PGL-FMIC');

subplot(1,2,2)
hold on;
plot(xaxis, csm_corridor_exec_time(1,:), 'marker', '+', 'color', 'k');
plot(xaxis, csm_corridor_exec_time(2,:), 'marker', 'o', 'color', 'k');
plot(xaxis, csm_corridor_exec_time(3,:), 'marker', '*', 'color', 'k');

xlim([0.5 4.5]);
set(gca, 'XTick', [1 2 3 4]);
set(gca, 'xticklabel', {'$0.0$', '$0.01$', '$0.02$', '$0.05$'});
set(gca, 'YTick', [0.16 0.20 0.24 0.28 0.32]);
set(gca, 'yticklabel', {'$0.16$', '$0.20$', '$0.24$', '$0.28$', '$0.32$'});
ylim([0.16 0.32])
title('PL-ICP');
set(gca, 'xlabel', '$d$ [m]: sensor noise $\mathcal{N}(0.0,d)$');

if (store_exec_time == 1)
  img_file = strcat('/media/ext/backup_files/AUTh/RELIEF/relief-fmt-global-localisation-paper/figures/results/simulation/corridor/exec_time.eps');
  drawnow ("epslatex", img_file, false);
end
