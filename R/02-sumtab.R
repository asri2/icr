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
packages <- c("dplyr","lubridate", "qwraps2")
ipak(packages)

options(qwraps2_markup = "markdown")
# options(qwraps2_markup = "latex") is also supported.

# Restore the dataset from 01
df <- readRDS(file = "Datafiles/dataset_proc.rds")
#frmt(whole, digits = getOption("qwraps2_frmt_digits", 4))

period_list <- c( "2000-2004","2005-2009","2010-2014","2015-2019")
daynames = c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday")


our_summary1 <-
  list("2000-2019 (Full Sample)" =
         list("Mean" = ~ mean(.data$px.return),
              "Standard Deviation" = ~ sd(.data$px.return),
              "t-statistic" = ~ max(.data$px.return),
              "Observations" = ~ length(.data$px.return)))

### Overall
whole <- summary_table(dplyr::group_by(df, day), our_summary1)
whole

print(whole,
      cnames = daynames)

for (m in 1:4) {
  j <- df %>% 
    filter(sub_period== m) %>% 
    select(day, px.return, date, sub_period)
  period = paste0(period_list[m])
  our_summary0 <-
    list( print =
           list("Mean" = ~ mean(.data$px.return),
                "Standard Deviation" = ~ sd(.data$px.return),
                "t-statistic" = ~ max(.data$px.return),
                "Observations" = ~ length(.data$px.return)))
  whole <- summary_table(dplyr::group_by(j, day), our_summary0)
  print(period)
  print(whole,
        cnames = daynames)
}
