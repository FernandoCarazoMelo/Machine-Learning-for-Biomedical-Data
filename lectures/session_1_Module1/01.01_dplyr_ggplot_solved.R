#####################################################################################
# Author: Fernando Carazo | fcarazo@tecnun.es
# Date: 2020-07-08
# Script purpose: ML course dplyr and ggplot
# Copyright (C) 2020, code licensed under GPLv3
#####################################################################################


# Library and source ------------------------------------------------------

library(dplyr)
library(ggplot2)
library(titanic)

# Input -------------------------------------------------------------------

datos <- titanic_train

glimpse(datos)


#####################################################################################
## Section 1: 2020-07-08 - Summary and table ----
#####################################################################################

table(datos$Survived)
prop.table(table(datos$Survived))

table(datos$Survived, datos$Sex, datos$Embarked)
prop.table(table(datos$Survived, datos$Sex)
)
#####################################################################################
## Section 2: 2020-07-08 - dplyr ----
#####################################################################################


# Select

colnames(datos
         )

df1 <- select(datos, Survived, Sex)

df2 <- datos %>% select(Survived, Sex)

# crtl + shift + m

datos %>% select(PassengerId, Embarked)

# Filter

# alt + -

df3 <- datos %>% filter(Survived == 1, Sex == "female")

# data frame con embarked ["C", "S"] y columnas [embarked, survived, sex]

df4 <- datos %>% 
  filter(Embarked %in% c("C", "S")) %>% 
  select(Embarked, Survived, Sex, Age) 

df4_bis <- select(filter(datos,Embarked %in% c("C", "S")), Embarked, Survived, Sex, Age)

identical(df4, df4_bis)

# Mutate

df5 <- datos %>% mutate(Menor = Age < 10)

df6 <- datos
df6$Menor <- df6$Age < 10

df7 <- datos %>% select(-Survived)


# group_by and summarize

datos %>% summarize(Media = mean(Age, na.rm = T), Mediana = median(Age, na.rm = T))

# mean age for survival

datos %>% group_by(Survived) %>% summarize(Media = mean(Age, na.rm = T))
datos %>% group_by(Survived, Sex) %>% summarize(Media = mean(Age, na.rm = T))

datos %>% filter(Age > 8) %>% group_by(Survived) %>% summarize(Mediana = median(Age, na.rm = T))


#####################################################################################
## Section 3: 2020-07-08 - ggplot 2 ----
#####################################################################################

colnames(datos)

# Cheatsheet 
# density

g1 <- ggplot(data = datos, aes(Age)) + geom_density(aes(fill = Sex, color = Sex), alpha = 0.4)
g1

g1 + ggtitle("Density of Age", subtitle = "My first plot")

# boxplot de la variable PClass (eje x) y la edad (eje y)

ggplot(datos, aes(Pclass, Age)) + geom_boxplot()

datos$Pclass <- as.factor(datos$Pclass)

ggplot(datos, aes(Pclass, Age)) + geom_boxplot()


ggplot(datos, aes(Pclass)) + 
  geom_boxplot(aes(y = Age, fill = Sex))

# barplot

datos$Survived <- as.factor(datos$Survived)

ggplot(datos, aes(x = Survived, y = ..count.., fill = Sex)) + 
  geom_bar() # position = "fill"

# scatter Age Fare


ggplot(datos, aes(Age, log10(Fare), color = Sex)) + 
  geom_point() +
  ylab("Fare logarithmic scale")



df5 <- datos %>% filter(Sex == "female") %>% mutate(Menor = Age < 10)

ggplot(df5, aes(Menor)) + geom_bar(aes(fill = Sex))
