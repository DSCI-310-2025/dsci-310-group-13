# Predicting Student Exam Performance Bsed on Study Habits

## Contributors

This project is developed by **Group 13** as part of the DSCI 310 course:

- **Adam Walmsley**
- **Morgan Dean**
- **Tracy Wang**
- **Yuexiang Ni**

## Introduction

The ability to predict student exam performance based on study habits is crucial for understanding effective learning strategies. This project examines how factors like study time (STG), study repetition (SCG), and study engagement with related objects (STR) influence a student's exam performance (LPR and PEG).

Using the User Knowledge Modeling Dataset, which contains exam performance data for students based on their study behaviors, we aim to develop a regression model to predict exam scores. This approach helps identify the most significant study habits contributing to higher performance.

By analyzing these relationships, our study can provide recommendations for students and educators on optimizing study methods to improve learning outcomes.

### Research Question

> Can we predict a student's exam performance (LPR or PEG) based on their study time and repetition (STG, SCG, STR)?

## Build Data Analysis

### **Option 1: Using Docker (Recommended)**

1. **Pull the latest pre-built Docker image from Docker Hub:**
   ```bash
   docker pull tracywxr/dsci310-project:latest
   ```

To run the data analysis, follow these steps:

2. **Run the container with RStudio**
   ```bash
   docker run -p 8787:8787 -e PASSWORD=password tracywxr/dsci310-project
   ```

- This will start an RStudio Server at http://localhost:8787
- Login using:
  - Username: `rstudio`
  - Password: `password`

3. **Make the analysis**

- Run `make all` in the container terminal to pull data, make tables, and build the quarto document.
- If you run into issues, run `make clean` to clean data directories and start from scratch.

4. **View the outputted report in `reports/student_exam_performance.html` or `reports/student_exam_perforamce.pdf`**

### **Option 2: Running Locally (without Docker)**

1. **Clone the repository to your local machine**:

   ```bash
   git clone https://github.com/DSCI-310-2025/dsci-310-group-13.git
   cd dsci-310-group-13/
   ```

2. **Open R or RStudio, and navigate to the project directory.**

3. **Activate the R environment by running**:

   ```bash
   renv::restore()
   ```

   This will install all necessary dependencies listed in `renv.lock`.

4. **Make the analysis**:

```bash
make all
```

## Dependencies

The following R libraries are installed by `renv:init()` for the analysis:

```r
library(kknn)       # K-Nearest Neighbors algorithm
library(tidyverse)  # Data manipulation and visualization
library(repr)       # Adjusting Jupyter Notebook output format
library(tidymodels) # Machine learning modeling
library(readxl)     # Reading Excel files
library(knitr)      # Dynamic report generation
library(rmarkdown)  # Markdown report generation
library(MASS)       # Statistical functions and modeling
library(ggplot2)    # Data visualization
library(caret)      # Classification and Regression Training
```

## Development

1. Start docker development environment

```bash
docker compose up -d
```

2. Access the RStudio instance in your browser at http://localhost:8787

3. Write code in `reports/student_exam_performance.qmd`

## License

- This project is licensed under the **MIT License**.
  - For license information, refer to `LICENSE.md`.
- All non-code items are under the **Creative Commons License 4.0**
  - [![CC](https://mirrors.creativecommons.org/presskit/buttons/88x31/png/by.png)](hhttps://creativecommons.org/licenses/by/4.0/ttp://google.com.au/)
