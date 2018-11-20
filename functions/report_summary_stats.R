report_summary_stats <- function(thresholded_raster) {
  
  total_cells <- as.numeric(length(which(!is.na(thresholded_raster@data@values))))
  n_lows <- as.numeric(length(which(thresholded_raster@data@values == 1)))
  n_meds <- as.numeric(length(which(thresholded_raster@data@values == 2)))
  n_his <- as.numeric(length(which(thresholded_raster@data@values == 3)))
  
  summary_vals <- c(total_cells, n_lows, n_meds, n_his)
  return(summary_vals)
  
}

