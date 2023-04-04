clear all
close all

store_exec_time = 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% landfill
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fmt_landfill_base_str = 'vault/fmt/Centroid-based/dirtrack/';
csm_landfill_base_str = 'vault/csm/dirtrack/';

fmt_landfill_pose_1_dir_1 = strcat(fmt_landfill_base_str, 'pose_1/noise_s=0.0/2020-10-31_20:46:06');
fmt_landfill_pose_1_dir_2 = strcat(fmt_landfill_base_str, 'pose_1/noise_s=0.01/2020-11-01_02:23:58');
fmt_landfill_pose_1_dir_3 = strcat(fmt_landfill_base_str, 'pose_1/noise_s=0.02/2020-11-01_13:13:11');
fmt_landfill_pose_1_dir_4 = strcat(fmt_landfill_base_str, 'pose_1/noise_s=0.05/2020-11-01_18:32:10');

fmt_landfill_pose_2_dir_1 = strcat(fmt_landfill_base_str, 'pose_2/noise_s=0.0/2020-11-02_00:03:39');
fmt_landfill_pose_2_dir_2 = strcat(fmt_landfill_base_str, 'pose_2/noise_s=0.01/2020-11-02_10:35:55');
fmt_landfill_pose_2_dir_3 = strcat(fmt_landfill_base_str, 'pose_2/noise_s=0.02/2020-11-02_16:08:14');
fmt_landfill_pose_2_dir_4 = strcat(fmt_landfill_base_str, 'pose_2/noise_s=0.05/2020-11-02_19:59:29');

fmt_landfill_pose_3_dir_1 = strcat(fmt_landfill_base_str, 'pose_3/noise_s=0.0/2020-11-02_23:50:53');
fmt_landfill_pose_3_dir_2 = strcat(fmt_landfill_base_str, 'pose_3/noise_s=0.01/2020-11-03_10:45:46');
fmt_landfill_pose_3_dir_3 = strcat(fmt_landfill_base_str, 'pose_3/noise_s=0.02/2020-11-03_15:13:38');
fmt_landfill_pose_3_dir_4 = strcat(fmt_landfill_base_str, 'pose_3/noise_s=0.05/2020-11-03_19:11:24');

fmt_landfill_pose_4_dir_1 = strcat(fmt_landfill_base_str, 'pose_4/noise_s=0.0/2020-11-04_00:33:07');
fmt_landfill_pose_4_dir_2 = strcat(fmt_landfill_base_str, 'pose_4/noise_s=0.01/2020-11-04_10:53:59');
fmt_landfill_pose_4_dir_3 = strcat(fmt_landfill_base_str, 'pose_4/noise_s=0.02/2020-11-04_14:46:46');
fmt_landfill_pose_4_dir_4 = strcat(fmt_landfill_base_str, 'pose_4/noise_s=0.05/2020-11-04_18:48:03');

fmt_landfill_pose_5_dir_1 = strcat(fmt_landfill_base_str, 'pose_5/noise_s=0.0/2020-11-04_22:41:03');
fmt_landfill_pose_5_dir_2 = strcat(fmt_landfill_base_str, 'pose_5/noise_s=0.01/2020-11-05_02:54:21');
fmt_landfill_pose_5_dir_3 = strcat(fmt_landfill_base_str, 'pose_5/noise_s=0.02/2020-11-05_10:43:56');
fmt_landfill_pose_5_dir_4 = strcat(fmt_landfill_base_str, 'pose_5/noise_s=0.05/2020-11-05_15:17:09');

fmt_landfill_pose_6_dir_1 = strcat(fmt_landfill_base_str, 'pose_6/noise_s=0.0/2020-11-05_19:40:12');
fmt_landfill_pose_6_dir_2 = strcat(fmt_landfill_base_str, 'pose_6/noise_s=0.01/2020-11-06_01:43:11');
fmt_landfill_pose_6_dir_3 = strcat(fmt_landfill_base_str, 'pose_6/noise_s=0.02/2020-11-06_10:12:29');
fmt_landfill_pose_6_dir_4 = strcat(fmt_landfill_base_str, 'pose_6/noise_s=0.05/2020-11-06_14:04:24');

fmt_landfill_pose_7_dir_1 = strcat(fmt_landfill_base_str, 'pose_7/noise_s=0.0/2020-11-06_18:14:53');
fmt_landfill_pose_7_dir_2 = strcat(fmt_landfill_base_str, 'pose_7/noise_s=0.01/2020-11-06_22:12:47');
fmt_landfill_pose_7_dir_3 = strcat(fmt_landfill_base_str, 'pose_7/noise_s=0.02/2020-11-07_02:56:06');
fmt_landfill_pose_7_dir_4 = strcat(fmt_landfill_base_str, 'pose_7/noise_s=0.05/2020-11-07_13:27:11');

fmt_landfill_pose_1_dirs = {fmt_landfill_pose_1_dir_1, fmt_landfill_pose_1_dir_2, fmt_landfill_pose_1_dir_3, fmt_landfill_pose_1_dir_4};
fmt_landfill_pose_2_dirs = {fmt_landfill_pose_2_dir_1, fmt_landfill_pose_2_dir_2, fmt_landfill_pose_2_dir_3, fmt_landfill_pose_2_dir_4};
fmt_landfill_pose_3_dirs = {fmt_landfill_pose_3_dir_1, fmt_landfill_pose_3_dir_2, fmt_landfill_pose_3_dir_3, fmt_landfill_pose_3_dir_4};
fmt_landfill_pose_4_dirs = {fmt_landfill_pose_4_dir_1, fmt_landfill_pose_4_dir_2, fmt_landfill_pose_4_dir_3, fmt_landfill_pose_4_dir_4};
fmt_landfill_pose_5_dirs = {fmt_landfill_pose_5_dir_1, fmt_landfill_pose_5_dir_2, fmt_landfill_pose_5_dir_3, fmt_landfill_pose_5_dir_4};
fmt_landfill_pose_6_dirs = {fmt_landfill_pose_6_dir_1, fmt_landfill_pose_6_dir_2, fmt_landfill_pose_6_dir_3, fmt_landfill_pose_6_dir_4};
fmt_landfill_pose_7_dirs = {fmt_landfill_pose_7_dir_1, fmt_landfill_pose_7_dir_2, fmt_landfill_pose_7_dir_3, fmt_landfill_pose_7_dir_4};
fmt_landfill_poses = {fmt_landfill_pose_1_dirs;
                  fmt_landfill_pose_2_dirs;
                  fmt_landfill_pose_3_dirs;
                  fmt_landfill_pose_4_dirs;
                  fmt_landfill_pose_5_dirs;
                  fmt_landfill_pose_6_dirs;
                  fmt_landfill_pose_7_dirs};


csm_landfill_pose_1_dir_1 = strcat(csm_landfill_base_str, 'pose_1/noise_s=0.0/2020-11-08_02:39:51');
csm_landfill_pose_1_dir_2 = strcat(csm_landfill_base_str, 'pose_1/noise_s=0.01/2020-11-07_23:52:27');
csm_landfill_pose_1_dir_3 = strcat(csm_landfill_base_str, 'pose_1/noise_s=0.02/2020-11-07_21:48:38');
csm_landfill_pose_1_dir_4 = strcat(csm_landfill_base_str, 'pose_1/noise_s=0.05/2020-11-07_17:31:00');

csm_landfill_pose_2_dir_1 = strcat(csm_landfill_base_str, 'pose_2/noise_s=0.0/2020-11-08_12:24:31');
csm_landfill_pose_2_dir_2 = strcat(csm_landfill_base_str, 'pose_2/noise_s=0.01/2020-11-08_14:44:27');
csm_landfill_pose_2_dir_3 = strcat(csm_landfill_base_str, 'pose_2/noise_s=0.02/2020-11-08_17:27:11');
csm_landfill_pose_2_dir_4 = strcat(csm_landfill_base_str, 'pose_2/noise_s=0.05/2020-11-08_20:12:34');

csm_landfill_pose_3_dir_1 = strcat(csm_landfill_base_str, 'pose_3/noise_s=0.0/2020-11-09_01:22:14');
csm_landfill_pose_3_dir_2 = strcat(csm_landfill_base_str, 'pose_3/noise_s=0.01/2020-11-09_10:07:28');
csm_landfill_pose_3_dir_3 = strcat(csm_landfill_base_str, 'pose_3/noise_s=0.02/2020-11-09_12:12:11');
csm_landfill_pose_3_dir_4 = strcat(csm_landfill_base_str, 'pose_3/noise_s=0.05/2020-11-09_14:18:56');

csm_landfill_pose_4_dir_1 = strcat(csm_landfill_base_str, 'pose_4/noise_s=0.0/2020-11-09_16:25:58');
csm_landfill_pose_4_dir_2 = strcat(csm_landfill_base_str, 'pose_4/noise_s=0.01/2020-11-09_18:24:57');
csm_landfill_pose_4_dir_3 = strcat(csm_landfill_base_str, 'pose_4/noise_s=0.02/2020-11-09_20:54:44');
csm_landfill_pose_4_dir_4 = strcat(csm_landfill_base_str, 'pose_4/noise_s=0.05/2020-11-09_23:07:32');

csm_landfill_pose_5_dir_1 = strcat(csm_landfill_base_str, 'pose_5/noise_s=0.0/2020-11-10_01:05:49');
csm_landfill_pose_5_dir_2 = strcat(csm_landfill_base_str, 'pose_5/noise_s=0.01/2020-11-10_10:35:26');
csm_landfill_pose_5_dir_3 = strcat(csm_landfill_base_str, 'pose_5/noise_s=0.02/2020-11-10_12:37:31');
csm_landfill_pose_5_dir_4 = strcat(csm_landfill_base_str, 'pose_5/noise_s=0.05/2020-11-10_14:57:32');

csm_landfill_pose_6_dir_1 = strcat(csm_landfill_base_str, 'pose_6/noise_s=0.0/2020-11-10_17:09:01');
csm_landfill_pose_6_dir_2 = strcat(csm_landfill_base_str, 'pose_6/noise_s=0.01/2020-11-10_19:11:36');
csm_landfill_pose_6_dir_3 = strcat(csm_landfill_base_str, 'pose_6/noise_s=0.02/2020-11-10_21:29:43');
csm_landfill_pose_6_dir_4 = strcat(csm_landfill_base_str, 'pose_6/noise_s=0.05/2020-11-10_23:57:44');

csm_landfill_pose_7_dir_1 = strcat(csm_landfill_base_str, 'pose_7/noise_s=0.0/2020-11-11_01:55:50');
csm_landfill_pose_7_dir_2 = strcat(csm_landfill_base_str, 'pose_7/noise_s=0.01/2020-11-11_11:06:06');
csm_landfill_pose_7_dir_3 = strcat(csm_landfill_base_str, 'pose_7/noise_s=0.02/2020-11-11_13:12:29');
csm_landfill_pose_7_dir_4 = strcat(csm_landfill_base_str, 'pose_7/noise_s=0.05/2020-11-11_15:12:33');


csm_landfill_pose_1_dirs = {csm_landfill_pose_1_dir_1, csm_landfill_pose_1_dir_2, csm_landfill_pose_1_dir_3, csm_landfill_pose_1_dir_4};
csm_landfill_pose_2_dirs = {csm_landfill_pose_2_dir_1, csm_landfill_pose_2_dir_2, csm_landfill_pose_2_dir_3, csm_landfill_pose_2_dir_4};
csm_landfill_pose_3_dirs = {csm_landfill_pose_3_dir_1, csm_landfill_pose_3_dir_2, csm_landfill_pose_3_dir_3, csm_landfill_pose_3_dir_4};
csm_landfill_pose_4_dirs = {csm_landfill_pose_4_dir_1, csm_landfill_pose_4_dir_2, csm_landfill_pose_4_dir_3, csm_landfill_pose_4_dir_4};
csm_landfill_pose_5_dirs = {csm_landfill_pose_5_dir_1, csm_landfill_pose_5_dir_2, csm_landfill_pose_5_dir_3, csm_landfill_pose_5_dir_4};
csm_landfill_pose_6_dirs = {csm_landfill_pose_6_dir_1, csm_landfill_pose_6_dir_2, csm_landfill_pose_6_dir_3, csm_landfill_pose_6_dir_4};
csm_landfill_pose_7_dirs = {csm_landfill_pose_7_dir_1, csm_landfill_pose_7_dir_2, csm_landfill_pose_7_dir_3, csm_landfill_pose_7_dir_4};
csm_landfill_poses = {csm_landfill_pose_1_dirs;
                  csm_landfill_pose_2_dirs;
                  csm_landfill_pose_3_dirs;
                  csm_landfill_pose_4_dirs;
                  csm_landfill_pose_5_dirs;
                  csm_landfill_pose_6_dirs;
                  csm_landfill_pose_7_dirs};



fmt_landfill_exec_time = [];
csm_landfill_exec_time = [];


for r=1:size(fmt_landfill_poses,1)
  fmt_landfill_exec_time_row = [];
  csm_landfill_exec_time_row = [];

  for c=1:size(fmt_landfill_poses{1},2)
    [fmt_e fmt_oe fmt_t fmt_o] = function_top_level_script(fmt_landfill_poses{r}{c});
    [csm_e csm_oe csm_t csm_o] = function_top_level_script(csm_landfill_poses{r}{c});

    fmt_landfill_exec_time_row = [fmt_landfill_exec_time_row, fmt_t-0.7];
    csm_landfill_exec_time_row = [csm_landfill_exec_time_row, csm_t];
  end
  fmt_landfill_exec_time = [fmt_landfill_exec_time; fmt_landfill_exec_time_row];

  csm_landfill_exec_time = [csm_landfill_exec_time; csm_landfill_exec_time_row];
end

xaxis = [1 2 3 4];
h = figure(1);
set(h,'position',[1 1 250 150]);

subplot(1,2,1)
hold on;
plot(xaxis, fmt_landfill_exec_time(1,:), 'marker', '+', 'color', 'k');
plot(xaxis, fmt_landfill_exec_time(2,:), 'marker', 'o', 'color', 'k');
plot(xaxis, fmt_landfill_exec_time(3,:), 'marker', '*', 'color', 'k');
plot(xaxis, fmt_landfill_exec_time(4,:), 'marker', '.', 'color', 'k');
plot(xaxis, fmt_landfill_exec_time(5,:), 'marker', 'x', 'color', 'k');
plot(xaxis, fmt_landfill_exec_time(6,:), 'marker', 's', 'color', 'k');
plot(xaxis, fmt_landfill_exec_time(7,:), 'marker', 'd', 'color', 'k');

xlim([0.5 4.5]);
set(gca, 'XTick', [1 2 3 4]);
set(gca, 'xticklabel', {'$0.0$', '$0.01$', '$0.02$', '$0.05$'});
set(gca, 'YTick', [0.2 0.25 0.30 0.35]);
set(gca, 'yticklabel', {'$0.20$', '$0.25$', '$0.30$', '$0.35$'});
set(gca, 'ylabel', 'Mean execution time [sec]');
ylim([0.2 0.35])
title('PGL-FMIC');

subplot(1,2,2)
hold on;
plot(xaxis, csm_landfill_exec_time(1,:), 'marker', '+', 'color', 'k');
plot(xaxis, csm_landfill_exec_time(2,:), 'marker', 'o', 'color', 'k');
plot(xaxis, csm_landfill_exec_time(3,:), 'marker', '*', 'color', 'k');
plot(xaxis, csm_landfill_exec_time(4,:), 'marker', '.', 'color', 'k');
plot(xaxis, csm_landfill_exec_time(5,:), 'marker', 'x', 'color', 'k');
plot(xaxis, csm_landfill_exec_time(6,:), 'marker', 's', 'color', 'k');
plot(xaxis, csm_landfill_exec_time(7,:), 'marker', 'd', 'color', 'k');

xlim([0.5 4.5]);
set(gca, 'XTick', [1 2 3 4]);
set(gca, 'xticklabel', {'$0.0$', '$0.01$', '$0.02$', '$0.05$'});
set(gca, 'YTick', [0.2 0.25 0.30 0.35]);
set(gca, 'yticklabel', {'$0.20$', '$0.25$', '$0.30$', '$0.35$'});
ylim([0.2 0.35])
title('PL-ICP');
set(gca, 'xlabel', '$d$ [m]: sensor noise $\mathcal{N}(0.0,d)$');

if (store_exec_time == 1)
  img_file = strcat('/media/ext/backup_files/AUTh/RELIEF/relief-fmt-global-localisation-paper/figures/results/simulation/landfill/exec_time.eps');
  drawnow ("epslatex", img_file, false);
end

