clear all
close all

store_exec_time = 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% home
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fmt_home_base_str = 'vault/fmt/Centroid-based/home/';
csm_home_base_str = 'vault/csm/home/';

fmt_home_pose_1_dir_1 = strcat(fmt_home_base_str, 'pose_1/noise_s=0.0/2020-02-28_17:06:36');
fmt_home_pose_1_dir_2 = strcat(fmt_home_base_str, 'pose_1/noise_s=0.01/2020-02-29_00:41:39');
fmt_home_pose_1_dir_3 = strcat(fmt_home_base_str, 'pose_1/noise_s=0.02/2020-02-29_14:51:19');
fmt_home_pose_1_dir_4 = strcat(fmt_home_base_str, 'pose_1/noise_s=0.05/2020-03-01_14:51:25');

fmt_home_pose_2_dir_1 = strcat(fmt_home_base_str, 'pose_2/noise_s=0.0/2020-03-19_15:14:50');
fmt_home_pose_2_dir_2 = strcat(fmt_home_base_str, 'pose_2/noise_s=0.01/2020-03-19_22:09:40');
fmt_home_pose_2_dir_3 = strcat(fmt_home_base_str, 'pose_2/noise_s=0.02/2020-03-20_09:25:23');
fmt_home_pose_2_dir_4 = strcat(fmt_home_base_str, 'pose_2/noise_s=0.05/2020-03-20_16:25:12');

fmt_home_pose_3_dir_1 = strcat(fmt_home_base_str, 'pose_3/noise_s=0.0/2020-03-21_18:59:40');
fmt_home_pose_3_dir_2 = strcat(fmt_home_base_str, 'pose_3/noise_s=0.01/2020-03-22_02:29:06');
fmt_home_pose_3_dir_3 = strcat(fmt_home_base_str, 'pose_3/noise_s=0.02/2020-03-22_11:50:58');
fmt_home_pose_3_dir_4 = strcat(fmt_home_base_str, 'pose_3/noise_s=0.05/2020-03-22_19:33:51');

fmt_home_pose_4_dir_1 = strcat(fmt_home_base_str, 'pose_4/noise_s=0.0/2020-03-25_01:22:14');
fmt_home_pose_4_dir_2 = strcat(fmt_home_base_str, 'pose_4/noise_s=0.01/2020-03-24_16:50:29');
fmt_home_pose_4_dir_3 = strcat(fmt_home_base_str, 'pose_4/noise_s=0.02/2020-03-24_09:45:09');
fmt_home_pose_4_dir_4 = strcat(fmt_home_base_str, 'pose_4/noise_s=0.05/2020-03-23_21:31:05');

fmt_home_pose_5_dir_1 = strcat(fmt_home_base_str, 'pose_5/noise_s=0.0/2020-06-13_12:57:51');
fmt_home_pose_5_dir_2 = strcat(fmt_home_base_str, 'pose_5/noise_s=0.01/2020-06-13_22:52:26');
fmt_home_pose_5_dir_3 = strcat(fmt_home_base_str, 'pose_5/noise_s=0.02/2020-06-12_12:42:45');
fmt_home_pose_5_dir_4 = strcat(fmt_home_base_str, 'pose_5/noise_s=0.05/2020-06-12_21:18:45');

fmt_home_pose_6_dir_1 = strcat(fmt_home_base_str, 'pose_6/noise_s=0.0/2020-03-28_12:57:40');
fmt_home_pose_6_dir_2 = strcat(fmt_home_base_str, 'pose_6/noise_s=0.01/2020-03-27_23:22:45');
fmt_home_pose_6_dir_3 = strcat(fmt_home_base_str, 'pose_6/noise_s=0.02/2020-03-27_16:22:33');
fmt_home_pose_6_dir_4 = strcat(fmt_home_base_str, 'pose_6/noise_s=0.05/2020-03-27_09:26:12');

fmt_home_pose_7_dir_1 = strcat(fmt_home_base_str, 'pose_7/noise_s=0.0/2020-03-30_09:11:37');
fmt_home_pose_7_dir_2 = strcat(fmt_home_base_str, 'pose_7/noise_s=0.01/2020-03-29_20:45:41');
fmt_home_pose_7_dir_3 = strcat(fmt_home_base_str, 'pose_7/noise_s=0.02/2020-03-29_13:41:55');
fmt_home_pose_7_dir_4 = strcat(fmt_home_base_str, 'pose_7/noise_s=0.05/2020-03-28_23:09:03');

fmt_home_pose_8_dir_1 = strcat(fmt_home_base_str, 'pose_8/noise_s=0.0/2020-06-10_22:51:41');
fmt_home_pose_8_dir_2 = strcat(fmt_home_base_str, 'pose_8/noise_s=0.01/2020-06-10_13:00:10');
fmt_home_pose_8_dir_3 = strcat(fmt_home_base_str, 'pose_8/noise_s=0.02/2020-06-11_10:09:56');
fmt_home_pose_8_dir_4 = strcat(fmt_home_base_str, 'pose_8/noise_s=0.05/2020-06-11_18:49:26');

fmt_home_pose_9_dir_1 = strcat(fmt_home_base_str, 'pose_9/noise_s=0.0/2020-04-03_09:37:06');
fmt_home_pose_9_dir_2 = strcat(fmt_home_base_str, 'pose_9/noise_s=0.01/2020-04-03_00:41:37');
fmt_home_pose_9_dir_3 = strcat(fmt_home_base_str, 'pose_9/noise_s=0.02/2020-04-02_17:23:49');
fmt_home_pose_9_dir_4 = strcat(fmt_home_base_str, 'pose_9/noise_s=0.05/2020-04-02_10:20:54');

fmt_home_pose_10_dir_1 = strcat(fmt_home_base_str, 'pose_10/noise_s=0.0/2020-04-04_12:29:21');
fmt_home_pose_10_dir_2 = strcat(fmt_home_base_str, 'pose_10/noise_s=0.01/2020-04-04_19:33:55');
fmt_home_pose_10_dir_3 = strcat(fmt_home_base_str, 'pose_10/noise_s=0.02/2020-04-05_03:36:15');
fmt_home_pose_10_dir_4 = strcat(fmt_home_base_str, 'pose_10/noise_s=0.05/2020-04-05_14:31:27');

fmt_home_pose_11_dir_1 = strcat(fmt_home_base_str, 'pose_11/noise_s=0.0/2020-04-08_18:08:02');
fmt_home_pose_11_dir_2 = strcat(fmt_home_base_str, 'pose_11/noise_s=0.01/2020-04-08_10:11:44');
fmt_home_pose_11_dir_3 = strcat(fmt_home_base_str, 'pose_11/noise_s=0.02/2020-04-07_23:04:27');
fmt_home_pose_11_dir_4 = strcat(fmt_home_base_str, 'pose_11/noise_s=0.05/2020-04-07_15:27:07');

fmt_home_pose_1_dirs = {fmt_home_pose_1_dir_1, fmt_home_pose_1_dir_2, fmt_home_pose_1_dir_3, fmt_home_pose_1_dir_4};
fmt_home_pose_2_dirs = {fmt_home_pose_2_dir_1, fmt_home_pose_2_dir_2, fmt_home_pose_2_dir_3, fmt_home_pose_2_dir_4};
fmt_home_pose_3_dirs = {fmt_home_pose_3_dir_1, fmt_home_pose_3_dir_2, fmt_home_pose_3_dir_3, fmt_home_pose_3_dir_4};
fmt_home_pose_4_dirs = {fmt_home_pose_4_dir_1, fmt_home_pose_4_dir_2, fmt_home_pose_4_dir_3, fmt_home_pose_4_dir_4};
fmt_home_pose_5_dirs = {fmt_home_pose_5_dir_1, fmt_home_pose_5_dir_2, fmt_home_pose_5_dir_3, fmt_home_pose_5_dir_4};
fmt_home_pose_6_dirs = {fmt_home_pose_6_dir_1, fmt_home_pose_6_dir_2, fmt_home_pose_6_dir_3, fmt_home_pose_6_dir_4};
fmt_home_pose_7_dirs = {fmt_home_pose_7_dir_1, fmt_home_pose_7_dir_2, fmt_home_pose_7_dir_3, fmt_home_pose_7_dir_4};
fmt_home_pose_8_dirs = {fmt_home_pose_8_dir_1, fmt_home_pose_8_dir_2, fmt_home_pose_8_dir_3, fmt_home_pose_8_dir_4};
fmt_home_pose_9_dirs = {fmt_home_pose_9_dir_1, fmt_home_pose_9_dir_2, fmt_home_pose_9_dir_3, fmt_home_pose_9_dir_4};
fmt_home_pose_10_dirs = {fmt_home_pose_10_dir_1, fmt_home_pose_10_dir_2, fmt_home_pose_10_dir_3, fmt_home_pose_10_dir_4};
fmt_home_pose_11_dirs = {fmt_home_pose_11_dir_1, fmt_home_pose_11_dir_2, fmt_home_pose_11_dir_3, fmt_home_pose_11_dir_4};
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


csm_home_pose_1_dir_1 = strcat(csm_home_base_str, 'pose_1/noise_s=0.0/2020-02-17_11:10:50');
csm_home_pose_1_dir_2 = strcat(csm_home_base_str, 'pose_1/noise_s=0.01/2020-02-17_12:36:24');
csm_home_pose_1_dir_3 = strcat(csm_home_base_str, 'pose_1/noise_s=0.02/2020-02-14_16:17:33');
csm_home_pose_1_dir_4 = strcat(csm_home_base_str, 'pose_1/noise_s=0.05/2020-02-17_09:40:53');

csm_home_pose_2_dir_1 = strcat(csm_home_base_str, 'pose_2/noise_s=0.0/2020-03-21_15:10:50');
csm_home_pose_2_dir_2 = strcat(csm_home_base_str, 'pose_2/noise_s=0.01/2020-03-21_12:32:16');
csm_home_pose_2_dir_3 = strcat(csm_home_base_str, 'pose_2/noise_s=0.02/2020-03-21_01:50:20');
csm_home_pose_2_dir_4 = strcat(csm_home_base_str, 'pose_2/noise_s=0.05/2020-03-20_23:21:33');

csm_home_pose_3_dir_1 = strcat(csm_home_base_str, 'pose_3/noise_s=0.0/2020-03-23_18:30:58');
csm_home_pose_3_dir_2 = strcat(csm_home_base_str, 'pose_3/noise_s=0.01/2020-03-23_15:57:58');
csm_home_pose_3_dir_3 = strcat(csm_home_base_str, 'pose_3/noise_s=0.02/2020-03-23_13:08:04');
csm_home_pose_3_dir_4 = strcat(csm_home_base_str, 'pose_3/noise_s=0.05/2020-03-23_10:41:35');

csm_home_pose_4_dir_1 = strcat(csm_home_base_str, 'pose_4/noise_s=0.0/2020-03-25_09:19:45');
csm_home_pose_4_dir_2 = strcat(csm_home_base_str, 'pose_4/noise_s=0.01/2020-03-25_09:48:03');
csm_home_pose_4_dir_3 = strcat(csm_home_base_str, 'pose_4/noise_s=0.02/2020-03-25_10:13:33');
csm_home_pose_4_dir_4 = strcat(csm_home_base_str, 'pose_4/noise_s=0.05/2020-03-25_10:30:21');

csm_home_pose_5_dir_1 = strcat(csm_home_base_str, 'pose_5/noise_s=0.0/2020-03-26_16:59:57');
csm_home_pose_5_dir_2 = strcat(csm_home_base_str, 'pose_5/noise_s=0.01/2020-03-26_19:27:40');
csm_home_pose_5_dir_3 = strcat(csm_home_base_str, 'pose_5/noise_s=0.02/2020-03-26_22:00:47');
csm_home_pose_5_dir_4 = strcat(csm_home_base_str, 'pose_5/noise_s=0.05/2020-03-27_00:25:52');

csm_home_pose_6_dir_1 = strcat(csm_home_base_str, 'pose_6/noise_s=0.0/2020-03-28_20:11:26');
csm_home_pose_6_dir_2 = strcat(csm_home_base_str, 'pose_6/noise_s=0.01/2020-03-28_21:46:50');
csm_home_pose_6_dir_3 = strcat(csm_home_base_str, 'pose_6/noise_s=0.02/2020-03-28_22:13:58');
csm_home_pose_6_dir_4 = strcat(csm_home_base_str, 'pose_6/noise_s=0.05/2020-03-28_22:49:17');

csm_home_pose_7_dir_1 = strcat(csm_home_base_str, 'pose_7/noise_s=0.0/2020-03-30_16:47:28');
csm_home_pose_7_dir_2 = strcat(csm_home_base_str, 'pose_7/noise_s=0.01/2020-03-30_18:34:41');
csm_home_pose_7_dir_3 = strcat(csm_home_base_str, 'pose_7/noise_s=0.02/2020-03-30_21:02:52');
csm_home_pose_7_dir_4 = strcat(csm_home_base_str, 'pose_7/noise_s=0.05/2020-03-31_00:42:09');

csm_home_pose_8_dir_1 = strcat(csm_home_base_str, 'pose_8/noise_s=0.0/2020-04-01_17:01:58');
csm_home_pose_8_dir_2 = strcat(csm_home_base_str, 'pose_8/noise_s=0.01/2020-04-01_19:35:35');
csm_home_pose_8_dir_3 = strcat(csm_home_base_str, 'pose_8/noise_s=0.02/2020-04-01_22:03:43');
csm_home_pose_8_dir_4 = strcat(csm_home_base_str, 'pose_8/noise_s=0.05/2020-04-02_00:51:59');

csm_home_pose_9_dir_1 = strcat(csm_home_base_str, 'pose_9/noise_s=0.0/2020-04-04_00:37:35');
csm_home_pose_9_dir_2 = strcat(csm_home_base_str, 'pose_9/noise_s=0.01/2020-04-03_21:46:59');
csm_home_pose_9_dir_3 = strcat(csm_home_base_str, 'pose_9/noise_s=0.02/2020-04-03_19:15:27');
csm_home_pose_9_dir_4 = strcat(csm_home_base_str, 'pose_9/noise_s=0.05/2020-04-03_16:34:29');

csm_home_pose_10_dir_1 = strcat(csm_home_base_str, 'pose_10/noise_s=0.0/2020-04-06_12:50:30');
csm_home_pose_10_dir_2 = strcat(csm_home_base_str, 'pose_10/noise_s=0.01/2020-04-06_09:49:56');
csm_home_pose_10_dir_3 = strcat(csm_home_base_str, 'pose_10/noise_s=0.02/2020-04-06_00:41:07');
csm_home_pose_10_dir_4 = strcat(csm_home_base_str, 'pose_10/noise_s=0.05/2020-04-05_21:53:56');

csm_home_pose_11_dir_1 = strcat(csm_home_base_str, 'pose_11/noise_s=0.0/2020-04-06_18:41:17');
csm_home_pose_11_dir_2 = strcat(csm_home_base_str, 'pose_11/noise_s=0.01/2020-04-06_22:30:50');
csm_home_pose_11_dir_3 = strcat(csm_home_base_str, 'pose_11/noise_s=0.02/2020-04-07_09:27:07');
csm_home_pose_11_dir_4 = strcat(csm_home_base_str, 'pose_11/noise_s=0.05/2020-04-07_12:12:21');

csm_home_pose_1_dirs = {csm_home_pose_1_dir_1, csm_home_pose_1_dir_2, csm_home_pose_1_dir_3, csm_home_pose_1_dir_4};
csm_home_pose_2_dirs = {csm_home_pose_2_dir_1, csm_home_pose_2_dir_2, csm_home_pose_2_dir_3, csm_home_pose_2_dir_4};
csm_home_pose_3_dirs = {csm_home_pose_3_dir_1, csm_home_pose_3_dir_2, csm_home_pose_3_dir_3, csm_home_pose_3_dir_4};
csm_home_pose_4_dirs = {csm_home_pose_4_dir_1, csm_home_pose_4_dir_2, csm_home_pose_4_dir_3, csm_home_pose_4_dir_4};
csm_home_pose_5_dirs = {csm_home_pose_5_dir_1, csm_home_pose_5_dir_2, csm_home_pose_5_dir_3, csm_home_pose_5_dir_4};
csm_home_pose_6_dirs = {csm_home_pose_6_dir_1, csm_home_pose_6_dir_2, csm_home_pose_6_dir_3, csm_home_pose_6_dir_4};
csm_home_pose_7_dirs = {csm_home_pose_7_dir_1, csm_home_pose_7_dir_2, csm_home_pose_7_dir_3, csm_home_pose_7_dir_4};
csm_home_pose_8_dirs = {csm_home_pose_8_dir_1, csm_home_pose_8_dir_2, csm_home_pose_8_dir_3, csm_home_pose_8_dir_4};
csm_home_pose_9_dirs = {csm_home_pose_9_dir_1, csm_home_pose_9_dir_2, csm_home_pose_9_dir_3, csm_home_pose_9_dir_4};
csm_home_pose_10_dirs = {csm_home_pose_10_dir_1, csm_home_pose_10_dir_2, csm_home_pose_10_dir_3, csm_home_pose_10_dir_4};
csm_home_pose_11_dirs = {csm_home_pose_11_dir_1, csm_home_pose_11_dir_2, csm_home_pose_11_dir_3, csm_home_pose_11_dir_4};
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



fmt_home_exec_time = [];
csm_home_exec_time = [];


for r=1:size(fmt_home_poses,1)
  fmt_home_exec_time_row = [];
  csm_home_exec_time_row = [];

  for c=1:size(fmt_home_poses{1},2)
    [fmt_e fmt_t fmt_o] = function_top_level_script(fmt_home_poses{r}{c});
    [csm_e csm_t csm_o] = function_top_level_script(csm_home_poses{r}{c});

    fmt_home_exec_time_row = [fmt_home_exec_time_row, fmt_t-0.7];
    csm_home_exec_time_row = [csm_home_exec_time_row, csm_t];
  end
  fmt_home_exec_time = [fmt_home_exec_time; fmt_home_exec_time_row];

  csm_home_exec_time = [csm_home_exec_time; csm_home_exec_time_row];
end

xaxis = [1 2 3 4];
h = figure(1);
set(h,'position',[1 1 250 150]);

subplot(1,2,1)
hold on;
plot(xaxis, fmt_home_exec_time(1,:), 'marker', '+', 'color', 'k');
plot(xaxis, fmt_home_exec_time(2,:), 'marker', 'o', 'color', 'k');
plot(xaxis, fmt_home_exec_time(3,:), 'marker', '*', 'color', 'k');
plot(xaxis, fmt_home_exec_time(4,:), 'marker', '.', 'color', 'k');
plot(xaxis, fmt_home_exec_time(5,:), 'marker', 'x', 'color', 'k');
plot(xaxis, fmt_home_exec_time(6,:), 'marker', 's', 'color', 'k');
plot(xaxis, fmt_home_exec_time(7,:), 'marker', 'd', 'color', 'k');
plot(xaxis, fmt_home_exec_time(8,:), 'marker', '^', 'color', 'k');
plot(xaxis, fmt_home_exec_time(9,:), 'marker', 'v', 'color', 'k');
plot(xaxis, fmt_home_exec_time(10,:), 'marker', '>', 'color', 'k');
plot(xaxis, fmt_home_exec_time(11,:), 'marker', '<', 'color', 'k');

xlim([0.5 4.5]);
set(gca, 'XTick', [1 2 3 4]);
set(gca, 'xticklabel', {'$0.0$', '$0.01$', '$0.02$', '$0.05$'});
set(gca, 'YTick', [0.16 0.24 0.32 0.4 0.48]);
set(gca, 'yticklabel', {'$0.16$', '$0.24$', '$0.32$', '$0.40$', '$0.48$'});
set(gca, 'ylabel', 'Mean execution time [sec]');
ylim([0.16 0.48])
title('PGL-FMIC');

subplot(1,2,2)
hold on;
plot(xaxis, csm_home_exec_time(1,:), 'marker', '+', 'color', 'k');
plot(xaxis, csm_home_exec_time(2,:), 'marker', 'o', 'color', 'k');
plot(xaxis, csm_home_exec_time(3,:), 'marker', '*', 'color', 'k');
plot(xaxis, csm_home_exec_time(4,:), 'marker', '.', 'color', 'k');
plot(xaxis, csm_home_exec_time(5,:), 'marker', 'x', 'color', 'k');
plot(xaxis, csm_home_exec_time(6,:), 'marker', 's', 'color', 'k');
plot(xaxis, csm_home_exec_time(7,:), 'marker', 'd', 'color', 'k');
plot(xaxis, csm_home_exec_time(8,:), 'marker', '^', 'color', 'k');
plot(xaxis, csm_home_exec_time(9,:), 'marker', 'v', 'color', 'k');
plot(xaxis, csm_home_exec_time(10,:), 'marker', '>', 'color', 'k');
plot(xaxis, csm_home_exec_time(11,:), 'marker', '<', 'color', 'k');

xlim([0.5 4.5]);
set(gca, 'XTick', [1 2 3 4]);
set(gca, 'xticklabel', {'$0.0$', '$0.01$', '$0.02$', '$0.05$'});
set(gca, 'YTick', [0.16 0.24 0.32 0.4 0.48]);
set(gca, 'yticklabel', {'$0.16$', '$0.24$', '$0.32$', '$0.40$', '$0.48$'});
ylim([0.16 0.48])
title('PL-ICP');
set(gca, 'xlabel', '$d$ [m]: sensor noise $\mathcal{N}(0.0,d)$');

if (store_exec_time == 1)
  img_file = strcat('/media/ext/backup_files/AUTh/RELIEF/relief-fmt-global-localisation-paper/figures/results/simulation/home/exec_time.eps');
  drawnow ("epslatex", img_file, false);
end
