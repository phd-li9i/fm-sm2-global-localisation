function create_real_range_image(dim, format)
  graphics_toolkit gnuplot;

  real_scan;

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
  print(strcat('/home/li9i/catkin_ws/src/relief_fmt_global_localisation/tmp/real', format), res);

endfunction
