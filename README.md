## Coursera | Getting and Cleaning Data Course Project

This is the course project for Getting and Cleaning Data using Human Activity
Recognition (HAR) Using Smartphones Data Set [1] available through UC Irvine's 
Machine Learning Repository.

This README file contains information about the files available in the 
repository.

The repository contains, `run_analysis.R`, an R script that performs the
following:

1. Merges the training and test sets to create on data set
2. Extracts only measurements on the mean and standard deviation for each
   measurement.
3. Applies descriptive activity names to the activities in the data set
4. Labels the data set with descriptive variable names and factors
5. Creates a second, independent tidy data set with the average of each variable 
   for each activity and each subject.

The output of run_analysis.R is described below:

  `complete_data`: A data frame in R containing mean and standard deviation 
                   measurements from the HAR source data 

  `tidy_data`: A data frame in R averaging the measurements in complete_data
               for each activity and each subject
                 
  `tidy_UCI_HAR.txt`: A text file version of the tidy_data data frame that the 
                      script saves in the working directory
                    

The repository also contains `CodeBook.md`, an R markdown file that describes 
the data, variables, and transformations done to the original data.

## Downloaded Data

The data used in this project were downloaded from the URL below.

(https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

The data should be stored in a subfolder of the working directory called "Data". 
The following code will create a data subfolder, if needed, and set it as the working directory:

```{r}
if(!dir.exists("Data")) {
  dir.create("Data")
}
```

```{r}
setwd("./Data")
```

## Required R Packages

The following R packages are required to run the script: `reshape2` `plyr`

The packages can be installed using: `install.packages("reshape2")`
                                     `install.packages("plyr")`
                                     
## References

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. 
Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using 
Smartphones. 21th European Symposium on Artificial Neural Networks, Computational 
Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013.