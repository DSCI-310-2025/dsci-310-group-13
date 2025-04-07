# Predicting Student Exam Performance Based on Study Habits

## Contributors

This project is developed by **Group 13** as part of the DSCI 310 course:

- **Adam Walmsley**
- **Morgan Dean**
- **Tracy Wang**
- **Yuexiang Ni**

## Introduction

The ability to predict student exam performance based on study habits is crucial for understanding effective learning strategies. This project examines how factors like **study time (STG)**, **study repetition (SCG)**, and **study engagement** with **related objects (STR)** influence a **student's exam performance (LPR and PEG)**. The original data set can be found online [here]("https://archive.ics.uci.edu/ml/machine-learning-databases/00257/Data_User_Modeling_Dataset_Hamdi%20Tolga%20KAHRAMAN.xls").

Using the **User Knowledge Modeling Dataset**, which contains exam performance data for students based on their study behaviors, we aim to develop a regression model to predict exam scores. This approach helps identify the most significant study habits contributing to higher performance.

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

- This will start an RStudio Server at <http://localhost:8787>
- Login using:
  - Username: `rstudio`
  - Password: `password`

3. **Run the analysis**

- In the container terminal, run:

   ```bash
   make all
   ```

  - For more details and explanations, see the **Makefile** section below.
- If you run into issues, reset the data and start over by running:

   ```bash
   make clean
   ```

4. **View the outputted report**

- HTML Report: `reports/student_exam_performance.html`
- PDF  Report: `reports/student_exam_performace.pdf`

### **Option 2: Running Locally (without Docker)**

1. **Clone the repository to your local machine**:

   ```bash
   git clone https://github.com/DSCI-310-2025/dsci-310-group-13.git
   cd dsci-310-group-13/
   ```

2. **Open R or RStudio, and navigate to the project directory.**

3. **Set up the R environment**:

- Install dependencies using R `renv`

   ```r
   renv::restore()
   ```

- This will install all necessary dependencies listed in `renv.lock`.

4. **Run the analysis**:

```bash
make all
```

## Data Analysis Pipeline

This project includes several **R scripts** in the `scripts/` directory that handle different stages of the data analysis pipeline. Below are instructions for running each script.

### 1. Data Loading (`01_load.R`)

Download the dataset from a URL and saves it locally.

**Usage:**

```R
Rscript scripts/01_load.R --url="https://archive.ics.uci.edu/ml/machine-learning-databases/00257/Data_User_Modeling_Dataset_Hamdi%20Tolga%20KAHRAMAN.xls" --output_path="data/data.xls"
```

**Parameters:**

- `--url`: URL to download the dataset from
- `--output_path`: Path where the downloaded file will be saved

### 2. Data Cleaning (`02_read-clean.R`)

Reads, cleans and formats the data for further analysis.

**Usage:**

```R
Rscript scripts/02_read-clean.R --file_path="data/data.xls" --output_path="data/clean/data.xls"
```

**Parameters:**

- `--file_path`: Path to the input data file
- `--output_path`: Path where the cleaned data will be saved

### 3. Exploratory Data Analysis (`03_eda.R`)

Performs exploratory data analysis and generates tables and visualizations.

**Usage:**

```R
Rscript scripts/03_eda.R --file_path="data/clean/data.xls" --table1="results/table1.csv" --table2="results/table2.csv" --table3="results/table3.csv" --table4="results/table4.csv" --table5="results/table5.csv" --fig1="results/fig1.png"
```

**Parameters:**

- `--file_path`: Path to the cleaned data file
- `--table1` to `--table5`: Paths where the generated tables will be saved
- `--fig1`: Path where the generated figure will be saved

### 4. Modeling (`04_modelling.R`)

Builds and evaluates a predictive model, generating result tables and visualizations.

**Usage:**

```R
Rscript scripts/04_modelling.R --file_path="data/clean/data.xls" --table6="results/table6.txt" --table7="results/table7.txt" --fig2="results/fig2.png" --fig3="results/fig3.png"
```

**Parameters:**

- `--file_path`: Path to the cleaned data file
- `--table6` and `--table7`: Paths where the model results tables will be saved
- `--fig2` and `--fig3`: Paths where the model visualization figures will be saved

## **Makefile***

This project uses a **Makefile** to automate the data pipline.

### Run the full analysis

To execute the full workflow, run:

```bash
make all
```

This will:

1. Download the dataset.
2. Clean and preprocess the data.
3. Perform exploratory data analysis.
4. Train and evaluate the model.
5. Render the final reports.

### Clean the project directory

To remove all generated files, run:

```bash
make clean
```

This will delete:

- Downloaded data (`data/`)
- Generated tables & figures (`results/`)
- Reports (`reports/out/`)

## Dependencies

The following `R libraries` are installed automatically via **renv**:

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
library(docopt)
```

## Development and Collaboration

### Using Docker Compose for Development

Start docker development environment

```bash
docker compose up -d
```

Then access RStudio at <http://localhost:8787> and work on the project.

### Working with Git

- Create a new branch before making changes:
- After completing work, push and create a Pull Request(PR).

### Running Tests

To run the tests to make sure that existing functions work as intended, run the following command from the working directory.

```bash
 Rscript -e "library(testthat); test_dir('test')"
```

## License

- This project is licensed under the **MIT License**.
  - For license information, refer to `LICENSE.md`.
- All non-code items are under the **Creative Commons License 4.0**
  - <a href="https://creativecommons.org/licenses/by/4.0/"><img src="https://mirrors.creativecommons.org/presskit/buttons/88x31/png/by.png" alt="CC" width="88" height="34"></a>
