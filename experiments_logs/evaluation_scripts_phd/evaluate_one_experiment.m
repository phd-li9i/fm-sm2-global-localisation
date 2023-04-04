function [mean_location_error mean_orientation_error mean_exec_time outliers] = evaluate_one_experiment(directory)

  disp('---------------------------------------------------------------------');
  disp(strcat('Evaluating directory ', directory));

  [dir_list] = dir(directory);

  % Access the number of particles used in this experiment for averaging the
  % execution times
  np = cell2mat({csv2cell(strcat(directory, 'num_particles'))});
  num_particles = cell2mat(np(2,1));

  outlier_dirs = {};
  times = [];
  iters = 0;
  xy_errors = [];
  t_errors = [];
  outliers = 0;
  for i = 3:size(dir_list)
    if dir_list(i).isdir
      iters = iters + 1;
      cd(strcat(directory, dir_list(i).name));
      dir_list(i).name

      gt = cell2mat({csv2cell('ground_truth')});
      gp = cell2mat({csv2cell('global_pose')});
      et = cell2mat({csv2cell('execution_time')});

      dx = (cell2mat(gt(2,1)) - cell2mat(gp(2,1)))^2;
      dy = (cell2mat(gt(2,2)) - cell2mat(gp(2,2)))^2;
      dt = (cell2mat(gt(2,3)) - cell2mat(gp(2,3)))^2;

      %es = dx + dy + dt;
      es = dx + dy;

      if sqrt(es) > 1.0
        outliers = outliers+1;
        outlier_dirs = [outlier_dirs; strcat(directory, dir_list(i).name)];
        continue;
      end

      xy_errors = [xy_errors; sqrt(es)];
      t_errors = [t_errors; sqrt(dt)];

      sec = cell2mat(et(2,1));
      nsec = cell2mat(et(2,2));
      times = [times; sec + 10^(-9)*nsec];

    end %-- end if

  end %-- end for

  %plot(errors, 'o')

  mean_location_error = mean(xy_errors);
  mean_orientation_error = mean(t_errors);
  mean_exec_time = mean(times)/num_particles;

  printf('Found %d iterations\n', iters);
  printf('Mean xy error  = %f m\n', mean(xy_errors));
  printf('Mean dt error  = %f rad\n', mean(t_errors));
  printf('Number of outliers: %d\n', outliers);
  printf('Outlier directories\n');
  for i = 1:size(outlier_dirs)
    printf('%s\n', outlier_dirs{i})
  end

end %-- end function evaluate_one_experiment
