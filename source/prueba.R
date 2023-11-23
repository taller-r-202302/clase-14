## Clase 14: Regresiones
## Eduard Martinez
## 10-11-2023

## configuracion inicial 
rm(list = ls()) # limpia el entorno de R

## llamar y/o instalar las librerias de la clase 
require(pacman)
p_load(tidyverse, arrow, rio , 
       broom, # tidy-coefficients
       mfx, # marginal effects
       margins,  # marginal effects
       estimatr, # robust standard errors
       lmtest, # HAC (Newey-West) standard errors
       fixest, # hdfe regressions (feols)
       modelsummary, # Coefplot with modelplot
       stargazer # export tables to latex 
)  

## cargar datos
df <- tibble(mtcars)

## OLS
lm(formula = "mpg ~ hp + vs + carb" , 
   data = df)

## asignar a un objeto
ols_1 <- lm(formula = "mpg ~ hp + vs + carb" , 
            data = df)

## con un subconjunto de datos
ols_2 <- lm(formula = "mpg ~ hp + vs + carb" , 
            data = df, subset = am==1 )


## con un subconjunto de datos
rboust_1 <- lm_robust(formula =as.formula("mpg ~ hp + vs + carb") , 
            data = df)

robust_stata <- lm_robust(formula =as.formula("mpg ~ hp + vs + carb") , 
                          data = df , se_type="stata")

## 
ols_3 <- lm(formula = "mpg ~ hp + vs + as.factor(carb)" , 
            data = df)

## ols 4
ols_4 <- lm(formula = "mpg ~ hp + vs*as.factor(carb)" , 
            data = df)

## logit
logit_1 <- glm(formula = "vs ~ hp + as.factor(carb)" , 
               data = df , binomial(link = "logit")) 


## presentar resultdos
msummary(models = list(ols_1,ols_2,rboust_1,robust_stata),output = "output/resultados.xlsx"
          
          )

## coefplot
modelos <- list("OLS"=ols_1,"OLS-HC2"=rboust_1,"OLS-HC1"=robust_stata)
modelplot(modelos) + coord_flip()


















