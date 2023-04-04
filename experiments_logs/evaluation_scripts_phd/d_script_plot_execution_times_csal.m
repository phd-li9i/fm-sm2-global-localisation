clear all
close all

store = 1;
here = '/home/li9i/catkin_ws/src/relief_fmt_global_localisation/experiments_logs/evaluation_scripts_phd/';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% csal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fmt_csal_base_str = 'vault/fmt/Centroid-based/noise_s=125/csal/';
csm_csal_base_str = 'vault/csm/csal/';

fmt_csal_pose_1_dir_1 = strcat(fmt_csal_base_str, 'pose_1');

fmt_csal_pose_2_dir_1 = strcat(fmt_csal_base_str, 'pose_2');

fmt_csal_pose_3_dir_1 = strcat(fmt_csal_base_str, 'pose_3');

fmt_csal_pose_4_dir_1 = strcat(fmt_csal_base_str, 'pose_4');

fmt_csal_pose_5_dir_1 = strcat(fmt_csal_base_str, 'pose_5');

fmt_csal_pose_6_dir_1 = strcat(fmt_csal_base_str, 'pose_6');

fmt_csal_pose_7_dir_1 = strcat(fmt_csal_base_str, 'pose_7');

fmt_csal_pose_8_dir_1 = strcat(fmt_csal_base_str, 'pose_8');

fmt_csal_pose_9_dir_1 = strcat(fmt_csal_base_str, 'pose_9');

fmt_csal_pose_10_dir_1 = strcat(fmt_csal_base_str, 'pose_10');

fmt_csal_pose_11_dir_1 = strcat(fmt_csal_base_str, 'pose_11');

fmt_csal_pose_1_dirs = {fmt_csal_pose_1_dir_1};
fmt_csal_pose_2_dirs = {fmt_csal_pose_2_dir_1};
fmt_csal_pose_3_dirs = {fmt_csal_pose_3_dir_1};
fmt_csal_pose_4_dirs = {fmt_csal_pose_4_dir_1};
fmt_csal_pose_5_dirs = {fmt_csal_pose_5_dir_1};
fmt_csal_pose_6_dirs = {fmt_csal_pose_6_dir_1};
fmt_csal_pose_7_dirs = {fmt_csal_pose_7_dir_1};
fmt_csal_pose_8_dirs = {fmt_csal_pose_8_dir_1};
fmt_csal_pose_9_dirs = {fmt_csal_pose_9_dir_1};
fmt_csal_pose_10_dirs = {fmt_csal_pose_10_dir_1};
fmt_csal_pose_11_dirs = {fmt_csal_pose_11_dir_1};
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


csm_csal_pose_1_dir_1 = strcat(csm_csal_base_str, 'pose_1');

csm_csal_pose_2_dir_1 = strcat(csm_csal_base_str, 'pose_2');

csm_csal_pose_3_dir_1 = strcat(csm_csal_base_str, 'pose_3');

csm_csal_pose_4_dir_1 = strcat(csm_csal_base_str, 'pose_4');

csm_csal_pose_5_dir_1 = strcat(csm_csal_base_str, 'pose_5');

csm_csal_pose_6_dir_1 = strcat(csm_csal_base_str, 'pose_6');

csm_csal_pose_7_dir_1 = strcat(csm_csal_base_str, 'pose_7');

csm_csal_pose_8_dir_1 = strcat(csm_csal_base_str, 'pose_8');

csm_csal_pose_9_dir_1 = strcat(csm_csal_base_str, 'pose_9');

csm_csal_pose_10_dir_1 = strcat(csm_csal_base_str, 'pose_10');

csm_csal_pose_11_dir_1 = strcat(csm_csal_base_str, 'pose_11');

csm_csal_pose_1_dirs = {csm_csal_pose_1_dir_1};
csm_csal_pose_2_dirs = {csm_csal_pose_2_dir_1};
csm_csal_pose_3_dirs = {csm_csal_pose_3_dir_1};
csm_csal_pose_4_dirs = {csm_csal_pose_4_dir_1};
csm_csal_pose_5_dirs = {csm_csal_pose_5_dir_1};
csm_csal_pose_6_dirs = {csm_csal_pose_6_dir_1};
csm_csal_pose_7_dirs = {csm_csal_pose_7_dir_1};
csm_csal_pose_8_dirs = {csm_csal_pose_8_dir_1};
csm_csal_pose_9_dirs = {csm_csal_pose_9_dir_1};
csm_csal_pose_10_dirs = {csm_csal_pose_10_dir_1};
csm_csal_pose_11_dirs = {csm_csal_pose_11_dir_1};
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



fmt_csal_exec_time = [];
csm_csal_exec_time = [];


for r=1:size(fmt_csal_poses,1)
  fmt_csal_exec_time_row = [];
  csm_csal_exec_time_row = [];

  for c=1:size(fmt_csal_poses{1},2)
    [fmt_e fmt_tt fmt_t fmt_o] = function_top_level_script(fmt_csal_poses{r}{c})
    [csm_e csm_tt csm_t csm_o] = function_top_level_script(csm_csal_poses{r}{c});

    fmt_csal_exec_time_row = [fmt_csal_exec_time_row, fmt_t];
    csm_csal_exec_time_row = [csm_csal_exec_time_row, csm_t];
  end
  fmt_csal_exec_time = [fmt_csal_exec_time; fmt_csal_exec_time_row];

  csm_csal_exec_time = [csm_csal_exec_time; csm_csal_exec_time_row];
end


cd(here);
c = colours2();
linewidth = 3;

xaxis = 1:11;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h = figure(1);
set(h,'position',[1 1 200 150]);
subplot(2,1,1);
hold on
for i = 1:6
  s = stem(i, csm_csal_exec_time(i));
  set(s, 'color', [c{i}(2,:)], 'markerfacecolor', [c{i}(2,:)], 'markeredgecolor', [c{i}(2,:)], 'linewidth', linewidth);
end
for i = 7:2:11
  s = stem(i, csm_csal_exec_time(i));
  set(s, 'color', [c{i}(2,:)], 'markerfacecolor', [c{i}(2,:)], 'markeredgecolor', [c{i}(2,:)], 'linewidth', linewidth);
end

ylim([0 1.2])
set(gca, 'XTick', [1 2 3 4 5 6 7 8 9 10 11], 'xticklabel', []);
set(gca, 'ylabel', 'PL-ICP');
set(gca, 'ytick', [0 0.2 0.4 0.6 0.8 1.0 1.2]);
set(gca, 'yticklabel', {'\\small $0$','\\small $200$','\\small $400$','\\small $600$','\\small $800$','\\small $1000$','\\small $1200$'});
title('Mean execution time [ms]');
%grid
box on



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(2,1,2);
hold on
for i = 1:11
  s = stem(i, fmt_csal_exec_time(i));
  set(s, 'color', [c{i}(2,:)], 'markerfacecolor', [c{i}(2,:)], 'markeredgecolor', [c{i}(2,:)], 'linewidth', linewidth);
end

ylim([0 1.2])
set(gca, 'XTick', [1 2 3 4 5 6 7 8 9 10 11]);
set(gca, 'xticklabel', {'\\small $\\bm{p}_a^A$', '\\small $\\bm{p}_b^A$', '\\small $\\bm{p}_c^A$', '\\small $\\bm{p}_d^A$', '\\small $\\bm{p}_e^A$', '\\small $\\bm{p}_f^A$', '\\small $\\bm{p}_g^A$', '\\small $\\bm{p}_h^A$', '\\small $\\bm{p}_i^A$', '\\small $\\bm{p}_j^A$', '\\small $\\bm{p}_k^A$' });
set(gca, 'ytick', [0 0.2 0.4 0.6 0.8 1.0 1.2]);
set(gca, 'yticklabel', {'\\small $0$','\\small $200$','\\small $400$','\\small $600$','\\small $800$','\\small $1000$','\\small $1200$'});
set(gca, 'ylabel', 'PGL-FMIC');
set(gca, 'xlabel', 'Identifier of tested pose in real environment CSAL');
%grid
box on


if (store)
  img_file = strcat('/home/li9i/catkin_ws/src/relief_fmt_global_localisation/experiments_logs/evaluation_scripts_phd/figures/csal_execution_times.eps');
  drawnow ("epslatex", img_file, false);
end
