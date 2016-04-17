# run_analysis.R Code Book

## Introduction

This code book describes the data, variables, and transformations used to
complete the course project for Getting and Cleaning Data. The goal of the 
project was to create `run_analysis.R`, an R script that performs the
following:

1. Merges source data files to create one data set
2. Extracts only measurements on the mean and standard deviation for each measurement.
3. Applies descriptive activity names to the activities in the data set
4. Labels the data set with descriptive variable names and factors
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Input Data

The input data for the R script is from the Human Activity Recognition (HAR) Using Smartphones Data Set [1] available through UC Irvine's Machine Learning Repository. The HAR data contains smartphone (Samsung Galaxy S II) readings from a group of 30 volunteers who performed six activities (i.e., walking, walking upstairs, walking downstairs, sitting, standing, laying) while wearing the smartphone. The measurements collected were 3-axial linear acceleration and 3-axial angular velocity from an accelerometer and a gyroscope embedded in the smartphone. Seventy-percent of the volunteers were selected for a training phase and 30-percent were selected for a testing phase. More information about the data can be found at: (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

The input data were downloaded from UC Irvine's Machine Learning Repository on Saturday, April 16, 2016 using R Studio (Version 0.99.879). Data were downloaded directly into `./data/`.

The following downloaded files needed to run run_analysis.R:

`features.txt`: A list of all measurement variables
`activity_labels.txt`: A list activity id numbers and the corresponding label
`X_train.txt`: Measurements from the training condition
`y_train.txt`: A list of activity id numbers associated with the training measurements
`subject_train.txt`: A list of id numbers for the subjects who performed activities in the training condition. 
`X_test.txt`: Measurements from the testing condition.
`y_test.txt.`: A list of activity id numbers associated with the training measurements
`subject_test.txt`: A list of id numbers for the subjects who performed activities in the testing condition.  

## Required R Packages

The following R packages were used to do the transformations described below and are required to run the `run_analysis.R` script: `reshape2` `plyr`

The packages can be installed using: `install.packages("reshape2")`
                                     `install.packages("plyr")`

## Transformations

Reads the files described above in the "Input Data" section into R

Subsets mean and standard deviation measures from `X_train.txt` and `X_test.txt`

Uses `mutate` to create a flag in `X_train.txt` and `X_test.txt` in order to identify training and testing data when the two are later merged

Uses 'rbind' to combine training files with the corresponding test file: `X_train.txt` and `X_test.txt`; `y_train.txt` and `y_test.txt`; `subject_train.txt` and `subject_test.txt`

Applies activity labels in `activity_labels.txt` to `y_train.txt` and `y_test.txt`

Cleans column names and replaces existing names with descriptive names using `gsub`
  For example: `t` was replaced with `time.`

Merges all files into one data frame

Uses `mutate` to create five new columns: `measurement`, `variable`, `axis.signal`, `estimation` and `value`.

Uses `grep` and `gsub` to split measurement variables into the newly created columns as factor variables. 
  For example: the column label `frequency.body.accelerometer.mean.x` was split as `frequency`, `body.accelerometer`, `mean`, `x`; these strings went into    the `measurement`, `variable`, `estimation`, and `axis.signal` columns, respectively. The   value under `frequency.body.accelerometer.mean.x` was moved to   the `value` column.

Uses `ddply` to create a second data set with the average of each variable for each activity and subject.

Creates a .txt file for second data set mentioned above.

## Output Data

`run_analysis.R` creates the following:

  `complete_data`: A data frame in R containing mean and standard deviation 
                   measurements from the HAR source data 

  `tidy_data`: A data frame in R averaging the measurements in complete_data
               for each activity and each subject
                 
  `tidy_UCI_HAR.txt`: A text file version of the tidy_data data frame that the 
                      script saves in the working directory

## Variables

`subject': This is an integer id assigned to each subject. It ranges from 1 to 30.

`run`: This is a character string indicating whether the observation is from the training or test measurements. This variable has two categories: `training` and `test`. 

`activity`: This is a character string indicating the activity performed. This variable has six categories: 

`walking`, `walking_ustairs`, `walking_downstairs`, `sitting`, `standing`, `laying`. 

`measurement`: This is a character string indicating what was being measured by the smartphone. This variable has two categories: `time` and `frequency`.

`variable`: This is a character string indicating the measurement tool. Measurements came from accelerometer and gyroscope 3-axial raw signals. This variable has five categories: `body.accelerometer`, `body.accelerometer.jerk`, `body.gyroscope`, `body.gyroscope.jerk`, and `gravity.accelerometer`.

`axis.signal`: This is a character string indicating the axial signal. `x`, `y`, or `z` denote signals in the x, y, or z directions, respectively. `magnitude` denotes the magnitude of the three signals. This variable has four categories: `x`, `y`, `z`, and `magnitude`.

`estimation`: This is a character string indicating the estimation method (i.e., mean or standard deviation) of the oberservation. This variable has two categories: `mean` and `std`.

`average.value`: This is a numeric field indicating the mean of all observations for each measurement, grouped by subject and activity.  

## References

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. 
Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using 
Smartphones. 21th European Symposium on Artificial Neural Networks, Computational 
Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013.
