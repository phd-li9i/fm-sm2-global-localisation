clear all
pkg load io
pkg load statistics

graphics_toolkit("gnuplot")
warning("off","print:missing_fig2dev");
warning("off","print:missing_epstool");

% This is where ALL experiments are stored at
all_experiments_dir = '/home/li9i/catkin_ws/src/relief_fmt_global_localisation/experiments_logs/';
experiments_only_dir = strcat(all_experiments_dir, 'N/');

% Our scripts reside here
addpath(strcat(all_experiments_dir, 'evaluation_scripts/'));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% What directory to evaluate under `experiments_only_dir`
% (could be a parent directory to many experiments)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
what_dir = 'vault/fmt/Centroid-based/dirtrack/pose_6/noise_s=0.05';

evaluate_here_dir = strcat(experiments_only_dir, what_dir, '/');

% Goto the directory under which some (maybe one, maybe more, maybe none)
% experiments are and recursively search in that directory and all its
% subdirectories for the backup-ed source code file
cd(evaluate_here_dir)
what_dirs = glob2('**.cpp');

% `what_dirs` holds relative paths from `evaluate_here_dir` of the .cpp file
% INCLUDING THE SUFFIX ____.cpp
for i = 1:size(what_dirs,1)
  % one cpp file location. find the last index of a slash '/' and cut the
  % suffix out
  cpp_file = what_dirs{i};
  slash_idx = strfind (cpp_file, '/');

  % If we are in the directory of one experiment, only the .cpp file is
  % returned from glob2. So there is nothing to be appended to the prefix
  % absolute path. If however there are subdirectories in the `evaluate_here`
  % directory, extract them by cutting down the .cpp suffix after the final
  % slash
  if size(slash_idx,1) == 0
    rel_one_experiment_dir = '';
  else
    rel_one_experiment_dir = substr(cpp_file, 1, slash_idx(end));
  end

  % The absolute path of the directory that holds one experiment
  one_experiment_dir = strcat(evaluate_here_dir, rel_one_experiment_dir);

  % Extract mean errors and execution times
  [mean_error mean_exec_time outliers] = evaluate_one_experiment(one_experiment_dir);

  printf('Mean error     = %f m\n', mean_error);
  printf('Mean exec time = %f s\n', mean_exec_time);

  % Store them to the same directory
  write_results_to_file(one_experiment_dir, mean_error, mean_exec_time, outliers);
end
