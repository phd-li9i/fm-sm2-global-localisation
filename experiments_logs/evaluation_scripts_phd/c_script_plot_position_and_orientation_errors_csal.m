clear all
close all

store = true;
here = '/home/li9i/catkin_ws/src/relief_fmt_global_localisation/experiments_logs/evaluation_scripts_phd/';


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

cd(here);
c = colours2();
linewidth = 3;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% POSITION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
xaxis = 1:11;
h = figure(1);
set(h,'position',[1 1 200 150]);
subplot(2,1,1);
hold on
for i = 1:6
  s = stem(i, csm_csal_xy_errors(i));
  set(s, 'color', [c{i}(2,:)], 'markerfacecolor', [c{i}(2,:)], 'markeredgecolor', [c{i}(2,:)], 'linewidth', linewidth);
end
for i = 7:2:11
  s = stem(i, csm_csal_xy_errors(i));
  set(s, 'color', [c{i}(2,:)], 'markerfacecolor', [c{i}(2,:)], 'markeredgecolor', [c{i}(2,:)], 'linewidth', linewidth);
end

xlim([0 12])
ylim([0 0.35])
set(gca, 'XTick', [1 2 3 4 5 6 7 8 9 10 11]);
set(gca, 'xticklabel', []);
set(gca, 'YTick', [0 0.10 0.20 0.30])
set(gca, 'yticklabel', {'\\small $0.0$', '\\small $0.10$','\\small $0.20$','\\small $0.30$'});
set(gca, 'ylabel', 'PLICP');
title('Mean inlier location error [m]');
%grid
box on


subplot(2,1,2);
hold on
for i = 1:11
  s = stem(i, fmt_csal_xy_errors(i));
  set(s, 'color', [c{i}(2,:)], 'markerfacecolor', [c{i}(2,:)], 'markeredgecolor', [c{i}(2,:)], 'linewidth', linewidth);
end

xlim([0 12])
ylim([0 0.35])
set(gca, 'XTick', [1 2 3 4 5 6 7 8 9 10 11]);
set(gca, 'xticklabel', {'\\small $\\bm{p}_a^A$', '\\small $\\bm{p}_b^A$', '\\small $\\bm{p}_c^A$', '\\small $\\bm{p}_d^A$', '\\small $\\bm{p}_e^A$', '\\small $\\bm{p}_f^A$', '\\small $\\bm{p}_g^A$', '\\small $\\bm{p}_h^A$', '\\small $\\bm{p}_i^A$', '\\small $\\bm{p}_j^A$', '\\small $\\bm{p}_k^A$' });
set(gca, 'YTick', [0 0.10 0.20 0.30])
set(gca, 'yticklabel', {'\\small $0.0$', '\\small $0.10$','\\small $0.20$','\\small $0.30$'});
set(gca, 'ylabel', 'PGL-FMIC');
set(gca, 'xlabel', 'Σημαίνον στάσης');
%grid
box on


if (store)
  img_file = strcat('/home/li9i/catkin_ws/src/relief_fmt_global_localisation/experiments_logs/evaluation_scripts_phd/figures/csal_location_errors.eps');
  drawnow ("epslatex", img_file, false);
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ORIENTATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
xaxis = 1:11;
h = figure(2);
set(h,'position',[1 1 200 150]);
subplot(2,1,1);
hold on
for i = 1:6
  s = stem(i, csm_csal_t_errors(i));
  set(s, 'color', [c{i}(2,:)], 'markerfacecolor', [c{i}(2,:)], 'markeredgecolor', [c{i}(2,:)], 'linewidth', linewidth);
end
for i = 7:2:11
  s = stem(i, csm_csal_t_errors(i));
  set(s, 'color', [c{i}(2,:)], 'markerfacecolor', [c{i}(2,:)], 'markeredgecolor', [c{i}(2,:)], 'linewidth', linewidth);
end

xlim([0 12])
ylim([0 0.12])
set(gca, 'XTick', [1 2 3 4 5 6 7 8 9 10 11]);
set(gca, 'xticklabel', []);
set(gca, 'YTick', [0 0.04 0.08 0.12])
set(gca, 'yticklabel', {'\\small $0.0$', '\\small $0.04$','\\small $0.08$','\\small $0.12$'});
set(gca, 'ylabel', 'PLICP');
title('Mean inlier orientation error [rad]');
%grid
box on


subplot(2,1,2);
hold on
for i = 1:11
  s = stem(i, fmt_csal_t_errors(i));
  set(s, 'color', [c{i}(2,:)], 'markerfacecolor', [c{i}(2,:)], 'markeredgecolor', [c{i}(2,:)], 'linewidth', linewidth);
end

xlim([0 12])
ylim([0 0.12])
set(gca, 'XTick', [1 2 3 4 5 6 7 8 9 10 11]);
set(gca, 'YTick', [0 0.04 0.08 0.12])
set(gca, 'xticklabel', {'\\small $\\bm{p}_a^A$', '\\small $\\bm{p}_b^A$', '\\small $\\bm{p}_c^A$', '\\small $\\bm{p}_d^A$', '\\small $\\bm{p}_e^A$', '\\small $\\bm{p}_f^A$', '\\small $\\bm{p}_g^A$', '\\small $\\bm{p}_h^A$', '\\small $\\bm{p}_i^A$', '\\small $\\bm{p}_j^A$', '\\small $\\bm{p}_k^A$' });
set(gca, 'yticklabel', {'\\small $0.0$', '\\small $0.04$','\\small $0.08$','\\small $0.12$'});
set(gca, 'ylabel', 'PGL-FMIC');
set(gca, 'xlabel', 'Σημαίνον στάσης');
%grid
box on

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



if (store)
  img_file = strcat('/home/li9i/catkin_ws/src/relief_fmt_global_localisation/experiments_logs/evaluation_scripts_phd/figures/csal_orientation_errors.eps');
  drawnow ("epslatex", img_file, false);
end
