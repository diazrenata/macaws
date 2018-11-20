prep_present_layers <- function(){

#################################################
#viewing GIS data
#################################################

#covariate maps

elev<-raster("data/present/raw/dem_bz_aster")                 #elevation layer
temp<-raster("data/present/raw/bz_bio_temp")                #temperature layer, from bioclim
precip<-raster("data/present/raw/bz_bio_precip")             #mean precip (mm), from bioclim     
land<-raster("data/present/raw/ecosystems")
land <- as.factor(land)
ecosy<-readOGR("data/present/raw/Ecosystems_Dis_2011.shp") ##for shape files, from package rgdal, ecosystem layer, categorical
macaws<-readOGR("data/present/raw/Macaws_Combined.shp")

##set projection making sure all have the same projection
projection<-proj4string(ecosy) #defining projection for layers dase on ecosystem file
proj4string(elev)<-projection #set projection
proj4string(temp)<-projection
proj4string(precip)<-projection
proj4string(land) <- projection

#resample to align layers with resolution
land<-resample(x=land, y=elev, "ngb")            #nearest neighbor (categorical)
elev<-resample(x=elev, y=land, "bilinear")
precip<-resample(x=precip, y=elev, "bilinear")     #for continuous data
temp<-resample(x=temp, y=land, "bilinear")

#crop to same extent
elev <- mask(elev, land)
precip <- mask(precip, land)
temp <- mask(temp, land)

if(compareRaster(precip,temp, elev, land)) {

##This resampling and masking aligns the raster data. 

###We can now create a raster stack of the environmental covariates

macawlayers<-stack(precip,temp, elev, land)        #make a multilayered file for sampling and mapping

names(macawlayers)<-c("precip","temp","elev","land")

##plot correlations among covariates

pairs(macawlayers, maxpixels=1000)                             #maxpixels sets upper limit on sampling raster
plot(macawlayers)

##Because elevation and temperature are highly correlated (0.95), we only consider temperature in further modeling. We can use the dropLayer function to remove that layer from the raster stack:

macawlayers<-dropLayer(macawlayers, 3)

save(macawlayers, land, precip, temp, file = 'data/present/ready/macawlayers.Rdata')

return("SUCCESS")
}
return("ERROR")
}