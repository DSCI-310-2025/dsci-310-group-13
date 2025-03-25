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

source("R/functions.R")

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

# Table 5
knowledge_train_summary <- knowledge_train_data %>%
  group_by(UNS) %>%
  summarize(
    count = n(),
    mean_STG = mean(STG),
    mean_PEG = mean(PEG),
    max_STG = max(STG),
    max_PEG = max(PEG),
    min_STG = min(STG),
    min_PEG = min(PEG)
  )
knowledge_train_summary
write_csv(knowledge_train_summary, table5_path)

# Figure 1
options(repr.plot.width = 10, repr.plot.height = 6)
knowledge_train_plot <- knowledge_train_data %>%
  ggplot(aes(x = STG, y = PEG, colour = UNS)) +
  labs(
    x = "Degree of study time",
    y = "Exam performance",
    colour = "Knowledge Level of Users"
  ) +
  geom_point() +
  theme(text = element_text(size = 20))
knowledge_train_plot
ggsave(filename = figure1_path, plot = knowledge_train_plot, width = 6, height = 4, dpi = 300)
