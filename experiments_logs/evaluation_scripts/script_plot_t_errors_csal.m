clear all
close all

store_errors = 1;


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


xaxis = 1:11;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h = figure(1);
set(h,'position',[1 1 250 150]);
subplot(2,1,1);
hold on
scatter(xaxis, fmt_csal_t_errors, 20, 'k', 'o');

set(gca, 'XTick', [1 2 3 4 5 6 7 8 9 10 11]);
%set(gca, 'xticklabel', {'$\\bm{p}_a^H$', '$\\bm{p}_b^H$', '$\\bm{p}_c^H$', '$\\bm{p}_d^H$', '$\\bm{p}_e^H$', '$\\bm{p}_f^H$', '$\\bm{p}_g^H$', '$\\bm{p}_h^H$', '$\\bm{p}_i^H$', '$\\bm{p}_j^H$', '$\\bm{p}_k^H$' });
set(gca, 'xticklabel', []);
%set(gca, 'YTick', [0 25 50 75 100])
%set(gca, 'yticklabel', {'$0\\%$', '$25\\%$','$50\\%$','$75\\%$', '$100\\%$'});
set(gca, 'ylabel', 'PGL-FMIC');
title('Mean inlier orientation error [rad]');
grid

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(2,1,2);
hold on
scatter([1:7], csm_csal_t_errors(1:7), 20, 'k', 's');
scatter([9], csm_csal_t_errors(9), 20, 'k', 's');
scatter([11], csm_csal_t_errors(11), 20, 'k', 's');


set(gca, 'XTick', [1 2 3 4 5 6 7 8 9 10 11]);
%set(gca, 'yticklabel', {'$0$', '$34$', '$41$', '$59$', '$94$', '$100$'});
set(gca, 'xticklabel', {'$\\bm{p}_a^A$', '$\\bm{p}_b^A$', '$\\bm{p}_c^A$', '$\\bm{p}_d^A$', '$\\bm{p}_e^A$', '$\\bm{p}_f^A$', '$\\bm{p}_g^A$', '$\\bm{p}_h^A$', '$\\bm{p}_i^A$', '$\\bm{p}_j^A$', '$\\bm{p}_k^A$' });
%set(gca, 'YTick', [0 25 50 75 100])
%set(gca, 'yticklabel', {'$0\\%$', '$25\\%$','$50\\%$','$75\\%$', '$100\\%$'});
set(gca, 'ylabel', 'PL-ICP');
set(gca, 'xlabel', 'Identifier of tested pose in real environment CSAL');
grid


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%xaxis = [1 2 3];

%h = figure(1);
%set(h,'position',[1 1 250 650]);
%title('Mean inlier location error [m]');



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%plot(xaxis, fmt_csal_xy_errors(1,:), 'marker', '+', 'color', 'k');
%plot(xaxis, fmt_csal_xy_errors(2,:), 'marker', 'o', 'color', 'k');
%plot(xaxis, fmt_csal_xy_errors(3,:), 'marker', '*', 'color', 'k');
%plot(xaxis, fmt_csal_xy_errors(4,:), 'marker', '.', 'color', 'k');
%plot(xaxis, fmt_csal_xy_errors(5,:), 'marker', 'x', 'color', 'k');
%plot(xaxis, fmt_csal_xy_errors(6,:), 'marker', 's', 'color', 'k');
%plot(xaxis, fmt_csal_xy_errors(7,:), 'marker', 'd', 'color', 'k');
%plot(xaxis, fmt_csal_xy_errors(8,:), 'marker', '^', 'color', 'k');
%plot(xaxis, fmt_csal_xy_errors(9,:), 'marker', 'v', 'color', 'k');
%plot(xaxis, fmt_csal_xy_errors(10,:), 'marker', '>', 'color', 'k');
%plot(xaxis, fmt_csal_xy_errors(11,:), 'marker', '<', 'color', 'k');

%xlim([0.5 3.5]);
%set(gca, 'XTick', [1 2 3]);
%set(gca, 'xticklabel', {'$0.01$', '$0.02$', '$0.05$'});
%set(gca, 'YTick', [0.0 0.05 0.1 0.15 0.2 0.25]);
%set(gca, 'yticklabel', {'$0.0$', '$0.05$', '$0.10$', '$0.15$', '$0.20$', '$0.25$'});
%set(gca, 'ylabel', 'csal');

%box off;
%set(gca,'xticklabel',[])

%subplot(5,2,4)
%hold on;
%plot(xaxis, csm_csal_xy_errors(1,:), 'marker', '+', 'color', 'k');
%plot(xaxis, csm_csal_xy_errors(2,:), 'marker', 'o', 'color', 'k');
%plot(xaxis, csm_csal_xy_errors(3,:), 'marker', '*', 'color', 'k');
%plot(xaxis, csm_csal_xy_errors(4,:), 'marker', '.', 'color', 'k');
%plot(xaxis, csm_csal_xy_errors(5,:), 'marker', 'x', 'color', 'k');
%plot(xaxis, csm_csal_xy_errors(6,:), 'marker', 's', 'color', 'k');
%plot(xaxis, csm_csal_xy_errors(7,:), 'marker', 'd', 'color', 'k');
%plot(xaxis, csm_csal_xy_errors(8,:), 'marker', '^', 'color', 'k');
%plot(xaxis, csm_csal_xy_errors(9,:), 'marker', 'v', 'color', 'k');
%plot(xaxis, csm_csal_xy_errors(10,:), 'marker', '>', 'color', 'k');
%plot(xaxis, csm_csal_xy_errors(11,:), 'marker', '<', 'color', 'k');

%xlim([0.5 3.5]);
%set(gca, 'XTick', [1 2 3]);
%set(gca, 'xticklabel', {'$0.01$', '$0.02$', '$0.05$'});
%set(gca, 'YTick', [0.0 0.05 0.1 0.15 0.2 0.25]);
%set(gca, 'yticklabel', {'$0.0$', '$0.05$', '$0.10$', '$0.15$', '$0.20$', '$0.25$'});

%box off;
%set(gca,'xticklabel',[])






if (store_errors == 1)
  img_file = strcat('/media/ext/backup_files/AUTh/RELIEF/relief-fmt-global-localisation-paper/one_page/orientation_errors_csal.eps');
  drawnow ("epslatex", img_file, false);
end
