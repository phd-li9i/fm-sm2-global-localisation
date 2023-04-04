clear all
close all

store_outliers = 1;

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

    fmt_csal_outliers_row = [fmt_csal_outliers_row, fmt_o];
    csm_csal_outliers_row = [csm_csal_outliers_row, csm_o];

  end
  fmt_csal_outliers = [fmt_csal_outliers; fmt_csal_outliers_row];
  csm_csal_outliers = [csm_csal_outliers; csm_csal_outliers_row];

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h = figure(3);
set(h,'position',[1 1 250 150]);
hold on;
subplot(2,1,1);
h1 = bar(fmt_csal_outliers*100/5);
set (h1(1), "facecolor", [252,141,89]/255);

set(gca, 'XTick', [1 2 3 4 5 6 7 8 9 10 11]);
%set(gca, 'xticklabel', {'$\\bm{p}_a^H$', '$\\bm{p}_b^H$', '$\\bm{p}_c^H$', '$\\bm{p}_d^H$', '$\\bm{p}_e^H$', '$\\bm{p}_f^H$', '$\\bm{p}_g^H$', '$\\bm{p}_h^H$', '$\\bm{p}_i^H$', '$\\bm{p}_j^H$', '$\\bm{p}_k^H$' });
set(gca, 'xticklabel', []);
set(gca, 'YTick', [0 20 40 60 80 100])
set(gca, 'yticklabel', {'$0\\%$', '$20\\%$','$40\\%$','$60\\%$', '$80\\%$', '$100\\%$'});
set(gca, 'ylabel', 'PGL-FMIC');
title('Percentage of outliers');
ylim([0 100])
grid

subplot(2,1,2);
h2 = bar(csm_csal_outliers*100/5);
set (h2(1), "facecolor", [166,206,227]/255);

set(gca, 'XTick', [1 2 3 4 5 6 7 8 9 10 11]);
set(gca, 'xticklabel', {'$\\bm{p}_a^H$', '$\\bm{p}_b^H$', '$\\bm{p}_c^H$', '$\\bm{p}_d^H$', '$\\bm{p}_e^H$', '$\\bm{p}_f^H$', '$\\bm{p}_g^H$', '$\\bm{p}_h^H$', '$\\bm{p}_i^H$', '$\\bm{p}_j^H$', '$\\bm{p}_k^H$' });
set(gca, 'YTick', [0 20 40 60 80 100])
set(gca, 'yticklabel', {'$0\\%$', '$20\\%$','$40\\%$','$60\\%$', '$80\\%$', '$100\\%$'});
set(gca, 'ylabel', 'PL-ICP');
set(gca, 'xlabel', 'Identifier of tested pose in real environment CSAL');
ylim([0 100])
grid

if (store_outliers == 1)
  img_file = strcat('/media/ext/backup_files/AUTh/RELIEF/relief-fmt-global-localisation-paper/one_page/outliers_csal.eps');
  drawnow ("epslatex", img_file, false);
end
