#------------------------------------------------------------------
# Series :02
# Name: the day of the week and Volatility
# Description: Create summary table in LATEX format
# Ticker: IDX; JKSE, Indonesia.
# Author: Asri Surya
# Date: May 2020
# Note: Require TEX complier = MikTex, TexLive, etc.
#------------------------------------------------------------------
rm(list = ls()) #clear terminal
cat("\014") #clear console

# List of packages

library(dplyr)
library(qwraps2)
library(e1071)
library(xtable)
options(qwraps2_markup = "markdown")
# options(qwraps2_markup = "latex") is also supported.

# Restore the dataset from 01
df <- readRDS(file = "Datafiles/dataset_proc.rds")
df <- df %>% 
  select(day, px.return, date, sub_period)
#frmt(whole, digits = getOption("qwraps2_frmt_digits", 4))

period_list <- c( "2000-2004","2005-2009","2010-2014","2015-2019")
day_names = c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday")


df_1 <- df %>% 
    filter(sub_period== 1)
df_2 <- df %>% 
    filter(sub_period== 2)
df_3 <- df %>% 
    filter(sub_period== 3)
df_4 <- df %>% 
    filter(sub_period== 4)


our_summary1 <-
  list("2000-2019 (Full Sample)" =
         list("Mean_sd" = ~ mean(.data$px.return, digits = getOption("qwraps2_frmt_digits", 2),),
              "Standard Deviation" = ~ sd(.data$px.return),
              "Skewness" = ~ skewness(.data$px.return),
              "Observations" = ~ length(.data$px.return)),
  "2000-2004" =
         list("Mean" = ~ mean(df_1$px.return),
              "Standard Deviation" = ~ sd(df_1$px.return),
              "t-statistic" = ~ max(df_1$px.return),
              "Observations" = ~ length(df_1$px.return)),
  "2005-2009" =
         list("Mean" = ~ mean(df_2$px.return),
              "Standard Deviation" = ~ sd(df_2$px.return),
              "t-statistic" = ~ max(df_2$px.return),
              "Observations" = ~ length(df_2$px.return)),
  "2010-2014" =
         list("Mean" = ~ mean(df_3$px.return),
              "Standard Deviation" = ~ sd(df_3$px.return),
              "t-statistic" = ~ max(df_3$px.return),
              "Observations" = ~ length(df_3$px.return)),
  "2014-2019" =
         list("Mean" = ~ mean(df_4$px.return),
              "Standard Deviation" = ~ sd(df_4$px.return),
              "t-statistic" = ~ max(df_4$px.return),
              "Observations" = ~ length(df_4$px.return)))

### Overall
whole <- summary_table(dplyr::group_by(df, day), our_summary1)

print(whole,
      cnames = day_names)
#+end~
print(xtable(whole, type = "latex"), file = "filename2.tex")