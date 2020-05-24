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

our_summary1 <-
  list("2000-2019 (Full Sample)" =
         list("Mean_sd" = ~ mean(.data$px.return, digits = getOption("qwraps2_frmt_digits", 2),),
              "Standard Deviation" = ~ sd(.data$px.return),
              "Skewness" = ~ skewness(.data$px.return),
              "Observations" = ~ length(.data$px.return)))

### Overall
whole <- summary_table(dplyr::group_by(df, day), our_summary1)
wholex <- xtable(whole, digits = c(2,2,2,0,0,2))
align(wholex) <- "lrrrr" #alignment
addtorow <- list()
addtorow$pos <- list(0,0)

#header
addtorow$command <- c("& Monday & Tuesday & Wednesday & Thursday & Friday\\\\\n",
                      "& Mean& St.dev & T-stat & Observations\\\\\n")

names(wholex) <- c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday")
#print(xtable(whole, type = "latex", caption = "Summary Statistics of Return", digits = c(0,0,0,2,2,1)),
#      file = "filename2.tex", caption.placement = "top")

print(wholex, caption = "Summary Statistics of Return", include.colnames = TRUE, type = "latex", 
      floating = FALSE,
      include.rownames=TRUE, file="ini.tex", caption.placement = "top")

