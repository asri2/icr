#load data into Environment
cat("\014") #clear console
rm(list = ls())
#environment packages preparation ++++++
ipak <- function(pkg){
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  if (length(new.pkg)) 
    install.packages(new.pkg, dependencies = TRUE)
  sapply(pkg, require, character.only = TRUE)
}

xdir <-paste0(getwd()) #get The User's current working directory

# List of packages
packages <- c("xtable", "rugarch","dplyr")
ipak(packages)
df <- readRDS(file = "data/dataset_clean.rds") #load dataset 

df$date <-as.Date(df$date,"%Y-%m-%d")#convert date format

# Period list
period_list <- c('2000-01-01','2005-01-01','2010-01-01','2015-01-01','2019-01-01')

# Modified GARCH Model



# Modified GARCH Function
modified_garch <- function(data_i, plist){ # where plist is period list.
  n_plist <- length(plist)-1 #number of row
  for (i in 1:4) { print(paste0(plist[i]))
    
  # spilt dataframe into sub period
  k <- data_i %>% # matrix for i-th period in periodList
    filter(sub_period == i ) # pull data from dataset to matrix
  
    # independet variable as [px.return] <- LHS
      LHS <- k %>% 
        select(px.return) 
      
    # dependent variable as [dummy days] <- RHS
      RHS <- k %>% 
        select(dayMon, dayTue, dayThu, dayFri)
      RHS <- data.matrix(RHS)
      
      spec1 <- ugarchspec(variance.model = list(model = "sGARCH", distribution.model = "std", garchOrder = c(1, 1), #model spesification
                          submodel = NULL, external.regressors = NULL, variance.targeting = FALSE), 
                          mean.model = list(armaOrder = c(0, 0),external.regressors = RHS,
                                            distribution.model = "std"))

      
      garch1 <- ugarchfit(spec=spec1,data=LHS,solver.control=list(trace=0))
      
      print(paste0(plist[i],"_done"))
     
  }
}

#test

modified_garch(data_i=df,plist=period_list)

#~end
nrow
