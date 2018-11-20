extract_cov <- function(layers = macawlayers, xys = macaw.data.xy) {
  pres.xy <- xys
  back.xy <- randomPoints(layers, p=pres.xy, n=5000)   

  colnames(back.xy)<-c("EASTING","NORTHING")
  points(back.xy)
  
  ###############extract GIS data
  ##With these locations and the points we identified above for presence and validation data, we extract covariate values at each point with the extract function, remove potential NAs (where random points were generated but not all environmental data occur), and link them into a single data frame:
  
  pres.cov<-extract(macawlayers, macaw.data.xy)          #extracts values from layers at pres locations
  back.cov<-extract(macawlayers, back.xy)               #extracts values from layers at random locations
  
  
  #link data and remove any potential NAs
  pres.cov<-data.frame(macaw.data.xy,pres.cov, pres=1)
  back.cov<-data.frame(back.xy,back.cov, pres=0)
  
  
  pres.cov<-pres.cov[complete.cases(pres.cov),]
  back.cov<-back.cov[complete.cases(back.cov),]
  
 save(back.xy, pres.cov, back.cov, file = 'data/present/ready/covariates.Rdata')
}

plot_cov_cor <- function(pres.cov = pres.cov, back.cov = back.cov){
  #bind pres and background points together
  all.cov=rbind(pres.cov,back.cov)
  head(all.cov)
  
  #correlations
  cor(all.cov[,c("precip","temp","land")])
  
  #plot occurrence versus available/background
  
  ##these histograms help us compare how our presence data alines with available points, Ideally you would want your presence and avaialble covariate distribution to match as much as possible, but in our case elevation for avaialble points do not match much since macaws are not recorded in the north of Belize
  par(mfrow=c(3,2))
  
  hist(back.cov[,"temp"], main="Temp Available", xlim=c(200,300),col="grey")
  hist(pres.cov[,"temp"], main="Temp Presence",xlim=c(200,300), col="red")
  
  hist(back.cov[,"precip"], main="precip Available",xlim=c(0,5000),col="grey")
  hist(pres.cov[,"precip"], main="precip Presence",xlim=c(0,5000), col="red")
  
  hist(back.cov[,"land"], main="land Available",xlim=c(-1,20),col="grey")
  hist(pres.cov[,"land"], main="land Presence",xlim=c(-1,20), col="red")
  
  dev.off()
  
}