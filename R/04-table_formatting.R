cat("\014") #clear console
rm(list = ls())

library(xtable)

#load dataframe

dfx <- readRDS(file = "data/garch_clean.rds") #load dataset
#convert to matrix
df <-as.matrix(dfx) 

day_name <- list("Constant","", "Monday","", "Tuesday","", "Thursday","", "Friday")
period_name <- list('2000-01-01','2005-01-01','2010-01-01','2015-01-01')

# 5 columns; 24 rows

df <- xtable(df, digits=6)
align(df) <- "lrrrr"
colnames(df) <- c( "2000-2004" , "2005-2009" , "2010-2014" , "2015-2019" )
k <- list("Constant","", "Monday","", "Tuesday","", "Thursday","", "Friday","", "$\alpha_1$","_","$\gamma_1$","", "Monday","", "Tuesday","", "Thursday","", "Friday","","$\alpha_0","")
# 5 columns; 24 rows

print(xtable(df), align="lrrrr",include.colnames = TRUE, type = "latex", floating = TRUE, include.rownames = FALSE)

file="/output/result_main_2020.tex"
