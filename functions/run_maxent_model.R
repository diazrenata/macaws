run_maxent_model <- function(layers = macawlayers, pres = macaw.data.xy.train, 
                             abs = back.xy.train, betaval) {
  
  beta_argument <- paste0('betamultiplier=',betaval)
  
  this_model <- maxent(layers, p=pres,a=abs,
                       args=c(beta_argument), factor = "land")
  return(this_model)

}

fit_maxent_model <- function(maxent_model, layers = macawlayers) {
  fit <- predict(layers, maxent_model)
  
 return(fit)
}

boyce_maxent_model <- function(fit, test_data = macaw.data.xy.test) {
test_values <- extract(fit, macaw.data.xy.test)
this_boyce <- ecospat.boyce(fit, test_values)
return(this_boyce)
}