#ifndef DFT_UTILS_H
#define DFT_UTILS_H

#include <iostream>
#include <stdlib.h>
#include <time.h>
#include <cmath>
#include <vector>
#include <fftw3.h>

class DFTUtils
{
  public:

  /*****************************************************************************
   * @brief Calculates the X1 coefficient of the rays_diff input vector.
   * @param[in] rays_diff [const std::vector<double>&] The difference in range
   * between a world and a map scan.
   * @return [std::vector<double>] A vector of size two, of which the first
   * position holds the real part of the first DFT coefficient, and the
   * second the imaginary part of it.
   */
    static std::vector<double> getFirstDFTCoefficient(
      const std::vector<double>& rays_diff);

  /*****************************************************************************
   * @brief Performs DFT in a vector of doubles via fftw. Returns the DFT
   * coefficients vector in the order described in
   * http://www.fftw.org/fftw3_doc/Real_002dto_002dReal-Transform-Kinds.html#Real_002dto_002dReal-Transform-Kinds.
   * @param[in] rays_diff [const std::vector<double>&] The vector of differences
   * in range between a world scan and a map scan.
   * @return [std::vector<double>] The vector's DFT coefficients.
   */
    static std::vector<double> performDFT(const std::vector<double>& rays_diff);
};

#endif // DFT_UTILS_H
