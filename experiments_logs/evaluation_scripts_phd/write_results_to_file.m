function write_results_to_file(directory, mean_error, mean_time, outliers)

  fid=fopen(strcat(directory, 'results.txt'),'w');
  fprintf(fid, 'Mean error:         %f m\n', mean_error);
  fprintf(fid, 'Mean exec time:     %f sec (per particle)\n', mean_time);
  fprintf(fid, 'Number of outliers: %d\n', outliers);
  fclose(fid);
end
