# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Series :01
# Name: Day of the week and Volatility
# Description: This program estimate return and asset's volatility
#               by using GARCH and Modified-GARCH
# Ticker: IDX; JKSE
# Author: Asri Surya
# Date: March 2020
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# start
cat("\014") #clear console
rm(list = ls())
#environment packages preparation ++++++
ipak <- function(pkg){
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  if (length(new.pkg)) 
    install.packages(new.pkg, dependencies = TRUE)
  sapply(pkg, require, character.only = TRUE)
}


# List of packages
packages <- c("xtable", "rugarch","dplyr", "xtable")
ipak(packages)

# load dataset to environment ----
dataset <- readRDS(file = "data/dataset_clean.rds") #load dataset 

dataset$date <-as.Date(dataset$date,"%Y-%m-%d")#convert date format

# Estimation period list
periodList <- c('2000-01-01','2005-01-01','2010-01-01','2015-01-01','2019-01-01')

  k <- dataset %>% # matrix for i-th period in periodList 
    filter(date > periodList[4] & date < periodList[5]) # pull data from dataset to matrix
    l <- k %>% 
      select(px.return)#convert -return- from dataset type to matrix type
  
  m <- k %>% 
    select(dayMon,dayTue,dayThu,dayFri)#external regressor exclude Wednesday
    n <- data.matrix(m) #convert external regressor to matrix type
  
    #modified GARCH with mean model only
      spec1 <- ugarchspec(variance.model = list(model = "sGARCH", garchOrder = c(1, 1), #model spesification
                              submodel = NULL, external.regressors = n, variance.targeting = FALSE), 
                            mean.model = list(armaOrder = c(0, 0),external.regressors = n, distribution = "std"))
        
       garch1 <- ugarchfit(spec=spec1,data=l[,1],solver.control=list(trace=0))
       
  garch1