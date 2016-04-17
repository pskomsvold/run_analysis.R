##Create folder for data

if(!dir.exists("Data")) {
  dir.create("Data")
}

##Set working directory

setwd("./Data")

##Load packages

library(plyr)
library(reshape2)

##Read files

activity.lbls <- read.table("./UCI HAR Dataset/activity_labels.txt")
features <- read.table("./UCI HAR Dataset/features.txt")
train.set <- read.table("./UCI HAR Dataset/train/X_train.txt")
test.set <- read.table("./UCI HAR Dataset/test/X_test.txt")
train.lbl <- read.table("./UCI HAR Dataset/train/y_train.txt")
test.lbl <- read.table("./UCI HAR Dataset/test/y_test.txt")
train.sub <- read.table("./UCI HAR Dataset/train/subject_train.txt")
test.sub <- read.table("./UCI HAR Dataset/test/subject_test.txt")

##Subset mean and standard devation measures

colnames(train.set) <- tolower(features[, 2])
colnames(test.set) <- tolower(features[, 2])
test.set <- test.set[, grep("-mean\\(\\)|-std\\(\\)", colnames(test.set), 
                            value = TRUE)]
train.set <- train.set[, grep("-mean\\(\\)|-std\\(\\)", colnames(test.set), 
                              value = TRUE)]

##Create a flag for identifying traning/test data

train.set <- mutate(train.set, run = "training")
test.set <- mutate(test.set, run = "test")

##Combine train and test files

set <- rbind(train.set, test.set)
activity <- rbind(train.lbl, test.lbl)
subject <- rbind(train.sub, test.sub)

##Assign value labels to activity variable

activity <- as.numeric(activity$V1)
activity <- as.data.frame(factor(activity, labels = c("walking", 
              "walking_upstairs", "walking_downstairs", "sitting", "standing", 
              "laying")))

##Clean column names and replace with descriptive names

colnames(set) <- gsub("\\(\\)", "", names(set))
colnames(subject) <- "subject"
colnames(activity) <- "activity"
names(set) <- gsub("^t", "time.", names(set))
names(set) <- gsub("^f", "frequency.", names(set))
names(set) <- gsub("acc", ".accelerometer.", names(set))
names(set) <- gsub("gyro", ".gyroscope.", names(set))
names(set) <- gsub("bodybody", "body", names(set))
names(set) <- gsub("tbody", "time.body", names(set))
names(set) <- gsub("mag", "magnitude.", names(set))
names(set) <- gsub("jerk", "jerk.", names(set))
names(set) <- gsub("-mean", "mean", names(set))
names(set) <- gsub("-std", "std", names(set))
names(set) <- gsub("-x", ".x", names(set))
names(set) <- gsub("-y", ".y", names(set))
names(set) <- gsub("-z", ".z", names(set))

##Create one data file

data <- data.frame(subject, activity, set)

##Split measured variables into separate columns

complete_data <- melt(data, id = c("subject", "activity", "run"))
complete_data <- mutate(complete_data, measurement = 
                      as.character(complete_data$variable), 
                      axis.signal = as.character(complete_data$variable),
                      estimation = as.character(complete_data$variable))
complete_data[grep("time", complete_data$measurement), "measurement"] <- "time"
complete_data[grep("frequency", complete_data$measurement), "measurement"] <- "frequency"
complete_data[grep("\\.x", complete_data$axis.signal), "axis.signal"] <- "x"
complete_data[grep("\\.y", complete_data$axis.signal), "axis.signal"] <- "y"
complete_data[grep("\\.z", complete_data$axis.signal), "axis.signal"] <- "z"
complete_data[grep("magnitude", complete_data$axis.signal), "axis.signal"] <- "magnitude"
complete_data[grep("mean", complete_data$estimation), "estimation"] <- "mean"
complete_data[grep("std", complete_data$estimation), "estimation"] <- "std"

complete_data$variable <- gsub("time.", "", complete_data$variable)
complete_data$variable <- gsub("frequency.", "", complete_data$variable)
complete_data$variable <- gsub(".mean", "", complete_data$variable)
complete_data$variable <- gsub(".std", "", complete_data$variable)
complete_data$variable <- gsub("\\.y", "", complete_data$variable)
complete_data$variable <- gsub("\\.x", "", complete_data$variable)
complete_data$variable <- gsub("\\.z", "", complete_data$variable)
complete_data$variable <- gsub(".magnitude", "", complete_data$variable)

##Reorder columns

complete_data <- complete_data[, c(1, 3, 2, 6, 4, 7, 8, 5)]

##Create a second, independent tidy data set with the average of each variable 
##for each activity and each subject

tidy_data <- ddply(complete_data, .(subject, run, activity, measurement, variable, axis.signal, estimation), numcolwise(mean))
colnames(tidy_data)[8] <- "average.value"

##Create .txt file for the tidy dataset

write.table(tidy_data, "./tidy_UCI_HAR_data.txt", row.names = FALSE)

##Remove unused files

rm(train.set, test.set, train.lbl, test.lbl, train.sub, test.sub, activity, 
   activity.lbls, features, set, subject, data)
