make_thresholded <- function(predicted_raster, thresholds) {
  thresh_matrix <- matrix(nrow = 3, ncol = 3)
  thresh_matrix[1, ] <- c(0, thresholds[1], 1)
  thresh_matrix[2, ] <- c(thresholds[1], thresholds[2], 2)
  thresh_matrix[3, ] <- c(thresholds[2], 1, 3)
  
  thresholded_raster <- raster::reclassify(predicted_raster, 
                       thresh_matrix)
  
}
