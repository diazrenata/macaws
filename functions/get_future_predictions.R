get_future_predictions <- function(me_model, futurelayers) {
  predictions <- predict(futurelayers, me_model)
  return(predictions)
}