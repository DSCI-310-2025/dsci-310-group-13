# dsci-310-group-13
TODO: Things to include in readme.md
- the project title 

Title: Predicting Student Exam Performance Bsed on Study Habits

- the list of contributors/authors 

Authors: ##To be filled
Yuexiang Ni 
..
..
..


- a short summary of the project (view from 10,000 feet) 

Introduction

The ability to predict student exam performance based on study habits is crucial for understanding effective learning strategies. This project examines how factors like study time (STG), study repetition (SCG), and study engagement with related objects (STR) influence a student's exam performance (LPR and PEG).

Using the User Knowledge Modeling Dataset, which contains exam performance data for students based on their study behaviors, we aim to develop a regression model to predict exam scores. This approach helps identify the most significant study habits contributing to higher performance.

By analyzing these relationships, our study can provide recommendations for students and educators on optimizing study methods to improve learning outcomes.


- how to run your data analysis - a list of the dependencies needed to run your analysis 
- the names of the licenses contained in LICENSE.md




others:

Predictive Question: Can we predict a student's exam performance (LPR or PEG) based on their study time and repetition (STG, SCG, STR)?

#necessary R library to load for containerization

library(tidyverse)
library(readxl)
library(repr)
library(tidymodels)


