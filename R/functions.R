create_train_data <- function(knowledge_train_data) {
    # convert necessary targets to correct format
    knowledge_train_data[knowledge_train_data == "Very Low"] <- "very_low"

    # Let targets be ordered factors, select correct columns, drop NA values
    knowledge_train_data <- knowledge_train_data %>%
        mutate(UNS = factor(UNS, 
                            levels = c("very_low", "Low", "Middle", "High"), 
                            ordered = TRUE)) %>%
        dplyr::select(STG, PEG, UNS) %>%
        drop_na()
    return(knowledge_train_data)
}

create_test_data <- function(knowledge_test_data) {
    # convert necessary targets to correct format
    knowledge_test_data[knowledge_test_data == "Very Low"] <- "very_low"

    # Let targets be ordered factors, select correct columns, drop NA values
    knowledge_test_data <- knowledge_test_data %>%
        mutate(UNS = factor(UNS, 
                            levels = c("very_low", "Low", "Middle", "High"), 
                            ordered = TRUE)) %>%
        dplyr::select(STG, PEG, UNS) %>%
        drop_na()
    return(knowledge_test_data)
}


rename_column <- function(df, current_column_name, new_column_name) {
  # Use dplyr::rename with !!sym for non-standard evaluation
  df <- df %>%
    dplyr::rename(!!new_column_name := !!rlang::sym(current_column_name))
  return(df)
}
