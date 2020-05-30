# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Series :01
# Name: Day of the week and Volatility
# Description: This program estimate return and asset's volatility
#               by using GARCH and Modified-GARCH
# Ticker: IDX; JKSE
# Author: Asri Surya
# Date: March 2020
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# start
cat("\014") #clear console
rm(list = ls())
#environment packages preparation ++++++
ipak <- function(pkg){
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  if (length(new.pkg)) 
    install.packages(new.pkg, dependencies = TRUE)
  sapply(pkg, require, character.only = TRUE)
}


# List of packages
packages <- c("xtable", "rugarch","dplyr")
ipak(packages)

# load dataset to environment ----
dataset <- readRDS(file = "data/dataset_clean.rds") #load dataset 

dataset$date <-as.Date(dataset$date,"%Y-%m-%d")#convert date format

# Estimation period list
periodList <- c('2000-01-01','2005-01-01','2010-01-01','2015-01-01','2019-01-01')
loopLength <-length(periodList)-1

# an empty dataset to store result
mresult <- matrix(0, nrow = 24, ncol=loopLength) 

cat("\014") #clear console

for (i in 1:loopLength) {
  k <- dataset %>% # matrix for i-th period in periodList 
    filter(date > periodList[i] & date < periodList[i+1]) # pull data from dataset to matrix
    l <- k %>% 
      select(px.return)#convert -return- from dataset type to matrix type
  
  m <- k %>% 
    select(dayMon,dayTue,dayThu,dayFri)#external regressor exclude Wednesday
    n <- data.matrix(m) #convert external regressor to matrix type
  
    #modified GARCH with mean model only
      spec1 <- ugarchspec(variance.model = list(model = "sGARCH", garchOrder = c(1, 1), #model spesification
                              submodel = NULL, external.regressors = n, variance.targeting = TRUE), 
                            mean.model = list(armaOrder = c(0, 0),external.regressors = n, 
                                              distribution.model = "std"))
        
       garch1 <- ugarchfit(spec=spec1,data=l[,1],solver.control=list(trace=0))
       
    # extract coefficient and standard deviation from garch1 estimation (S4 Class object)
       Coef <- as.matrix(garch1@fit$coef) # coeficient
       Stdev <- as.matrix(garch1@fit$se.coef) # standard deviation
        CoefLength <-(length(Coef))

      l<-1
        for (j in 1:CoefLength){   #start to binding result per element matrix
          mresult[l,i]=Coef[j]
          k<-l+1
          mresult[k,i]=Stdev[j]
          l <-l+2
        }
}

# create variable and paramater name
mres<-as.data.frame(garch1@fit$coef)
mm <- rownames(mres)
mmname <-matrix(1:24)
ij<-1
var_name <- c("Constant", "Monday", "Tuesday", "Thursday", "Friday")
for (jj in 1: 12){
  mmname[ij] = paste0(mm[jj])
  k <- ij+1
  mmname[k] = paste0(mm[jj],"_sd")
  ij <- ij+2
}

# note: add likelihood ratio under the main table

#+++++++++  Final Output
garchresult <- cbind(mmname,mresult)

#End