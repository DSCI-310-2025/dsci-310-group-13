# This file is responsible for loading and saving the data for this project

# Begin by installing necessary packages
install.packages("rlang")
install.packages("tidymodels")
install.packages("kknn")
install.packages("knitr")
install.packages("rmarkdown")
install.packages("yaml")
install.packages("MASS")
install.packages("reshape2")
install.packages("ggplot2")
install.packages("caret")

# Load in necessary libraries
library(kknn)
library(tidyverse)
library(repr)
library(tidymodels)
library(readxl)
library(knitr)
library(rmarkdown)
library(MASS)
library(ggplot2)
library(caret)

# Download the data 
url <- "https://archive.ics.uci.edu/ml/machine-learning-databases/00257/Data_User_Modeling_Dataset_Hamdi%20Tolga%20KAHRAMAN.xls"
data_file <- "data/data.xls"
download.file(url, data_file, mode = 'wb')