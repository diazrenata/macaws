report_summary_stats <- function(thresholded_raster) {
  
  raster_vals <- vector(length = ncell(thresholded_raster))
for(i in 1:length(raster_vals)) {
  raster_vals[i] <- thresholded_raster[i]
}
  
}