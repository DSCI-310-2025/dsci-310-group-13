library(readr)
library(dplyr)

#' Prepare training data for knowledge level analysis
#'
#' This function prepares the training data by standardizing the knowledge level
#' categories, converting UNS to an ordered factor, selecting only the relevant
#' columns (STG, PEG, UNS), and removing any rows with NA values.
#'
#' @param knowledge_train_data A data frame containing the raw training data
#'   with at least STG, PEG, and UNS columns
#'
#' @return A cleaned data frame with standardized UNS levels as ordered factors
#' @export
#'
#' @examples
#' \dontrun{
#' # Load raw data from Excel
#' raw_data <- read_excel("data/data.xls", 2)
#' 
#' # Prepare the training data
#' clean_data <- create_train_data(raw_data)
#' }
create_train_data <- function(knowledge_train_data) {
    # convert necessary targets to correct format
    knowledge_train_data[knowledge_train_data == "Very Low"] <- "very_low"

    # Let targets be ordered factors, select correct columns, drop NA values
    knowledge_train_data <- knowledge_train_data %>%
        mutate(UNS = factor(UNS,
            levels = c("very_low", "Low", "Middle", "High"),
            ordered = TRUE
        )) %>%
        dplyr::select(STG, PEG, UNS) %>%
        drop_na()
    return(knowledge_train_data)
}

#' Prepare test data for knowledge level analysis
#'
#' This function prepares the test data by standardizing the knowledge level
#' categories, converting UNS to an ordered factor, selecting only the relevant
#' columns (STG, PEG, UNS), and removing any rows with NA values.
#'
#' @param knowledge_test_data A data frame containing the raw test data
#'   with at least STG, PEG, and UNS columns
#'
#' @return A cleaned data frame with standardized UNS levels as ordered factors
#' @export
#'
#' @examples
#' \dontrun{
#' # Load raw data from Excel
#' raw_data <- read_excel("data/data.xls", 3)
#' 
#' # Prepare the test data
#' clean_data <- create_test_data(raw_data)
#' }
create_test_data <- function(knowledge_test_data) {
    # convert necessary targets to correct format
    knowledge_test_data[knowledge_test_data == "Very Low"] <- "very_low"

    # Let targets be ordered factors, select correct columns, drop NA values
    knowledge_test_data <- knowledge_test_data %>%
        mutate(UNS = factor(UNS,
            levels = c("very_low", "Low", "Middle", "High"),
            ordered = TRUE
        )) %>%
        dplyr::select(STG, PEG, UNS) %>%
        drop_na()
    return(knowledge_test_data)
}


# Table functions

#' Create a summary table with the first 6 rows of data
#'
#' This function takes a data frame and creates a summary table by selecting
#' the first 6 rows. It then writes this summary to a CSV file
#' at the specified path.
#'
#' @param data A data frame containing the data to summarize
#' @param path A string specifying the file path where the CSV will be saved
#'
#' @return The head of the data frame (first 6 rows) invisibly
#' @export
#'
#' @examples
#' \dontrun{
#' # Create a summary table of the knowledge_train_data
#' create_summary_table(knowledge_train_data, "results/table1.csv")
#' }
create_summary_table <- function(data, path) {
    result <- head(data, 6)
    write_csv(result, path)
    return(invisible(result))
}

#' Create a percentage table grouped by knowledge level (UNS)
#'
#' This function calculates the count and percentage of observations for each
#' knowledge level (UNS) category in the provided data. It then writes this
#' summary to a CSV file at the specified path.
#'
#' @param data A data frame containing a UNS column with knowledge levels
#' @param path A string specifying the file path where the CSV will be saved
#'
#' @return A data frame with columns for UNS, count, and percentage
#' @export
#'
#' @examples
#' \dontrun{
#' # Create a percentage table for knowledge levels in training data
#' create_percentage_table(knowledge_train_data, "results/table3.csv")
#' }
create_percentage_table <- function(data, path) {
    num_obs <- nrow(data)
    result <- data %>%
        group_by(UNS) %>%
        summarize(
            count = n(),
            percentage = n() / num_obs * 100
        )
    write_csv(result, path)
    return(invisible(result))
}
