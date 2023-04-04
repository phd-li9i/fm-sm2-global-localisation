#!/usr/bin/env python
import os
import sys
import datetime
from shutil import copyfile
import run_experiments

# ------------------------------------------------------------------------------
def run_batches():

  # Base files
  params_dir = "/home/li9i/catkin_ws/src/relief_fmt_global_localisation/configuration_files/"
  csm_params_file = params_dir + "pipeline_csm.yaml"

  # Switchable files
  csm_params_0 = params_dir + "pipeline_csm_0.yaml"
  csm_params_1 = params_dir + "pipeline_csm_1.yaml"
  csm_params_2 = params_dir + "pipeline_csm_2.yaml"
  csm_params_3 = params_dir + "pipeline_csm_3.yaml"
  csm_params_4 = params_dir + "pipeline_csm_4.yaml"
  csm_params_5 = params_dir + "pipeline_csm_5.yaml"
  csm_params_6 = params_dir + "pipeline_csm_6.yaml"
  csm_params_7 = params_dir + "pipeline_csm_7.yaml"
  csm_params_8 = params_dir + "pipeline_csm_8.yaml"
  csm_params_9 = params_dir + "pipeline_csm_9.yaml"
  csm_params_10 = params_dir + "pipeline_csm_10.yaml"
  csm_params_11 = params_dir + "pipeline_csm_11.yaml"
  csm_params_12 = params_dir + "pipeline_csm_12.yaml"
  csm_params_13 = params_dir + "pipeline_csm_13.yaml"
  csm_params_14 = params_dir + "pipeline_csm_14.yaml"

  csm_params = []
  csm_params.append(csm_params_0)
  csm_params.append(csm_params_1)
  csm_params.append(csm_params_2)
  csm_params.append(csm_params_3)
  csm_params.append(csm_params_4)
  csm_params.append(csm_params_5)
  csm_params.append(csm_params_6)
  csm_params.append(csm_params_7)
  csm_params.append(csm_params_8)
  csm_params.append(csm_params_9)
  csm_params.append(csm_params_10)
  csm_params.append(csm_params_11)
  csm_params.append(csm_params_12)
  csm_params.append(csm_params_13)
  csm_params.append(csm_params_14)



  for i in range(len(csm_params)):
    copyfile(csm_params[i], csm_params_file)
    run_experiments.run_experiments(1)

# ------------------------------------------------------------------------------
def main():

  run_batches()


# ------------------------------------------------------------------------------
if __name__== "__main__":
  main()
