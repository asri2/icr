#------------------------------------------------------------------
# Series :00
# Name: the day of the week and Volatility
# Description: This program download and export inital dataset
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
packages <- c("quantmod","ggplot2","dplyr")
ipak(packages)

# Download data from YahooFinance
getSymbols('^JKSE', from='2000-01-01', to='2020-01-01') # where JKSE: Indonesia Stock Exchange
df <- fortify(JKSE)
df1<-df %>%       # select only date and Close price
  select(Index, JKSE.Close)
colnames(df1)<- c("date","px.close") # rename column name
write.csv(df1,"Datafiles/dataset.csv", row.names = TRUE) #write csv into Datafiles folder

#+++end
