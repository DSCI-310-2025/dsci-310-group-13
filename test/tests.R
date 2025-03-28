# To run tests: `Rscript -e "library(testthat); test_dir('test')"`
# To run tests: `Rscript test/tests.R`


# Load testing framework
library(testthat)

# source("../R/functions.R")
source("R/functions.R")

# Create a dummy data frame to simulate Excel data
dummy_data <- data.frame(
  STG = c("A", "B", "C", NA),
  PEG = c(1, 2, 3, 4),
  UNS = c("Very Low", "Low", "High", "Middle"),
  stringsAsFactors = FALSE
)

test_that("create_train_data converts 'Very Low' correctly and drops NAs", {
  cleaned <- create_train_data(dummy_data)

  # Check that "Very Low" is replaced with "very_low"
  expect_true("very_low" %in% cleaned$UNS)

  # Check that no NA rows remain
  expect_false(any(is.na(cleaned)))

  # Check that columns selected are only STG, PEG, and UNS
  expect_equal(names(cleaned), c("STG", "PEG", "UNS"))

  # Check that UNS is an ordered factor with specified levels
  expect_true(is.ordered(cleaned$UNS))
  expect_equal(levels(cleaned$UNS), c("very_low", "Low", "Middle", "High"))
})

test_that("create_test_data works similarly to clean_train_data", {
  cleaned <- create_test_data(dummy_data)

  # Check that "Very Low" is replaced with "very_low"
  expect_true("very_low" %in% cleaned$UNS)

  # Check that no NA rows remain
  expect_false(any(is.na(cleaned)))

  # Check that columns selected are only STG, PEG, and UNS
  expect_equal(names(cleaned), c("STG", "PEG", "UNS"))

  # Check that UNS is an ordered factor with specified levels
  expect_true(is.ordered(cleaned$UNS))
  expect_equal(levels(cleaned$UNS), c("very_low", "Low", "Middle", "High"))
})

# Create a temporary file path for testing
temp_file <- tempfile(fileext = ".csv")

test_that("create_summary_table creates a CSV with the first 6 rows", {
  # Create a test data frame with more than 6 rows
  test_data <- data.frame(
    STG = 1:10,
    PEG = 11:20,
    UNS = factor(rep(c("very_low", "Low"), 5),
      levels = c("very_low", "Low", "Middle", "High"),
      ordered = TRUE
    )
  )

  # Call the function
  result <- create_summary_table(test_data, temp_file)

  # Check that the result has 6 rows and the file exists
  expect_equal(nrow(result), 6)
  expect_true(file.exists(temp_file))

  # Read the file back and check its content
  read_data <- read_csv(temp_file, show_col_types = FALSE)
  expect_equal(nrow(read_data), 6)
  expect_equal(read_data$STG, 1:6)
})

test_that("create_percentage_table calculates correct percentages", {
  # Create a test data frame with known distribution
  test_data <- data.frame(
    STG = 1:10,
    PEG = 11:20,
    UNS = factor(c(rep("very_low", 4), rep("Low", 3), rep("Middle", 2), "High"),
      levels = c("very_low", "Low", "Middle", "High"),
      ordered = TRUE
    )
  )

  # Call the function
  result <- create_percentage_table(test_data, temp_file)

  # Check that the result has the correct structure
  expect_equal(names(result), c("UNS", "count", "percentage"))
  expect_equal(nrow(result), 4) # One row for each UNS level

  # Check the counts, percentages, and file existence
  expect_equal(result$count, c(4, 3, 2, 1))
  expect_equal(result$percentage, c(40, 30, 20, 10))
  expect_true(file.exists(temp_file))

  # Read the file back and check its content
  read_data <- read_csv(temp_file, show_col_types = FALSE)
  expect_equal(nrow(read_data), 4)
  expect_equal(read_data$count, c(4, 3, 2, 1))
  expect_equal(read_data$percentage, c(40, 30, 20, 10))
})

# Clean up the temporary file after tests
file.remove(temp_file)

# testing rename_column function
# Create a sample dataframe
df <- data.frame(
  old_name = c(1, 2, 3),
  other_col = c("A", "B", "C")
)

test_that("rename_column renames columns correctly", {
  # Apply the function
  df_renamed <- rename_column(df, "old_name", "new_name")

  # Check that the new column name exists
  expect_true("new_name" %in% colnames(df_renamed))

  # Check that the old column name no longer exists
  expect_false("old_name" %in% colnames(df_renamed))

  # Check that the data remains unchanged
  expect_equal(df_renamed$new_name, c(1, 2, 3))
  expect_equal(df_renamed$other_col, c("A", "B", "C"))
})
