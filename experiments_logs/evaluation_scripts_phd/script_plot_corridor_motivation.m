clear all
close all
pkg load io
pkg load geometry

store = 1;

graphics_toolkit("gnuplot")
warning("off","print:missing_fig2dev");
warning("off","print:missing_epstool");

maps = {"corridor"};


figure_counter = 0;
for m = 1:size(maps,2)
  figure_counter = figure_counter + 1;
  h = figure(figure_counter);
  hold on


  % Load map
  map = maps(m){1};
  map_str = strcat('/media/ext/backup_files/AUTh/RELIEF/relief-fmt-global-localisation-paper/figures/maps/', map);
  ms = csv2cell(map_str);

  map_x = ms(2:end, 1);
  map_y = ms(2:end, 2);

  map_x = cell2mat(map_x);
  map_y = cell2mat(map_y);

  M = [map_x map_y];

  % Corridor-specific %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  if strcmp(map, 'corridor')

    plot(M(:,1), M(:,2), 'o', "markersize", 1, 'color', 'k');

    axis([2 15 3 15])

    pose_a = [11.56 12.2];
    pose_b = [4.56, 10.2];
    pose_c = [7.56, 11.2];
    tip_a = pose_a + [0.5 0];
    tip_b = pose_b + [0.5 0];
    tip_c = pose_c + [0.5 0.5];
  endif

  axis equal

  % Print pose as arrow
  arrow_a = [pose_a tip_a];
  arrow_b = [pose_b tip_b];
  arrow_c = [pose_c tip_c];

  h_a = drawArrow (arrow_a, 1, 0.5 , 0.1);
  h_b = drawArrow (arrow_b, 1, 0.5 , 0.1);
  h_c = drawArrow (arrow_c, 1, 0.5 , 0.1);

  arrayfun(@(x,y)set(x,'color',y), [h_a.body; h_a.wing(:)], 'k',1,1);
  arrayfun(@(x,y)set(x,'color',y), [h_b.body; h_b.wing(:)], 'k',1,1);
  arrayfun(@(x,y)set(x,'color',y), [h_c.body; h_c.wing(:)], 'k',1,1);

  if strcmp(map, 'corridor')
    x = xlabel("x [m]");
    y = ylabel("y [m]");
    axis equal

    set(h,'position',[1 1 200 200]);
  endif

  if (store == 1)
    img_file = strcat('/media/ext/backup_files/AUTh/RELIEF/relief-fmt-global-localisation-paper/figures/maps/', map, '.eps');
    drawnow ("epslatex", img_file, false)
  endif

endfor
