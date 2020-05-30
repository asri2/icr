cat("\014") #clear console
rm(list = ls())

library(xtable)

#load dataframe

df <- readRDS(file = "data/garch_clean.rds") #load dataset
#convert to matrix
# why the \backlash not working in greek latter for column name?
k <- c("Constant","", "Monday","", "Tuesday","", "Thursday","", "Friday","", "alpha_1","","gamma_1","", "Monday","", "Tuesday","", "Thursday","", "Friday","","alpha_0","")
#dfj <- cbind(k,df)
df <- as.data.frame(df)
df <- xtable(df, align="rrrrr")
digits(df) <- c(4,3,0,2,6)
colnames(df) <- c("2000-2004" , "2005-2009" , "2010-2014" , "2015-2019" ) #column names
# 5 columns; 24 rows

print(xtable(df, type = "latex"), include.colnames = TRUE, type = "latex", floating = TRUE, include.rownames = FALSE, file = "output/tab_01.tex")

fileConn<-file("output/table_main.rnw")
writeLines(c("\\documentclass{article}","\\begin{document}","Table 1. Modified GARCH Estimation",paste0("\\input{tab_01.tex}"),"\\end{document}"), fileConn)
close(fileConn)

# Export PDF
#R CMD Sweave --pdf my_sweave_file.Rnw