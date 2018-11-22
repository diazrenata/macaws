library(dismo)
library(raster)
library(rJava)#for calling maxent from dismo package (need Java installed on computer)
library(rgdal) # for reading different types of GIS files
library(plyr)
library(ggplot2)
library(viridis)
library(ecospat)
source('functions/prep_present_data.R')

set.seed(5) 

# Load data
macaw.data<-read.csv(file="data/present/raw/Macaws_Sightings.csv", header=TRUE, sep=",")
macaw.data.xy<-as.matrix(macaw.data[,cbind("X_coordina","Y_coordina")]) #matrix of x (Eastings) and y (Northings) cordinates
colnames(macaw.data.xy)<-c("EASTING","NORTHING")

# Get present data
# prep_present_layers()

load('data/present/ready/macawlayers.Rdata')
rm(list = c('precip' ,'temp', 'land'))

####generate availability/background points using dismo

# source('functions/extract_cov.R')

# extract_cov(layers = macawlayers, xys = macaw.data.xy)

load('data/present/ready/covariates.Rdata')


# source('functions/get_training_test.R')
# get_train_test(macaw.data.xy = macaw.data.xy, back.xy = back.xy)

load('data/present/ready/train.Rdata')
source('functions/run_maxent_model.R')

#### beta = 1 ####
me_b1 <- run_maxent_model(betaval = 1)

save(me_b1, file = 'models/present/me_b1.Rdata')

fit_b1 <- fit_maxent_model(me_b1)

save(fit_b1, file = 'models/present/fit_b1.Rdata')

rm(me_b1)

load('data/present/ready/test.Rdata')
boyce_b1 <- boyce_maxent_model(fit = fit_b1)

save(boyce_b1, file = 'models/present/boyce_b1.Rdata' )

rm(list=c('fit_b1', 'boyce_b1'))


#### beta = 0.01 ####
me_b001 <- run_maxent_model(betaval = 0.01)

save(me_b001, file = 'models/present/me_b001.Rdata')

fit_b001 <- fit_maxent_model(me_b001)

save(fit_b001, file = 'models/present/fit_b001.Rdata')

rm(me_b001)

load('data/present/ready/test.Rdata')
boyce_b001 <- boyce_maxent_model(fit = fit_b001)

save(boyce_b001, file = 'models/present/boyce_b001.Rdata' )

rm(list=c('fit_b001', 'boyce_b001'))

#### beta = 0.1 ####
me_b01 <- run_maxent_model(betaval = 0.1)

save(me_b01, file = 'models/present/me_b01.Rdata')

fit_b01 <- fit_maxent_model(me_b01)

save(fit_b01, file = 'models/present/fit_b01.Rdata')

rm(me_b01)

load('data/present/ready/test.Rdata')
boyce_b01 <- boyce_maxent_model(fit = fit_b01)

save(boyce_b01, file = 'models/present/boyce_b01.Rdata' )

rm(list=c('fit_b01', 'boyce_b01'))

#### beta = 0.5 ####
me_b05 <- run_maxent_model(betaval = 0.5)

save(me_b05, file = 'models/present/me_b05.Rdata')

fit_b05 <- fit_maxent_model(me_b05)

save(fit_b05, file = 'models/present/fit_b05.Rdata')

rm(me_b05)

load('data/present/ready/test.Rdata')
boyce_b05 <- boyce_maxent_model(fit = fit_b05)

save(boyce_b05, file = 'models/present/boyce_b05.Rdata' )

rm(list=c('fit_b05', 'boyce_b05'))

#### beta = 0.9 ####
me_b09 <- run_maxent_model(betaval = 0.9)

save(me_b09, file = 'models/present/me_b09.Rdata')

fit_b09 <- fit_maxent_model(me_b09)

save(fit_b09, file = 'models/present/fit_b09.Rdata')

rm(me_b09)

load('data/present/ready/test.Rdata')
boyce_b09 <- boyce_maxent_model(fit = fit_b09)

save(boyce_b09, file = 'models/present/boyce_b09.Rdata' )

rm(list=c('fit_b09', 'boyce_b09'))

#### model selection ####
source('functions/extract_boyce.R')
boyces_list <- list.files(path='models/present/', pattern = 'boyce', full.names = T)

for (i in 1:length(boyces_list)) {
  load(file = boyces_list[i])
}

# find the highest boyce. 

extract_boyce(boyce_b001)
extract_boyce(boyce_b01)
extract_boyce(boyce_b05)
extract_boyce(boyce_b09)
extract_boyce(boyce_b1)
# highest boyce is b1 = .987.

rm(list = ls())

#### examine selected model ####
load(file = 'models/present/me_b09.Rdata')
load(file = 'models/present/me_b05.Rdata')
load(file = 'models/present/me_b01.Rdata')
load(file = 'models/present/me_b001.Rdata')
load(file = 'models/present/me_b1.Rdata')
response(me_b09, expand=0)
response(me_b05, expand=0)
response(me_b01, expand=0)
response(me_b001, expand=0)
response(me_b1, expand =0)

rm(list = c('me_b001', 'me_b01', 'me_b05', 'me_b09'))
#### make future predictions ####

load('data/present/ready/macawlayers.Rdata')
rm(list = c('precip' ,'temp', 'land'))

source('functions/get_future_data.R')

rcp26_2050_layers <- get_future_data(rcp = 26, yr = 50)
save(rcp26_2050_layers, file = "data/climate_predictions/ready/rcp26_2050_layers.Rdata")
rm(rcp26_2050_layers)

rcp26_2070_layers <- get_future_data(rcp = 26, yr = 70)
save(rcp26_2070_layers, file = "data/climate_predictions/ready/rcp26_2070_layers.Rdata")
rm(rcp26_2070_layers)

rcp85_2050_layers <- get_future_data(rcp = 85, yr = 50)
save(rcp85_2050_layers, file = "data/climate_predictions/ready/rcp85_2050_layers.Rdata")
rm(rcp85_2050_layers)

rcp85_2070_layers <- get_future_data(rcp = 85, yr = 70)
save(rcp85_2070_layers, file = "data/climate_predictions/ready/rcp85_2070_layers.Rdata")
rm(rcp85_2070_layers)


load(file = 'models/present/me_b1.Rdata')

source('functions/get_future_predictions.R')

load(file = "data/climate_predictions/ready/rcp26_2050_layers.Rdata")
rcp26_2050_pred <- get_future_predictions(me_model = me_b1, 
                                          futurelayers = rcp26_2050_layers)
save(rcp26_2050_pred, file = 'predictions/rcp26_2050.Rdata')
rm(rcp26_2050_pred)
rm(rcp26_2050_layers)

load(file = "data/climate_predictions/ready/rcp26_2070_layers.Rdata")
rcp26_2070_pred <- get_future_predictions(me_model = me_b1, 
                                          futurelayers = rcp26_2070_layers)
save(rcp26_2070_pred, file = 'predictions/rcp26_2070.Rdata')
rm(rcp26_2070_pred)
rm(rcp26_2070_layers)


load(file = "data/climate_predictions/ready/rcp85_2050_layers.Rdata")
rcp85_2050_pred <- get_future_predictions(me_model = me_b1, 
                                          futurelayers = rcp85_2050_layers)
save(rcp85_2050_pred, file = 'predictions/rcp85_2050.Rdata')
rm(rcp85_2050_pred)
rm(rcp85_2050_layers)

load(file = "data/climate_predictions/ready/rcp85_2070_layers.Rdata")
rcp85_2070_pred <- get_future_predictions(me_model = me_b1, 
                                          futurelayers = rcp85_2070_layers)
save(rcp85_2070_pred, file = 'predictions/rcp85_2070.Rdata')
rm(rcp85_2070_pred)
rm(rcp85_2070_layers)

# Threshold all rasters 

# Start with present
# Use this to get threshold values
load('models/present/fit_b1.Rdata')

thresholds <- quantile(fit_b1, probs = c(0.5, 0.8))

present_thresh <- make_thresholded(fit_b1, thresholds = thresholds)

plot(present_thresh, main = 'Present suitability')

save(present_thresh, file = 'models/present/b1_thresholded.Rdata')

rm(present_thresh)
rm(fit_b1)

# Now reclassify predictions using these thresholds

load('predictions/rcp26_2050.Rdata')
rcp26_2050_thresh <- make_thresholded(rcp26_2050_pred, thresholds = thresholds)
save(rcp26_2050_thresh, file = 'predictions/rcp26_2050_thresholded.Rdata')
rm(list = c('rcp26_2050_thresh', 'rcp26_2050_pred'))

load('predictions/rcp26_2070.Rdata')
rcp26_2070_thresh <- make_thresholded(rcp26_2070_pred, thresholds = thresholds)
save(rcp26_2070_thresh, file = 'predictions/rcp26_2070_thresholded.Rdata')
rm(list = c('rcp26_2070_thresh', 'rcp26_2070_pred'))

load('predictions/rcp85_2050.Rdata')
rcp85_2050_thresh <- make_thresholded(rcp85_2050_pred, thresholds = thresholds)
save(rcp85_2050_thresh, file = 'predictions/rcp85_2050_thresholded.Rdata')
rm(list = c('rcp85_2050_thresh', 'rcp85_2050_pred'))

load('predictions/rcp85_2070.Rdata')
rcp85_2070_thresh <- make_thresholded(rcp85_2070_pred, thresholds = thresholds)
save(rcp85_2070_thresh, file = 'predictions/rcp85_2070_thresholded.Rdata')
rm(list = c('rcp85_2070_thresh', 'rcp85_2070_pred'))

# get some summary stats
source('functions/report_summary_stats.R')
load('predictions/rcp85_2070_thresholded.Rdata')
rcp85_2070_stats <- report_summary_stats(rcp85_2070_thresh)
rm(rcp85_2070_thresh)

load('predictions/rcp85_2050_thresholded.Rdata')
rcp85_2050_stats <- report_summary_stats(rcp85_2050_thresh)
rm(rcp85_2050_thresh)

load('predictions/rcp26_2070_thresholded.Rdata')
rcp26_2070_stats <- report_summary_stats(rcp26_2070_thresh)
rm(rcp26_2070_thresh)

load('predictions/rcp26_2050_thresholded.Rdata')
rcp26_2050_stats <- report_summary_stats(rcp26_2050_thresh)
rm(rcp26_2050_thresh)

all_sum_stats <- rbind(rcp26_2050_stats, rcp26_2070_stats,
                       rcp85_2050_stats, rcp85_2070_stats)
all_sum_stats <- as.data.frame(all_sum_stats)
colnames(all_sum_stats) <- c('total_cells', 'lows', 'mediums', 'highs')
all_sum_stats$rcp <- c(26, 26, 85, 85)
all_sum_stats$yr <- c(50, 70, 50, 70)

write.csv(all_sum_stats, 'predictions/summary_stats.csv',
          row.names = F)

rm(all_sum_stats)
rm(list = c('rcp26_2050_stats', 'rcp26_2070_stats',
                       'rcp85_2050_stats', 'rcp85_2070_stats'))
