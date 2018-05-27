## Creating function run_analysis.R

# Loading the libraries

library(data.table)
library(dplyr)
library(plyr)

# Donwloading the zip file the internet
fileUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
download.file(fileUrl)

# After extracting the zip file manually, this will create a folder called "UCI HAR Dataset" 
# Reading the txt files contained in the folder and creating dataset.
## act = activity ; sub = subject

## 1 - Reading the TEST data set
testdata <- read.table("./UCI HAR Dataset/test/X_test.txt", header=FALSE)
testdata_act <- read.table("./UCI HAR Dataset/test/y_test.txt", header=FALSE)
testdata_sub <- read.table("./UCI HAR Dataset/test/subject_test.txt", header=FALSE)

## 2 - Reading the TRAIN data set
traindata <- read.table("./UCI HAR Dataset/train/X_train.txt", header=FALSE)
traindata_act <- read.table("./UCI HAR Dataset/train/y_train.txt", header=FALSE)
traindata_sub <- read.table("./UCI HAR Dataset/train/subject_train.txt", header=FALSE)

## 3 - Reading the FEATURES and ACTIVITY LABELS

data_Activity <- read.table("./UCI HAR Dataset/activity_labels.txt", header = FALSE)
testdata_act$V1 <- factor(testdata_act$V1, levels = data_Activity$V1, labels = data_Activity$V2)
traindata_act$V1 <- factor(traindata_act$V1, levels = data_Activity$V1, labels = data_Activity$V2)

data_Feature <- read.table("./UCI HAR Dataset/features.txt", header = FALSE)

colnames(testdata) <- data_Feature$V2
colnames(testdata) <- data_Feature$V2
colnames(traindata) <- data_Feature$V2
colnames(testdata_act) <- c("Activity")
colnames(traindata_act) <- c("Activity")
colnames(testdata_sub) <- c("Subject")
colnames(traindata_sub) <- c("Subject")

## Merging the tables TEST and TRAIN to create one data set
testdata <- cbind(testdata, testdata_act)
testdata <- cbind(testdata, testdata_sub)
traindata <- cbind(traindata, traindata_act)
traindata <- cbind(traindata, traindata_sub)
all_data <- rbind(testdata, traindata)

dataSubject <- rbind(testdata_sub, traindata_sub)
dataActivity <- rbind(testdata_act, traindata_act)
dataFeature <- rbind(testdata, traindata)
names(dataSubject) <- c("Subject")
names(dataActivity) <- c("Activity")
names(dataFeature) <- data_Feature$V2

DataCombine <- cbind(dataSubject, dataActivity)
Data <- cbind(dataFeature, DataCombine)

## Extracting measurament on the mean and standard deviation
# Create new data set to accumulate data set.
subData <- data_Feature$V2[grep("mean\\(\\)|std\\(\\)", data_Feature$V2)]
selecData <- c(as.character(subData), "Subject", "Activity")
Data <- subset(Data, select = selecData)
names(data_feature) <- data_FeatureNames$V2

#
## Uses descriptive activity names to name the activities in the data set
head(Data$Activity, 30)
#
## Attribuing labels the data set with descriptive variables names
names(Data) <- gsub("^t", "time", names(Data))
names(Data) <- gsub("^f", "frequency", names(Data))
names(Data) <- gsub("Acc", "Acceleremeter", names(Data))
names(Data) <- gsub("Gyro", "Gyroscope", names(Data))
names(Data) <- gsub("Mag", "Magnitude", names(Data))
names(Data) <- gsub("BodyBody", "Body", names(Data))

## creates a second, independent tidy data set with the average of each variable 
## for each activity and each subject.
TidyData <- Data
TidyData <- TidyData[order(TidyData$Subject, TidyData$Activity),]
write.table(TidyData, file = "tidydata.txt", row.names = FALSE, col.names = TRUE)

## I thank the help of this following sites for the teachings 
## that enabled me to complete this task. I realize that without their help 
## I could not complete the task. Thank you very much!!!
## Links: 
## https://rpubs.com/jilliancahill/ActivityDataCodeBook 
## https://rstudio-pubs-static.s3.amazonaws.com/37290_8e5a126a3a044b95881ae8df530da583.html
## https://rstudio-pubs-static.s3.amazonaws.com/97263_a998b86aed1f468aa05a0a254d62f3b7.html
## https://github.com/gangxu79/Getting-and-Cleaning-Data-Week-4-Assignment/blob/master/run_analysis.R
