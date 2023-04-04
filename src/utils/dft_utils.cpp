#include "utils/dft_utils.h"

/*******************************************************************************
 * @brief Calculates the X1 coefficient of the rays_diff input vector.
 * @param[in] rays_diff [const std::vector<double>&] The difference in range
 * between a world and a map scan.
 * @param[in] num_valid_rays [const int&] The number of valid rays (rays
 * whose difference in range is lower than a set threshold) between the
 * world and map scans.
 * @return [std::vector<double>] A vector of size two, of which the first
 * position holds the real part of the first DFT coefficient, and the
 * second the imaginary part of it.
 */
std::vector<double> DFTUtils::getFirstDFTCoefficient(
  const std::vector<double>& rays_diff)
{
  // A vector holding the coefficients of the DFT
  std::vector<double> dft_coeff_vector;

  // Do the DFT thing
  std::vector<double> dft_coeffs = performDFT(rays_diff);

  // The real and imaginary part of the first coefficient are
  // out[1] and out[N-1] respectively

  // The real part of the first coefficient
  double x1_r = dft_coeffs[1];

  // The imaginary part of the first coefficient
  double x1_i = dft_coeffs[rays_diff.size()-1];

  // Is x1_r finite?
  if (std::isfinite(x1_r))
    dft_coeff_vector.push_back(x1_r);
  else
    dft_coeff_vector.push_back(0.0);

  // Is x1_i finite?
  if (std::isfinite(x1_i))
    dft_coeff_vector.push_back(x1_i);
  else
    dft_coeff_vector.push_back(0.0);


  return dft_coeff_vector;
}


/*******************************************************************************
 * @brief Performs DFT in a vector of doubles via fftw. Returns the DFT
 * coefficients vector in the order described in
 * http://www.fftw.org/fftw3_doc/Real_002dto_002dReal-Transform-Kinds.html#Real_002dto_002dReal-Transform-Kinds.
 * @param[in] rays_diff [const std::vector<double>&] The vector of differences
 * in range between a world scan and a map scan.
 * @return [std::vector<double>] The vector's DFT coefficients.
 */
std::vector<double> DFTUtils::performDFT(const std::vector<double>& rays_diff)
{
  double* in;
  double* out;

  const int num_rays = rays_diff.size();

  in = (double*) fftw_malloc(num_rays * sizeof(double));
  out = (double*) fftw_malloc(num_rays * sizeof(double));

  // Transfer the input vector to a structure preferred by fftw
  for (unsigned int i = 0; i < num_rays; i++)
    in[i] = rays_diff[i];

  // Create plan
  fftw_plan p = fftw_plan_r2r_1d(num_rays, in, out, FFTW_R2HC, FFTW_ESTIMATE);

  // Execute plan
  fftw_execute(p);

  // Store all DFT coefficients
  std::vector<double> dft_coeff_vector;
  for (unsigned int i = 0; i < num_rays; i++)
    dft_coeff_vector.push_back(out[i]);

  // Free memory
  fftw_destroy_plan(p);
  fftw_free(in);
  fftw_free(out);

  return dft_coeff_vector;
}
