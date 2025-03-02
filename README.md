TODO: Things to include in readme.md (TODO list should be delete after all tasks have been done.)

- the project title -- done
- the list of contributors/authors -- done
- a short summary of the project (view from 10,000 feet) -- done
- how to run your data analysis
- a list of the dependencies needed to run your analysis -- done
- the names of the licenses contained in LICENSE.md -- done

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

## How to Run the Data Analysis

### **Option 1: Using Docker (Recommended)**

1. **Pull the latest pre-built Docker image from Docker Hub:**
   ```bash
   docker pull tracywxr/dsci310-project:latest
   ```

To run the data analysis, follow these steps:

1. Clone the repository to your local machine:
```bash
git clone https://github.com/DSCI-310-2025/dsci-310-group-13.git
cd dsci-310-group-13/
```

2. Run the container with RStudio (default password: password)
```bash
docker run -p 8787:8787 -e PASSWORD=password tracywxr/dsci310-project
```
- This will start an RStudio Server at http://localhost:8787
- Login using:
  - Username: `rstudio`
  - Password: `password`

3. Run the Analysis
- Open `analysis.qmd` in RStudio
- Run the analysis inside RStudio

4. (Optional) Using Docker Compose If you prefer Docker Compose, run:
```bash
docker-compose up
```
This will automatically start the container.

### **Option 2: Running Locally (without Docker)**
1. Clone the repository to your local machine:
```bash
git clone https://github.com/DSCI-310-2025/dsci-310-group-13.git
cd dsci-310-group-13/
```

2. Open R or RStudio, and navigate to the project directory.

3. Activate the R environment by running:
```bash
renv::restore()
```
This will install all necessary dependencies listed in `renv.lock`.

4. Run the analysis script:
- Open analysis.qmd in RStudio
- Run the analysis inside RStudio

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

### Intialize R

1. Open the R repl.

```bash
# In the terminal
R
```

2. Initialize renv.

```R
# In the R repl.
renv::init()
```

3. Write code in `analysis.qmd`

## License

- MIT License
  - For license information, refer to `LICENSE.md`.  
