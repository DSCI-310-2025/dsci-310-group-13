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

"This script models the results and presents the findings

Usage: 04_modelling.R --file_path=<file_path> --table6=<table6_path> --table7=<table7_path> --fig2=<figure2_path> --fig3=<figure3_path>
" -> doc

# Rscript 04_modelling.R --file_path="../data/clean/data.xls" --table6="../results/table6.txt" --table7="../results/table7.txt" --fig2="../results/fig2.png" --fig3="../results/fig3.png"

opt <- docopt::docopt(doc)

# Assign url
file_path <- opt$file_path

# Assign output path
table6_path <- opt$table6

table7_path <- opt$table7

figure2_path <- opt$fig2

figure3_path <- opt$fig3

# Reload the knowledge train and test data
knowledge_train_data <- read_excel(file_path, 2)
knowledge_test_data <- read_excel(file_path, 3)
knowledge_test_data[knowledge_test_data == "Very Low"] <- "very_low"

knowledge_train_data <- knowledge_train_data %>%
    mutate(UNS = factor(UNS, 
                        levels = c("very_low", "Low", "Middle", "High"), 
                        ordered = TRUE)) %>%
    dplyr::select(STG, PEG, UNS) %>%
    drop_na()

knowledge_test_data <- knowledge_test_data %>%
    mutate(UNS = factor(UNS, 
                        levels = c("very_low", "Low", "Middle", "High"), 
                        ordered = TRUE)) %>%
    dplyr::select(STG, PEG, UNS) %>%
    drop_na()

# Fitting the model
ordinal_model <- polr(UNS ~ STG + PEG, data = knowledge_train_data, Hess = TRUE)

# Table 6
model_summary <- capture.output(summary(ordinal_model))

writeLines(model_summary, con = table6_path)

# Predict on test data
predicted_classes <- predict(ordinal_model, newdata = knowledge_test_data)
predicted_classes <- factor(predicted_classes, 
                            levels = levels(knowledge_test_data$UNS), 
                            ordered = TRUE)


# Table 7
# Model accuracy
accuracy_output <- capture.output(mean(predicted_classes == knowledge_test_data$UNS))
writeLines(accuracy_output, con = table7_path)

# Confusion matrix

predicted_classes <- predict(ordinal_model, newdata = knowledge_test_data)

predicted_classes <- factor(predicted_classes, levels = levels(knowledge_test_data$UNS))

conf_matrix <- table(Predicted = predicted_classes, Actual = knowledge_test_data$UNS)

conf_matrix_df <- as.data.frame(conf_matrix)

confusion_plot <- ggplot(conf_matrix_df, aes(x = Actual, y = Predicted, fill = Freq)) +
  geom_tile() +
  geom_text(aes(label = Freq), color = "white", size = 5) +
  scale_fill_gradient(low = "lightblue", high = "darkblue") +
  labs(title = "Confusion Matrix of Ordinal Logistic Regression",
       x = "Actual UNS Category",
       y = "Predicted UNS Category") +
  theme_minimal()

# Figure 2

ggsave(filename = figure2_path, plot = confusion_plot, width = 6, height = 4, dpi = 300)


odds_ratios <- exp(coef(ordinal_model)) 

feature_importance <- data.frame(
  Feature = names(odds_ratios),
  Importance = odds_ratios
)

feature_importance_plot <- ggplot(feature_importance, aes(x = Feature, y = Importance, fill = Feature)) +
  geom_bar(stat = "identity") +
  labs(title = "Feature Importance in Ordinal Logistic Regression",
       y = "Odds Ratio (Feature Importance)") +
  theme_minimal() +
  scale_fill_viridis_d()

ggsave(filename = figure3_path, plot = feature_importance_plot, width = 6, height = 4, dpi = 300)
