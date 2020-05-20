#------------------------------------------------------------------
# Series :00
# Name: the day of the week and Volatility
# Description: This program download and prepare asset prices and return
#               by quantmod
# Ticker: IDX; JKSE, Indonesia.
# Author: Asri Surya
# Date: May 2020
#------------------------------------------------------------------
cat("\014") #clear console
rm(list = ls())

#environment preparation ------------
ipak <- function(pkg){
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  if (length(new.pkg)) 
    install.packages(new.pkg, dependencies = TRUE)
  sapply(pkg, require, character.only = TRUE)
}

# List of packages
packages <- c("quantmod","knitr")
ipak(packages)

# Download data from YahooFinance
getSymbols('^JKSE', from='2000-01-01', to='2020-01-01') # where JKSE: Indonesia Stock Exchange
JKSEReturns <- dailyReturn(JKSE, type='log') #Calculate Index return, Daily

write.csv(JKSE,"dataset.csv", row.names = TRUE)

#+++end