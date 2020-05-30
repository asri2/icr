cat("\014") #clear console
rm(list = ls())

library(xtable)

#load dataframe

dfx <- readRDS(file = "data/garch_clean.rds") #load dataset
#convert to matrix
df <-as.matrix(dfx)

day_name <- list("Constant","", "Monday","", "Tuesday","", "Thursday","", "Friday")

# 5 columns; 24 rows

df <- xtable(df, digits=6)
align(df) <- "lrrrr"
colnames(df) <- c( "2000-2004" , "2005-2009" , "2010-2014" , "2015-2019" )
k <- list("Constant","", "Monday","", "Tuesday","", "Thursday","", "Friday","", "$\alpha_1$","_","$\gamma_1$","", "Monday","", "Tuesday","", "Thursday","", "Friday","","$\alpha_0","")
# 5 columns; 24 rows

print(xtable(df, type = "latex"), align="rrrr",include.colnames = TRUE, type = "latex", floating = TRUE, include.rownames = FALSE, file = "output/tab_01.tex")

fileConn<-file("output/table_main.rnw")
writeLines(c("\\documentclass{article}","\\begin{document}",paste0("\\input{tab_01.tex}"),"\\end{document}"), fileConn)
close(fileConn)
