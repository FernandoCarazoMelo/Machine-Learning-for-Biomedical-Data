#####################################################################################
# Author: Fernando Carazo | fcarazo@tecnun.es
# Date: 2021-03-11
# Script purpose: Bagging and Random Forest
# Copyright (C) 2021, code licensed under GPLv3
#####################################################################################


# Bagging

## Prerequisites

# Helper packages
library(dplyr)    # for data wrangling
library(ggplot2)  # for awesome graphics

# Modeling packages
library(ranger)   # a c++ implementation of random forest 
library(h2o)      # a java-based implementation of random forest
library(caret)       # for general model fitting
library(rpart)       # for fitting decision trees
library(ipred)       # for fitting bagged decision trees
library(tictoc)

# create Ames training data
set.seed(123)
ames <- AmesHousing::make_ames()
split  <- initial_split(ames, prop = 0.7, strata = "Sale_Price")
ames_train  <- training(split)
ames_test  <- testing(split)



## Implementation


?bagging

