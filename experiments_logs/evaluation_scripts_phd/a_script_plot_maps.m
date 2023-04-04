clear all
close all
pkg load io
pkg load geometry

store = 1;

graphics_toolkit("gnuplot")
warning("off","print:missing_fig2dev");
warning("off","print:missing_epstool");

maps = {"corridor", "home", "warehouse", "willowgarage", "dirtrack", "csal"};
%maps = {"dirtrack"};
%maps = {"csal"};

colours = colours2();


figure_counter = 0;
for m = 1:size(maps,2)
  figure_counter = figure_counter + 1;
  f = figure(figure_counter);
  hold on


  % Load map
  map = maps(m){1};
  map_str = strcat('/home/li9i/catkin_ws/src/relief_fmt_global_localisation/experiments_logs/evaluation_scripts_phd/maps/', map);
  ms = csv2cell(map_str);

  map_x = ms(2:end, 1);
  map_y = ms(2:end, 2);

  map_x = cell2mat(map_x);
  map_y = cell2mat(map_y);

  M = [map_x map_y];

  h = {};

  if strcmp(map, 'csal')

    plot(M(:,1), M(:,2), 'o', "markersize", 1, 'color', 'k');

    %axis([-1 13 -1 29])

    pose_1 = [15.4721268025, 15.1977831686, -0.095];
    pose_2 = [16.7216527641, 14.8115392043, -1.67];
    pose_3 = [12.6718948032, 13.9136193677, 2.982];
    pose_4 = [11.3033797346, 13.1062780437, 1.083];
    pose_5 = [11.7128740531, 11.8384089383, -1.700];
    pose_6 = [12.1218809427, 9.80543750581, -2.088];
    pose_7 = [12.4712945723, 8.89038521273, -1.149];
    pose_8 = [13.2214581898, 8.08269807369, 0.105];
    pose_9 = [14.3233989244, 8.31691540978, 0.652];
    pose_10 = [16.2206537931, 9.01636418709, 0.470];
    pose_11 = [13.5679147405, 10.9915395271, -2.637];


    tip_1 = pose_1(1,1:2) + [cos(pose_1(1,3)) sin(pose_1(1,3))];
    tip_2 = pose_2(1,1:2) + [cos(pose_2(1,3)) sin(pose_2(1,3))];
    tip_3 = pose_3(1,1:2) + [cos(pose_3(1,3)) sin(pose_3(1,3))];
    tip_4 = pose_4(1,1:2) + [cos(pose_4(1,3)) sin(pose_4(1,3))];
    tip_5 = pose_5(1,1:2) + [cos(pose_5(1,3)) sin(pose_5(1,3))];
    tip_6 = pose_6(1,1:2) + [cos(pose_6(1,3)) sin(pose_6(1,3))];
    tip_7 = pose_7(1,1:2) + [cos(pose_7(1,3)) sin(pose_7(1,3))];
    tip_8 = pose_8(1,1:2) + [cos(pose_8(1,3)) sin(pose_8(1,3))];
    tip_9 = pose_9(1,1:2) + [cos(pose_9(1,3)) sin(pose_9(1,3))];
    tip_10 = pose_10(1,1:2) + [cos(pose_10(1,3)) sin(pose_10(1,3))];
    tip_11 = pose_11(1,1:2) + [cos(pose_11(1,3)) sin(pose_11(1,3))];

    arrow_1 = [pose_1(1,1:2) tip_1];
    h{1} = drawArrow (arrow_1, 1, 0.5 , 0.1);

    arrow_2 = [pose_2(1,1:2) tip_2];
    h{2} = drawArrow (arrow_2, 1, 0.5 , 0.1);

    arrow_3 = [pose_3(1,1:2) tip_3];
    h{3} = drawArrow (arrow_3, 1, 0.5 , 0.1);

    arrow_4 = [pose_4(1,1:2) tip_4];
    h{4} = drawArrow (arrow_4, 1, 0.5 , 0.1);

    arrow_5 = [pose_5(1,1:2) tip_5];
    h{5} = drawArrow (arrow_5, 1, 0.5 , 0.1);

    arrow_6 = [pose_6(1,1:2) tip_6];
    h{6} = drawArrow (arrow_6, 1, 0.5 , 0.1);

    arrow_7 = [pose_7(1,1:2) tip_7];
    h{7} = drawArrow (arrow_7, 1, 0.5 , 0.1);

    arrow_8 = [pose_8(1,1:2) tip_8];
    h{8} = drawArrow (arrow_8, 1, 0.5 , 0.1);

    arrow_9 = [pose_9(1,1:2) tip_9];
    h{9} = drawArrow (arrow_9, 1, 0.5 , 0.1);

    arrow_10 = [pose_10(1,1:2) tip_10];
    h{10} = drawArrow (arrow_10, 1, 0.5 , 0.1);

    arrow_11 = [pose_11(1,1:2) tip_11];
    h{11} = drawArrow (arrow_11, 1, 0.5 , 0.1);


    axis equal
    x = xlabel("$x$ [m]");
    y = ylabel("$y$ [m]");
    set(f,'position',[1 1 200 200]);
  endif


  if strcmp(map, 'dirtrack')

    plot(M(:,1), M(:,2), 'o', "markersize", 1, 'color', 'k');

    axis([-1 13 -1 29])

    pose_1 = [3.34 17.19 -0.082];
    pose_2 = [3.34 26.19 -0.78];
    pose_3 = [8.34 25.19 0.90];
    pose_4 = [3.34 10.19 -2.97];
    pose_5 = [7.34 8.19 -1.93];
    pose_6 = [7.34 1.19 0.58];
    pose_7 = [8.34 18.19 -2.02];


    tip_1 = pose_1(1,1:2) + [cos(pose_1(1,3)) sin(pose_1(1,3))];
    tip_2 = pose_2(1,1:2) + [cos(pose_2(1,3)) sin(pose_2(1,3))];
    tip_3 = pose_3(1,1:2) + [cos(pose_3(1,3)) sin(pose_3(1,3))];
    tip_4 = pose_4(1,1:2) + [cos(pose_4(1,3)) sin(pose_4(1,3))];
    tip_5 = pose_5(1,1:2) + [cos(pose_5(1,3)) sin(pose_5(1,3))];
    tip_6 = pose_6(1,1:2) + [cos(pose_6(1,3)) sin(pose_6(1,3))];
    tip_7 = pose_7(1,1:2) + [cos(pose_7(1,3)) sin(pose_7(1,3))];

    arrow_1 = [pose_1(1,1:2) tip_1];
    h{1} = drawArrow (arrow_1, 1, 0.5 , 0.1);

    arrow_2 = [pose_2(1,1:2) tip_2];
    h{2} = drawArrow (arrow_2, 1, 0.5 , 0.1);

    arrow_3 = [pose_3(1,1:2) tip_3];
    h{3} = drawArrow (arrow_3, 1, 0.5 , 0.1);

    arrow_4 = [pose_4(1,1:2) tip_4];
    h{4} = drawArrow (arrow_4, 1, 0.5 , 0.1);

    arrow_5 = [pose_5(1,1:2) tip_5];
    h{5} = drawArrow (arrow_5, 1, 0.5 , 0.1);

    arrow_6 = [pose_6(1,1:2) tip_6];
    h{6} = drawArrow (arrow_6, 1, 0.5 , 0.1);

    arrow_7 = [pose_7(1,1:2) tip_7];
    h{7} = drawArrow (arrow_7, 1, 0.5 , 0.1);

    arrow_8 = [pose_8(1,1:2) tip_8];
    h{8} = drawArrow (arrow_8, 1, 0.5 , 0.1);

    arrow_9 = [pose_9(1,1:2) tip_9];
    h{9} = drawArrow (arrow_9, 1, 0.5 , 0.1);

    arrow_10 = [pose_10(1,1:2) tip_10];
    h{10} = drawArrow (arrow_10, 1, 0.5 , 0.1);

    arrow_11 = [pose_11(1,1:2) tip_11];
    h{11} = drawArrow (arrow_11, 1, 0.5 , 0.1);

    axis equal
    x = xlabel("$x$ [m]");
    y = ylabel("$y$ [m]");
    set(f,'position',[1 1 200 200]);
  endif

  if strcmp(map, 'corridor')

    plot(M(:,1), M(:,2), 'o', "markersize", 1, 'color', 'k');

    axis([2 15 3 15])

    pose_1 = [11.56 12.2 -0.78692];
    pose_2 = [12.06 8.2 2.012487];
    pose_3 = [8.06 9.2 -3.279462];

    tip_1 = pose_1(1,1:2) + [cos(pose_1(1,3)) sin(pose_1(1,3))];
    tip_2 = pose_2(1,1:2) + [cos(pose_2(1,3)) sin(pose_2(1,3))];
    tip_3 = pose_3(1,1:2) + [cos(pose_3(1,3)) sin(pose_3(1,3))];

    arrow_1 = [pose_1(1,1:2) tip_1];
    h{1} = drawArrow (arrow_1, 1, 0.5 , 0.1);

    arrow_2 = [pose_2(1,1:2) tip_2];
    h{2} = drawArrow (arrow_2, 1, 0.5 , 0.1);

    arrow_3 = [pose_3(1,1:2) tip_3];
    h{3} = drawArrow (arrow_3, 1, 0.5 , 0.1);

    axis equal
    x = xlabel("$x$ [m]");
    y = ylabel("$y$ [m]");
    set(f,'position',[1 1 200 200]);
  endif

  if strcmp(map, 'home')

    plot(M(:,1), M(:,2), 'o', "markersize", 1, 'color', 'k');

    axis([9.5 40 3 30])

    pose_1 = [14.44 24.04 0.065046];
    pose_2 = [17.84 24.84 1.329936];
    pose_3 = [15.0 14.68 0.679224];
    pose_4 = [22.0 14.22 -2.660285];
    pose_5 = [26.0 16.10 0.698761];
    pose_6 = [24.46 9.68 -0.492742];
    pose_7 = [18.26 11.02 -3.102612];
    pose_8 = [27.64 7.78 -0.142964];
    pose_9 = [24.28 21.44 2.408114];
    pose_10 = [29.0 28.64 0.305766];
    pose_11 = [31.0 12.2 -2.197832];

    tip_1 = pose_1(1,1:2) + [cos(pose_1(1,3)) sin(pose_1(1,3))];
    tip_2 = pose_2(1,1:2) + [cos(pose_2(1,3)) sin(pose_2(1,3))];
    tip_3 = pose_3(1,1:2) + [cos(pose_3(1,3)) sin(pose_3(1,3))];
    tip_4 = pose_4(1,1:2) + [cos(pose_4(1,3)) sin(pose_4(1,3))];
    tip_5 = pose_5(1,1:2) + [cos(pose_5(1,3)) sin(pose_5(1,3))];
    tip_6 = pose_6(1,1:2) + [cos(pose_6(1,3)) sin(pose_6(1,3))];
    tip_7 = pose_7(1,1:2) + [cos(pose_7(1,3)) sin(pose_7(1,3))];
    tip_8 = pose_8(1,1:2) + [cos(pose_8(1,3)) sin(pose_8(1,3))];
    tip_9 = pose_9(1,1:2) + [cos(pose_9(1,3)) sin(pose_9(1,3))];
    tip_10 = pose_10(1,1:2) + [cos(pose_10(1,3)) sin(pose_10(1,3))];
    tip_11 = pose_11(1,1:2) + [cos(pose_11(1,3)) sin(pose_11(1,3))];


    arrow_1 = [pose_1(1,1:2) tip_1];
    h{1} = drawArrow (arrow_1, 1, 0.5 , 0.1);

    arrow_2 = [pose_2(1,1:2) tip_2];
    h{2} = drawArrow (arrow_2, 1, 0.5 , 0.1);

    arrow_3 = [pose_3(1,1:2) tip_3];
    h{3} = drawArrow (arrow_3, 1, 0.5 , 0.1);

    arrow_4 = [pose_4(1,1:2) tip_4];
    h{4} = drawArrow (arrow_4, 1, 0.5 , 0.1);

    arrow_5 = [pose_5(1,1:2) tip_5];
    h{5} = drawArrow (arrow_5, 1, 0.5 , 0.1);

    arrow_6 = [pose_6(1,1:2) tip_6];
    h{6} = drawArrow (arrow_6, 1, 0.5 , 0.1);

    arrow_7 = [pose_7(1,1:2) tip_7];
    h{7} = drawArrow (arrow_7, 1, 0.5 , 0.1);

    arrow_8 = [pose_8(1,1:2) tip_8];
    h{8} = drawArrow (arrow_8, 1, 0.5 , 0.1);

    arrow_9 = [pose_9(1,1:2) tip_9];
    h{9} = drawArrow (arrow_9, 1, 0.5 , 0.1);

    arrow_10 = [pose_10(1,1:2) tip_10];
    h{10} = drawArrow (arrow_10, 1, 0.5 , 0.1);

    arrow_11 = [pose_11(1,1:2) tip_11];
    h{11} = drawArrow (arrow_11, 1, 0.5 , 0.1);

    axis equal
    x = xlabel("$x$ [m]");
    y = ylabel("$y$ [m]");
    set(f,'position',[1 1 200 200]);
  endif

  % Warehouse-specific %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  if strcmp(map, 'warehouse')

    % Rotate figure manually
    Rm = [0 -1; 1 0];
    Rp = [0 -1 0; 1 0 0; 0 0 1];
    M = Rm * M';
    M = M';

    M(:,1) = M(:,1) + 21.0;

    plot(M(:,1), M(:,2), 'o', "markersize", 1, 'color', 'k');
    axis([0 22 0 42])

    %axis([-5 27 -2 44])
    pose_1 = Rp * [8.08321 3.0156 -2.85278]';
    pose_2 = Rp * [35.16 15.25 -2.20061]';
    pose_3 = Rp * [38.81 2.35 1.36012]';
    pose_4 = Rp * [33.42 4.92 2.78921]';
    pose_5 = Rp * [17.08 8.75 2.83870]';
    pose_6 = Rp * [8.63 11.93 -1.26394]';
    pose_7 = Rp * [1.27 9.5 0.23935]';

    pose_1 = pose_1';
    pose_2 = pose_2';
    pose_3 = pose_3';
    pose_4 = pose_4';
    pose_5 = pose_5';
    pose_6 = pose_6';
    pose_7 = pose_7';

    pose_1(1,1) = pose_1(1,1) + 21;
    pose_2(1,1) = pose_2(1,1) + 21;
    pose_3(1,1) = pose_3(1,1) + 21;
    pose_4(1,1) = pose_4(1,1) + 21;
    pose_5(1,1) = pose_5(1,1) + 21;
    pose_6(1,1) = pose_6(1,1) + 21;
    pose_7(1,1) = pose_7(1,1) + 21;

    tip_1 = pose_1(1,1:2) + [cos(pose_1(1,3)) sin(pose_1(1,3))];
    tip_2 = pose_2(1,1:2) + [cos(pose_2(1,3)) sin(pose_2(1,3))];
    tip_3 = pose_3(1,1:2) + [cos(pose_3(1,3)) sin(pose_3(1,3))];
    tip_4 = pose_4(1,1:2) + [cos(pose_4(1,3)) sin(pose_4(1,3))];
    tip_5 = pose_5(1,1:2) + [cos(pose_5(1,3)) sin(pose_5(1,3))];
    tip_6 = pose_6(1,1:2) + [cos(pose_6(1,3)) sin(pose_6(1,3))];
    tip_7 = pose_7(1,1:2) + [cos(pose_7(1,3)) sin(pose_7(1,3))];


    arrow_1 = [pose_1(1,1:2) tip_1];
    h{1} = drawArrow (arrow_1, 1, 0.5 , 0.1);

    arrow_2 = [pose_2(1,1:2) tip_2];
    h{2} = drawArrow (arrow_2, 1, 0.5 , 0.1);

    arrow_3 = [pose_3(1,1:2) tip_3];
    h{3} = drawArrow (arrow_3, 1, 0.5 , 0.1);

    arrow_4 = [pose_4(1,1:2) tip_4];
    h{4} = drawArrow (arrow_4, 1, 0.5 , 0.1);

    arrow_5 = [pose_5(1,1:2) tip_5];
    h{5} = drawArrow (arrow_5, 1, 0.5 , 0.1);

    arrow_6 = [pose_6(1,1:2) tip_6];
    h{6} = drawArrow (arrow_6, 1, 0.5 , 0.1);

    arrow_7 = [pose_7(1,1:2) tip_7];
    h{7} = drawArrow (arrow_7, 1, 0.5 , 0.1);

    axis equal
    x = xlabel("$x$ [m]");
    y = ylabel("$y$ [m]");

    set(f,'position',[1 1 200 250]);
    %set (gca, 'xtick', [56 60 65 70])

  endif

  % Willowgarage-specific %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  if strcmp(map, 'willowgarage')

    plot(M(:,1), M(:,2), 'o', "markersize", 1, 'color', 'k');

    pose_1 = [77.56 37.48 1.87232];
    pose_2 = [67.85 66.90 0.12961];
    pose_3 = [81.0 57.6 -2.96939];
    pose_4 = [78.55, 78.35, -1.31];
    pose_5 = [84.0, 78.15, -1.31];
    pose_6 = [84.75, 56.65, 1.02];
    pose_7 = [51.15, 44.65, 1.29];
    pose_8 = [61.95, 37.8, -0.58];
    pose_9 = [62.2, 37.76, 1.23];
    pose_10 = [55.2, 37.76, 1.98];

    tip_1 = pose_1(1,1:2) + [cos(pose_1(1,3)) sin(pose_1(1,3))];
    tip_2 = pose_2(1,1:2) + [cos(pose_2(1,3)) sin(pose_2(1,3))];
    tip_3 = pose_3(1,1:2) + [cos(pose_3(1,3)) sin(pose_3(1,3))];
    tip_4 = pose_4(1,1:2) + [cos(pose_4(1,3)) sin(pose_4(1,3))];
    tip_5 = pose_5(1,1:2) + [cos(pose_5(1,3)) sin(pose_5(1,3))];
    tip_6 = pose_6(1,1:2) + [cos(pose_6(1,3)) sin(pose_6(1,3))];
    tip_7 = pose_7(1,1:2) + [cos(pose_7(1,3)) sin(pose_7(1,3))];
    tip_8 = pose_8(1,1:2) + [cos(pose_8(1,3)) sin(pose_8(1,3))];
    tip_9 = pose_9(1,1:2) + [cos(pose_9(1,3)) sin(pose_9(1,3))];
    tip_10 = pose_10(1,1:2) + [cos(pose_10(1,3)) sin(pose_10(1,3))];


    arrow_1 = [pose_1(1,1:2) tip_1];
    h{1} = drawArrow (arrow_1, 1, 0.5 , 0.1);

    arrow_2 = [pose_2(1,1:2) tip_2];
    h{2} = drawArrow (arrow_2, 1, 0.5 , 0.1);

    arrow_3 = [pose_3(1,1:2) tip_3];
    h{3} = drawArrow (arrow_3, 1, 0.5 , 0.1);

    arrow_4 = [pose_4(1,1:2) tip_4];
    h{4} = drawArrow (arrow_4, 1, 0.5 , 0.1);

    arrow_5 = [pose_5(1,1:2) tip_5];
    h{5} = drawArrow (arrow_5, 1, 0.5 , 0.1);

    arrow_6 = [pose_6(1,1:2) tip_6];
    h{6} = drawArrow (arrow_6, 1, 0.5 , 0.1);

    arrow_7 = [pose_7(1,1:2) tip_7];
    h{7} = drawArrow (arrow_7, 1, 0.5 , 0.1);

    arrow_8 = [pose_8(1,1:2) tip_8];
    h{8} = drawArrow (arrow_8, 1, 0.5 , 0.1);

    arrow_9 = [pose_9(1,1:2) tip_9];
    h{9} = drawArrow (arrow_9, 1, 0.5 , 0.1);

    arrow_10 = [pose_10(1,1:2) tip_10];
    h{10} = drawArrow (arrow_10, 1, 0.5 , 0.1);

    axis([45 90 35 81]);
    axis equal
    x = xlabel("$x$ [m]");
    y = ylabel("$y$ [m]");
    set(f,'position',[1 1 200 200]);
  endif

  axis equal

  for i = 1:length(h)
    set(h{i}.body, 'color', [colours{i}(2,:)]);
    set(h{i}.wing, 'color', [colours{i}(2,:)]);
    set(h{i}.body, 'linewidth', 3);
    set(h{i}.wing, 'linewidth', 3);
  end

  if (store == 1)
    img_file = strcat('/home/li9i/catkin_ws/src/relief_fmt_global_localisation/experiments_logs/evaluation_scripts_phd/figures/map_', map, '.eps');
    drawnow ("epslatex", img_file, false)
  endif

endfor
