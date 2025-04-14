# validation/validate_data.R

# Load required packages
library(pointblank)
library(readxl)
library(dplyr)

# 1. Load the data
# Note: You can adjust the path or add this as a command line argument
data_path <- "./data/clean/data.xls"
knowledge_train_data <- read_excel(data_path, sheet = 2) # sheet 2: training data

# 2. Create agent
agent <- create_agent(tbl = knowledge_train_data, tbl_name = "Knowledge Training Data")

# 3. Validation checks

## (1) Correct column names
expected_columns <- c("STG", "PEG", "UNS")
actual_columns <- colnames(knowledge_train_data)
if (!all(expected_columns %in% actual_columns)) {
  stop("One or more required columns (STG, PEG, UNS) are missing.")
}

## (2) No empty observations (i.e., check all cols not null)
agent <- agent %>%
  col_vals_not_null(vars(STG, PEG, UNS))

## (3) Correct data types
agent <- agent %>%
  col_is_numeric(vars(STG, PEG)) %>%
  col_is_factor(vars(UNS))

## (4) No duplicate observations
agent <- agent %>%
  rows_distinct()

## (5) No outlier or anomalous values (assuming valid range is 0–20 for STG/PEG)
agent <- agent %>%
  col_vals_between(STG, left = 0, right = 20) %>%
  col_vals_between(PEG, left = 0, right = 20)

## (6) Correct category levels (no typos/singletons)
agent <- agent %>%
  col_vals_in_set(UNS, set = c("very_low", "Low", "Middle", "High"))

## (7) Missingness not beyond threshold
# (We just flag columns if missing > 10%)
missing_pct <- sapply(knowledge_train_data, function(x) mean(is.na(x)))
if (any(missing_pct > 0.1)) {
  warning("One or more columns have >10% missing values.")
}

## (8) Target/response variable follows expected distribution
# This is for manual review – plot or use Shapiro-Wilk for normality
hist(knowledge_train_data$PEG, main = "PEG Distribution", xlab = "PEG")

# 4. Run interrogation
agent <- agent %>% interrogate()

# 5. Print summary to console
print(agent)

# 6. Save validation report as HTML
export_report(agent, filename = "./validation/validation_report.html")
