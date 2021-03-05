# Helper packages
library(dplyr)       # for data wrangling
library(ggplot2)     # for awesome plotting

# Modeling packages
library(rpart)       # direct engine for decision tree application
library(caret)       # meta engine for decision tree application

# Model interpretability packages
library(rpart.plot)  # for plotting decision trees
library(vip)         # for feature importance
library(pdp)         # for feature effects

# Ames housing data
ames <- AmesHousing::make_ames()

set.seed(123)
split <- initial_split(ames, prop = 0.7, 
                       strata = "Sale_Price")
ames_train  <- training(split)
ames_test   <- testing(split)


ames_dt1 <- rpart(
  formula = Sale_Price ~ .,
  data    = ames_train,
  method  = "anova"
)

ames_dt1


x11();rpart.plot(ames_dt1)
plotcp(ames_dt1)


ames_dt2 <- rpart(
  formula = Sale_Price ~ .,
  data    = ames_train,
  method  = "anova", 
  control = list(cp = 0, xval = 10)
)

plotcp(ames_dt2)
abline(v = 11, lty = "dashed")

ames_dt1$cptable


ames_dt3 <- train(
  Sale_Price ~ .,
  data = ames_train,
  method = "rpart",
  trControl = trainControl(method = "cv", number = 10),
  tuneLength = 20
)

ggplot(ames_dt3)
ames_dt3



# 9.6 Feature interpretation
# To measure feature importance, the reduction in the       

vip(ames_dt3, num_features = 40,geom = "point")
