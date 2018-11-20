get_train_test <- function(macaw.data.xy = macaw.data.xy, back.xy = back.xy) {
  set.seed=5
  train.pres <- sample(1:266, 100, replace = F)
  
  macaw.data.xy.train <- macaw.data.xy[train.pres, ]
  macaw.data.xy.test <- macaw.data.xy[-train.pres,]
  
  train.back <- sample(1:5000, 2000, replace = F)
  back.xy.train <- back.xy[train.back, ]
  back.xy.test <- back.xy[-train.back, ]
  
  save(macaw.data.xy.train, back.xy.train, file = 'data/present/ready/train.Rdata')
  save(macaw.data.xy.test, back.xy.test, file = 'data/present/ready/test.Rdata')
  
  
}