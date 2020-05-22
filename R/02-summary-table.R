#------------------------------------------------------------------
# Series :01
# Name: the day of the week and Volatility
# Description: Create summart table in LATEX format
# Ticker: IDX; JKSE, Indonesia.
# Author: Asri Surya
# Date: May 2020
# Note: Require TEX complier = MikTex, TexLive, etc.
#------------------------------------------------------------------
rm(list = ls()) #clear terminal
cat("\014") #clear console

#environment preparation ------------
ipak <- function(pkg){
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  if (length(new.pkg)) 
    install.packages(new.pkg, dependencies = TRUE)
  sapply(pkg, require, character.only = TRUE)
}

# List of packages
packages <- c("dplyr","lubridate")
ipak(packages)

# Restore the dataset from 01
df <- readRDS(file = "Datafiles/dataset_sample.rds")
df