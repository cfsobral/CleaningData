# CleaningData
 Assignment: Getting and Cleaning Data Course Project
---
author: "Claudio  Sobral"
date: "May 26, 2018"
---
#### Introduction

You will create a script for project called run_analysis.R that it will analyze about “The data collected from the accelerometers from the Samsung Galaxy S smartphone”. 
This data is containing a zip file where you can extract it manually to your computer using some unzip program or through unzip functions used by the R, read about it in this link:

https://www.rdocumentation.org/packages/memisc/versions/0.97/topics/UnZip.

The data of the project are here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

In the script run_analysis.R must perform the following procedures:

1.	Merges the training and the test sets to create one data set.
2.	Extracts only the measurements on the mean and standard deviation for each measurement. 
3.	Uses descriptive activity names to name the activities in the data set
4.	Appropriately labels the data set with descriptive variable names. 
5.	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The script is divided in:

* Load the libraries that will be used in the project. For instance,          **libray(data.table)**
* Downloading the zip file the Internet.
   fileUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
* Reading the txt files, for example:
  `read.table("./UCI HAR Dataset/test/X_test.txt", header=FALSE)`
  `read.table("./UCI HAR Dataset/train/X_train.txt", header=FALSE)`
* Reading the files **activity_labels.txt** and **features.txt**. Functions    such as
   `my_data <- factor(file$variable, levels = files, labels = files)`
   `colnames(data.frame) <- data.frame$variables` can help you!
* Merging the tables TEST and TRAIN to create one data set
* Extracting measurament on the mean and standard deviation. Codes as such    **grep** and **subset** can help you too!
* Descriptive activity names to name the activities in the data set, for      example:`head(data.frame$variable)` and **gsub** are function that you can   use.
* Finally, you will create a second, independent tidy data set with the average of each variable. 
Tip: ```write.table(data.frame, file = "./UCI HAR Dataset/tidydata.txt", row.names = FALSE, col.names = TRUE)``` it lets you create a new data set.
