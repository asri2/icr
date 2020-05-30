cat("\014") #clear console
rm(list = ls())

library(xtable)

#load dataframe

dfx <- readRDS(file = "data/garch_clean.rds") #load dataset
#convert to matrix
df <-as.matrix(dfx)
k <- c("Constant","", "Monday","", "Tuesday","", "Thursday","", "Friday","", "$\\alpha_1$","","$\\gamma_1$","", "Monday","", "Tuesday","", "Thursday","", "Friday","","$\\alpha_0$","")
df <- cbind(k,df)
df <- xtable(df, digits=5)
df <- as.data.frame(df)

colnames(df) <- c("$alpha_0$", "2000-2004" , "2005-2009" , "2010-2014" , "2015-2019" ) #column names
# 5 columns; 24 rows

print(xtable(df, type = "latex"), align="lrrrr",include.colnames = TRUE, type = "latex", floating = TRUE, floating.environment = " sidewaystable", include.rownames = FALSE, file = "output/tab_01.tex")

fileConn<-file("output/table_main.rnw")
writeLines(c("\\documentclass{article}","\\usepackage{rotating}","\\begin{document}","Table 1. Modified GARCH Estimation","$\\echo_1$",paste0("\\input{tab_01.tex}"),"\\end{document}"), fileConn)
close(fileConn)

# Export PDF
#R CMD Sweave --pdf my_sweave_file.Rnw