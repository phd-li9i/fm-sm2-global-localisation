function create_range_images(dim, format)
  graphics_toolkit gnuplot;

  scan_dump;

  res = strcat("-S", num2str(dim), ",", num2str(dim));
  plot_type = 1; % 0 for scatter, 1 for lines

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  figure(1, 'visible','off')
  if (plot_type == 1)
    hr = plot(rx,ry, 'color', 'k');
  end

  if (plot_type == 0)
    hr = scatter(rx,ry,1, "k", '.');
  end

  axis equal
  axis off
  print(strcat('/home/cultureid_user0/catkin_ws/src/relief_fmt_global_localisation/tmp/real', format), res);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  figure(2, 'visible','off')
  if (plot_type == 1)
    hv = plot(vx,vy, 'color', 'k');
  end

  if (plot_type == 0)
    hv = scatter(vx,vy,1, "k", '.');
  end

  axis equal
  axis off
  print(strcat('/home/cultureid_user0/catkin_ws/src/relief_fmt_global_localisation/tmp/virtual', format), res);

endfunction
