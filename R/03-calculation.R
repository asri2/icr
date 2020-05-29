#load data into Environment
cat("\014") #clear console
rm(list = ls())
#environment packages preparation ++++++
ipak <- function(pkg){
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  if (length(new.pkg)) 
    install.packages(new.pkg, dependencies = TRUE)
  sapply(pkg, require, character.only = TRUE)
}

xdir <-paste0(getwd()) #get The User's current working directory

# List of packages
packages <- c("xtable", "rugarch","dplyr","tidyverse","tidyr")
ipak(packages)
df <- readRDS(file = "data/dataset_clean.rds") #load dataset 

df$date <-as.Date(df$date,"%Y-%m-%d")#convert date format

# Period list
period_list <- c('2000-01-01','2005-01-01','2010-01-01','2015-01-01','2019-01-01')

# Modified GARCH Function

modified_garch <- function(data_i, plist){ # where plist is period list.
  n_plist <- length(plist)-1 #number of row
  
  k <- data_i %>% # matrix for i-th period in periodList
    filter(date > plist[1] & date < plist[2]) # pull data from dataset to matrix
  
  n_plist <- nrow(plist)
  print(paste0(plist[1]," & ", plist[2]))
  print(paste(n_plist))
}

#test

modified_garch(df,period_list)

#~end
nrow
