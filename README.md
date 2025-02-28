TODO: Things to include in readme.md (TODO list should be delete after all tasks have been done.)

- the project title -- done
- the list of contributors/authors -- done
- a short summary of the project (view from 10,000 feet) -- done
- how to run your data analysis
- a list of the dependencies needed to run your analysis -- done
- the names of the licenses contained in LICENSE.md -- done

# Predicting Student Exam Performance Bsed on Study Habits

### DSCI 310 Group Project

#### Group 13 -- Adam Walmsley, Morgan Dean, Tracy Wang, Yuexiang Ni

## Introduction

The ability to predict student exam performance based on study habits is crucial for understanding effective learning strategies. This project examines how factors like study time (STG), study repetition (SCG), and study engagement with related objects (STR) influence a student's exam performance (LPR and PEG).

Using the User Knowledge Modeling Dataset, which contains exam performance data for students based on their study behaviors, we aim to develop a regression model to predict exam scores. This approach helps identify the most significant study habits contributing to higher performance.

By analyzing these relationships, our study can provide recommendations for students and educators on optimizing study methods to improve learning outcomes.

### Research Question
>
> Can we predict a student's exam performance (LPR or PEG) based on their study time and repetition (STG, SCG, STR)?

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

## How to Run the Data Analysis

**needed to be filled**

## Dependencies

The following R libraries are installed by `renv:init()` for the analysis:

```r
library(tidyverse)  # Data manipulation and visualization
library(readxl)     # Reading Excel files
library(repr)       # Adjusting Jupyter Notebook output format
library(tidymodels) # Machine learning modeling
```

## License

- MIT License
  - For license information, refer to `LICENSE.md`.  
