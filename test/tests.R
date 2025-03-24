# To run test open a new R terminal, run library(testthat), then run test_dir("test")

source("../R/functions.R")

library(testthat)
library(dplyr)
library(tidyr)

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

