get_future_data <- function(rcp = 26, yr = 50, oldlayers = macawlayers) {
  
  newdatapath <- paste0('data/climate_predictions/raw/rcp', rcp, 
                        '/20', yr, '/rcp', rcp, '_', yr, '_')
  
  temp = oldlayers$temp
  precip = oldlayers$precip
  land = oldlayers$land
  rm(oldlayers)
  #covariate maps
  
  tempnew<-raster(paste0(newdatapath, 't.tif'))                #temperature layer, from bioclim
  precipnew<-raster(paste0(newdatapath, 'p.tif'))             #mean precip (mm), from bioclim     
  
  
  ##set projection making sure all have the same projection
  projection<-proj4string(land) #defining projection for layers dase on ecosystem file
  proj4string(tempnew)<-projection
  proj4string(precipnew)<-projection
  
  precipnew <- setExtent(precipnew, extent(precip), keepres=F, snap=TRUE)
  tempnew <- setExtent(tempnew, extent(temp), keepres = F, snap = T)
  
  rm(temp)
  rm(precip)
  
  #resample to align layers with resolution
  #land<-resample(x=land, y=elev, "ngb")            #nearest neighbor (categorical)
  precipnew<-resample(x=precipnew, y=land, "bilinear")     #for continuous data
  tempnew<-resample(x=tempnew, y=land, "bilinear")
  
  #crop to same extent
  precipnew <- mask(precipnew, land)
  tempnew <- mask(tempnew, land)
  
  compareRaster(precipnew,tempnew, land)
  
  ##This resampling and masking aligns the raster data. 
  
  ###We can now create a raster stack of the environmental covariates
  
  macawlayers<-stack(precipnew,tempnew,land)        #make a multilayered file for sampling and mapping
  names(macawlayers) <- c('precip', 'temp', 'land')
  return(macawlayers)
}