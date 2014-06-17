setwd("C:/Users/Peter/Documents/Data Scientist Toolbox/Getting and Cleaning Data/Project")

##First create a temporary file to download the zip file to
temp <- tempfile()

##Download the zipfile from the URL to the Working Directory
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, temp, mode="wb")
##Important to use 'mode = "wb"' to ensure data is extractable

##unzip temp file to extract directory with data files to Working Directory
unzip(temp)
unlink(temp)

##Extract data from "activity_labels.txt" and "features.txt" and put into R objects
VarNames <- read.table("UCI HAR Dataset/features.txt", sep = "")
VarHeader <- VarNames[,2]
Activity_Labels <- read.table("UCI HAR Dataset/activity_labels.txt", sep = "")
colnames(Activity_Labels) <- c("ActivityCode", "ActivityName")

##train data extraction and organisation into R objects
SubjectCode_Train <- read.table("UCI HAR Dataset/train/subject_train.txt")
colnames(SubjectCode_Train) <- "SubjectCode"
ActivityCode_Train <- read.table("UCI HAR Dataset/train/y_train.txt")
colnames(ActivityCode_Train) <- "ActivityCode"
RefCodes_Train <- cbind(ActivityCode_Train, SubjectCode_Train)
trainData <- read.table("UCI HAR Dataset/train/X_train.txt", sep = "")
colnames(trainData) <- VarHeader

##test data extraction and organisation into R objects
SubjectCode_Test <- read.table("UCI HAR Dataset/test/subject_test.txt")
colnames(SubjectCode_Test) <- "SubjectCode"
ActivityCode_Test <- read.table("UCI HAR Dataset/test/y_test.txt")
colnames(ActivityCode_Test) <- "ActivityCode"
RefCodes_Test <- cbind(ActivityCode_Test, SubjectCode_Test)
testData <- read.table("UCI HAR Dataset/test/X_test.txt", sep = "")
colnames(testData) <- VarHeader

##Combine Train and Test RefCodes and data variables in respective Dataframes
RefCodes_All <- rbind(RefCodes_Train, RefCodes_Test)
##Combine train and test data into one data set
DataAll <- rbind(trainData, testData)

##Extract columns of Means and Standard Deviations only from DataAll dataframe
##Extract  columns containing  variable Means first
DataMean <- DataAll[, grep("mean", colnames(DataAll))]
##Extract columns containing variable Standard Deviations next
DataSTD <- DataAll[, grep("std",colnames(DataAll))]

##Combine RefCodes, Mean and SD columns into a single dataframe
DataSummary <- cbind(RefCodes_All, DataMean, DataSTD)
##This is data set of means and SDs with Activity and Subject Codes

##Add descriptive Activity Names to DataSummary dataframe
DataMerge = merge(Activity_Labels,DataSummary,by.x="ActivityCode",by.y="ActivityCode",all=TRUE)
Summary <- DataMerge[,-1]
##This is the dataframe of means & SDs with appropriate Activity Name labels

##summarising data by activity and subject averaging across all means & SD data variables
##Need to ensure 'plyr' package is installed in R
require(plyr)
dat <- ddply(Summary, .(SubjectCode, ActivityName),numcolwise(mean))
write.table(dat, file = "TidyData.txt", sep = " ")
##To get summary of averages across all activities for each subject repeat 'ddply'
## on 'dat' dataframe e.g 'dat1 <- ddply(dat, .(SubjectCode), numcolwise(mean))'
##This can be done after reading
## the data back into 'R' with 'read.table()' if to be done later
##dat <- read.table("TidyData.txt", sep = "")
##dat1 <- ddply(dat, .(SubjectCode), numcolwise(mean))

##To get summary of averages across all subjects for each activity repeat 'ddply'
## on 'dat' dataframe e.g 'dat2 <- ddply(dat, .(ActivityName), numcolwise(mean)).
## This can be done after reading
##the data back into 'R' with 'read.table()' if to be done later
##dat <- read.table("TidyData.txt", sep = "")
##dat2 <- ddply(dat, .(ActivityName), numcolwise(mean))
