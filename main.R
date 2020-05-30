# working directory
wd <- list()

ipak <- function(pkg){
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  if (length(new.pkg)) 
    install.packages(new.pkg, dependencies = TRUE)
  sapply(pkg, require, character.only = TRUE)
}

# Download data from Yahoo finance

# Setup data and calculate daily return

# Generate summary table
df <- readRDS(file = "Datafiles/dataset_clean.rds")

# Generate table 1

# commonly used paths in my working directory
wd$data   <- "D:/git/icr/data/"
wd$output <- "D:/git/icr/output/"

lib <- modules::use("R")
dat <- read.csv("data/some.csv")

# munging
dat <- lib$munging$clean(dat)
dat <- lib$munging$recode(dat)

# generate results
lib$graphics$barplot(dat)
lib$graphics$lineplot(dat)