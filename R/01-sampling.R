#------------------------------------------------------------------
# Series :01
# Name: the day of the week and Volatility
# Description: Sampling  - remove holiday
# Ticker: IDX; JKSE, Indonesia.
# Author: Asri Surya
# Date: May 2020
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

# Import data
jkse <- read.csv('dataset.csv')
jkse <- jkse %>% 
  select("date","px.close") %>% 
  mutate(px.return=log(px.close/lag(px.close)))%>% #Calculate return (close-to-close)
  mutate(day=wday(date, label = TRUE)) %>% #Generate name of the day
  mutate(tradingday= #trading and nontrading days
           case_when(px.close %in% NA ~0, 
                               TRUE ~1) )
head(jkse,15)

