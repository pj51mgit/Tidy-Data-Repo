Project to Extract Samsung Galaxy S Smartphone Data for Further Analysis
=============================================================================

The script uploaded to my GitHub Tidy Data repo extracts the data from the 'UCI HAR Dataset' that has previously been downloaded and unzipped to my 'Working Directory' in R from "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip".  

This is as per the directions for the project: 
**"The code should have a file run_analysis.R in the main directory that can be run as long as the Samsung data is in your working directory."**

This script requires the 'plyr' package, which must be installed before the script is run.


Location of Working Directory
-----------------------------
The first line points to my Working Directory which contains the Data Directory 'UCI HAR Dataset' from which the needed data will be loaded from the contained text files


```r
setwd("C:/Users/Peter/Documents/Data Scientist Toolbox/Getting and Cleaning Data/Project")
```

Extract Data into Dataframes
------------------------------

The next set of lines in the script extracts the necessary files from the downloaded data directory to set up the necessary 'R' objects to combine the training and the test sets using 'rbind' to create one data set.



```r
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
#Put variable name headers into testData
colnames(testData) <- VarHeader
```

Combine Train and Test Data Sets
---------------------------------
Combine Train and Test RefCodes and data variables in respective Dataframes

```r
##First combine the Refcodes for train and test data
RefCodes_All <- rbind(RefCodes_Train, RefCodes_Test)
##Now Combine train and test data into one data set
DataAll <- rbind(trainData, testData) 
```

Extract Means and Std Deviations
---------------------------------

The next part of the script extracts only the measurements on the mean and standard deviation attributes for each measurement from the combined dataset.


```r
##Extract columns of Means and Standard Deviations only from 'DataAll' dataframe
##Extract  columns containing  variable Means first
DataMean <- DataAll[, grep("mean", colnames(DataAll))]
##Extract columns containing variable Standard Deviations next
DataSTD <- DataAll[, grep("std",colnames(DataAll))]
```

Recombine Activity and Subject Codes with Mean & SD Variables 
----------------------------------------------------------------

The next script line uses Codes for "Activities" and "Subjects""  from the 'RefCodes_All' dataframe to code these columns in the recombined data set of means and SDs using 'cbind'

```r
##Combine RefCodes, Mean and SD columns into a single dataframe
##This is data set of means and SDs with Activity and Subject Codes
DataSummary <- cbind(RefCodes_All, DataMean, DataSTD)  
```

DataSummary dataframe column headings are the variable names used for the variable attributes columns from the original data set ("features.txt") that were added to trainData and testData dataframes earlier in the script. So the column headings label the data set with descriptive variable names as required for Question 4 in the Assignment.


Add Activity Names
-------------------
The next two lines of script Use descriptive activity names from 'Activity_Labels' dataframe to name the activities in the combined data set of means and SDs using 'merge'


```r
DataMerge = merge(Activity_Labels,DataSummary,by.x="ActivityCode",by.y="ActivityCode",all=TRUE)
Summary <- DataMerge[,-1]
##This is the dataframe of means & SDs with appropriate Activity Name labels
```


Create Independent Tidy Data Set
--------------------------------
The last part of the script creates a second, independent tidy data set with which to calculate the average of each variable for each subject and for each activity. There is a column for each attribute and a row of the average of the mean and SD attributes for each combination of subject and activity.

The script uses the 'plyr' package, which must be installed, if not already installed, before the next script lines are run


```r
##Need to ensure 'plyr' package is installed in R
require(plyr)
dat <- ddply(Summary, .(SubjectCode, ActivityName),numcolwise(mean))
## 'dat' is the tidy data set as a dataframe
```

Output the Tidy Data Set
------------------------
The required data set can be then written to the working directory of the 'R' session as a text file or csv file.  The script writes the required file "TidyData.txt" as the output required by Question 5 of the Assignment and is a text file with "space" as the data separator, although if I was doing this for myself I would export as a csv file

```r
write.table(dat, file = "TidyData.txt", sep = " ") 
```

To get summary of averages across all activities for each subject repeat 'ddply'
on 'dat' dataframe e.g 'dat1 <- ddply(dat, .(SubjectCode), numcolwise(mean))' or alteratively apply this script after loading the "TidyData.txt" into R with "read.table()"

To get summary of averages across all subjects for each activity repeat 'ddply'
on 'dat' dataframe e.g 'dat2 <- ddply(dat, .(ActivityName), numcolwise(mean))  or alteratively apply this script after loading the "TidyData.ext" into R with "read.table()"
