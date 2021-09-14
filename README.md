# Wearable Computing - A Data Cleaning Project

## Overview
In this project, I take data from UCI's Machine Learning data repository about "Human Activity Recognition Using 
Smartphones". Since the data is in a raw form, my objective is to edit and clean up the dataset so that it is
tidy and easy to read.

## What's contained in each of the files?

### UCI
This is the folder containing the raw data from the UCI Machine Learning data repository. It has multiple folders
containing training and test data with sensor outputs and files with metadata. Two important identifiers in this dataset
is the activity and the subject -- the activity describes the form of physical activity (sitting, walking, etc.) and 
subject is a number from 1-30 that corresponds to the test subject that the examination was performed on.

### run_analysis.R
This file consists of the entire script I used to convert the raw data into a tidy dataset. First, I read in all 
of the data and set their column names to something more understandable. Then, I merged the training and test data
to make one large dataset using rbind() and cbind(). Since we are only interested in the mean and standard deviation,
I selected the columns containing "mean" and "std" in the name of the column. After that, I gave meaningful column
names to the data using gsub() and wrote that table out to "mean_std.txt". I further tidied the dataset by grouping
the entries by activity and subject and then finding the average for each of the activities and subjects. I wrote this
fully tidied dataset out to "avg_subject_activity.txt".

### mean_std.txt
This .txt file contains the table with mean and standard deviation sensor output data and meaningful column names (outputted by run_analysis.R)

### avg_subject_activity.txt
This .txt file contains the fully tidied table that has the averages for each activity and subject.
