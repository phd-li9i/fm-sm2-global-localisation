import os
import sys
import time

import scipy as sp
import numpy as np
import scipy.misc
#import matplotlib.pyplot as plt

import imreg_dft as ird
np.set_printoptions(threshold=sys.maxsize)

def compute_rotation_angle(format):

  basedir = "/home/cultureid_user0/catkin_ws/src/relief_fmt_global_localisation/tmp/"

  im0 = sp.misc.imread(os.path.join(basedir, 'real'+format), True)
  im1 = sp.misc.imread(os.path.join(basedir, 'virtual'+format), True)

  # order: 1 and 5 ok
  # 1 better than 0
  # 2 worse than 1, better than 0 (but ok when orientation = 0)
  # 3 same as 2 (worse when orientation = 0)
  # 4 almost perfect
  # 5 ok
  result = ird.similarity(im0, im1, numiter=1, order=3, filter_pcorr=0, measure_exec_time=False)

  return_list = []
  return_list.append(result["angle"])
  return_list.append(result["tvec"][0])
  return_list.append(result["tvec"][1])
  return_list.append(result["scale"])
  return_list.append(result["success"])

  return return_list
