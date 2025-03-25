# To run test open a new R terminal, run library(testthat), then run test_dir("test")

###Yuexiang: I ran this into error - cannot open file '../R/functions.R': No such file or directory
###source("../R/functions.R")

###Yuexiang: and this worked for me
###message to the next person, please delete the one source that doesn't work
source("R/functions.R")

library(testthat)
library(dplyr)
library(tidyr)

###rlang package may be necessary for rename_column function, if not, please delete this chunk of code
###library(rlang)


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


#testing rename_column function
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
