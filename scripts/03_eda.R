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
library(docopt)
library(testthat)
library(examperformancetools)

"This script reads and cleans the data

Usage: 03_eda.R --file_path=<file_path> --table1=<table1_path> --table2=<table2_path> --table3=<table3_path> --table4=<table4_path> --table5=<table5_path> --fig1=<figure1_path>
" -> doc

# Rscript 03_eda.R --file_path="../data/clean/data.xls" --table1="../results/table1.csv" --table2="../results/table2.csv" --table3="../results/table3.csv" --table4="../results/table4.csv" --table5="../results/table5.csv" --fig1="../results/fig1.png"



opt <- docopt::docopt(doc)

file_path <- opt$file_path
table1_path <- opt$table1
table2_path <- opt$table2
table3_path <- opt$table3
table4_path <- opt$table4
table5_path <- opt$table5
figure1_path <- opt$fig1

knowledge_train_data <- read_excel(file_path, 2)
knowledge_test_data <- read_excel(file_path, 3)


knowledge_train_data <- create_train_data(knowledge_train_data)
knowledge_test_data <- create_test_data(knowledge_test_data)


# Table 1
create_summary_table(knowledge_train_data, table1_path)

# Table 2
create_summary_table(knowledge_test_data, table2_path)

# Table 3
create_percentage_table(knowledge_train_data, table3_path)

# Table 4
create_percentage_table(knowledge_test_data, table4_path)

# Table 5 - use create_uns_summary_table function
create_uns_summary_table(knowledge_train_data, table5_path)

# Figure 1 - use plot_stg_vs_peg_scatter function
plot_stg_vs_peg_scatter(knowledge_train_data, figure1_path)

