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

# Import the data and look at the first six rows
jkse <- read.csv('dataset.csv')
jkse <- jkse %>% 
  select("date","px.close") %>% 
  mutate(day=wday(date, label = TRUE))
head(jkse,10)

# Calculate return (close-to-close)
#jkse <- jkse %>% 
  mutate(px.return=log(px.close/lag(px.close)))
head(jkse,10) #check header

# Check the non-trading day on weekdays

# generate sequential date
ts <- seq(ymd("2000-01-01"), ymd("2020-01-01"), by="day")
df <- data.frame(date=ts) #change object type to Date
jkse <- jkse  %>%  #Merge missing date with jkse
  full_join(df,jkse, by='date')
head(jkse,13)

jkse <- jkse %>%
 
