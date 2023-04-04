clear all
close all
pkg load io
pkg load geometry

graphics_toolkit("gnuplot")
warning("off","print:missing_fig2dev");
warning("off","print:missing_epstool");


% Load map
map = "corridor";
map_str = strcat('/home/li9i/catkin_ws/src/relief_fmt_global_localisation/experiments_logs/evaluation_scripts_phd/maps/', map);
ms = csv2cell(map_str);

map_x = ms(2:end, 1);
map_y = ms(2:end, 2);

map_x = cell2mat(map_x);
map_y = cell2mat(map_y);

M = [map_x map_y];


h = figure(1,'position',[1 1 200 200]);
hold on
plot(M(:,1), M(:,2), 'o', "markersize", 1, 'color', 'k');

axis([2 15 3 15])

pose_1 = [11.56 12.2 0];
pose_2 = [4.56 10.2 0];
pose_3 = [7.56 11.2 pi/4];

tip_1 = pose_1(1,1:2) + [cos(pose_1(1,3)) sin(pose_1(1,3))];
tip_2 = pose_2(1,1:2) + [cos(pose_2(1,3)) sin(pose_2(1,3))];
tip_3 = pose_3(1,1:2) + [cos(pose_3(1,3)) sin(pose_3(1,3))];

arrow_1 = [pose_1(1,1:2) tip_1];
h_1 = drawArrow (arrow_1, 1, 0.5 , 0.1);
arrayfun(@(x,y)set(x,'color',y), [h_1.body; h_1.wing(:)], 'k',1,1);

arrow_2 = [pose_2(1,1:2) tip_2];
h_2 = drawArrow (arrow_2, 1, 0.5 , 0.1);
arrayfun(@(x,y)set(x,'color',y), [h_2.body; h_2.wing(:)], 'k',1,1);

arrow_3 = [pose_3(1,1:2) tip_3];
h_3 = drawArrow (arrow_3, 1, 0.5 , 0.1);
arrayfun(@(x,y)set(x,'color',y), [h_3.body; h_3.wing(:)], 'k',1,1);

axis equal
x = xlabel("x [m]");
y = ylabel("y [m]");

axis equal

img_file = strcat(pwd, '/figures/corridor_motivation.eps');
drawnow ("epslatex", img_file, false)
