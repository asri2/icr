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

# Import and transform data------
raw_data <- read.csv('Datafiles/dataset.csv') #read dataset from local drive

df <- raw_data %>% 
  select("date","px.close") %>% 
  mutate(px.return=100*log(px.close/lag(px.close)))%>% #Calculate return (close-to-close)
  mutate(day=wday(date, label = TRUE)) %>% #Generate name of the day (label)
  mutate(tradingday=case_when(px.close %in% NA ~0, TRUE ~1) ) #Dummy trading and nontrading days
  
# Generate dummy variable weekday
df <- model.matrix(~0 + day, df) %>%
  as.data.frame() %>% 
  bind_cols(df) %>% 
  # Drop weekend and base category (Wednesday)  
    select(day,everything(),-c(daySun,daySat))
 
df <- na.omit(df) #remove NA values

# save R dataset Object
saveRDS(df, file = "Datafiles/dataset_proc.rds")

# ~ end
