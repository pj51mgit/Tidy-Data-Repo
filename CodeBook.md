Code Book for Processed Samsung Galaxy S smartphone Data
========================================================
This document outlines the structure and details of the data in the text file "TidyData.txt" that was the output of an R script (run_analysis.R).  

**To get the 'TidyData.txt" as the required output of the script, R commands were run that:**
 
1.  Linked to the site of Samsung Galaxy S [data]^[1] (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).
2.  Downloaded and unzipped the zip file containing a data directory ("UCI HAR Dataset") with the data included in a number of space separated text files.

**The 'run_analysis.R' script loaded to the Tidy Data repo, when run:**

1.  Extracts the data from the relevant text files and puts them into R dataframes for further processing (see "Readme.md" for details).
2.  Merges the training and the test sets to create one data set.
3.  Extracts only the measurements on the mean and standard deviation for each measurement. 
4.  Uses descriptive activity names from the "activity_labels.txt" file in the "UCI HAR Dataset" Directory to name the activities in the data set
5.  Labels the data set with descriptive variable names for the means and SDs from the file "features.txt"" from within the "UCI HAR Dataset" Directory. 
6.  Creates a second, independent tidy data set with the average of each 'mean' and 'std' attribute for each activity and subject.  The data was scaled by dividing values by their range, so resulting in dimensionless attributes.

Further details about the original data set of the Samsung Galaxy S smartphone [data]^[1] are available from "http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones" and in the "README.txt" from the "UCI HAR Dataset" Directory in the Zip file containing the original data.

Tidy Data Set
--------------

**The details of the structure and content of data in the file "TidyData.txt":**

The data is the average across the listed variable mean and SD attributes for 30 subjects within an age bracket of 19-48 years, and  six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING).

The data was collected from a smartphone (Samsung Galaxy S II) attached on the waist of each subject using its embedded accelerometer and gyroscope.  The data captured consisted of 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz.  The original data set consisted of two subsets (train and test sets) randomly assigned so 70% of observations were in the train set and 30% in the test set. Further information detailing the data collected can be found at the URL link above.

Each of the train and test sets consisted of 561 columns of variables (attributes).

**Details of the Tidy Data Set**

The Tidy Data file consists of 180 rows and 81 columns.  The first column is the code for each subject (1-30).  The second column contains the names for the six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING).  Columns 3-81 contain the averages across subjects and activity for each of the mean and SD variables from the original data set.  So these columns represent the averages of a subset of the original 561 attributes in the original data set.  Columns 3 to 48 contain the averages for the 'mean' attributes and columns 49 to 81 contain the averages for the 'std' attributes.  Each row is the average of the 'mean' and 'std' attributes for each combination of subject and activity.

**The column names in the Tidy Data Set are:**

 [1] "SubjectCode"              |        "ActivityName"                   
 [3] "tBodyAcc.mean...X"        |       "tBodyAcc.mean...Y"              
 [5] "tBodyAcc.mean...Z"        |       "tGravityAcc.mean...X"           
 [7] "tGravityAcc.mean...Y"     |       "tGravityAcc.mean...Z"           
 [9] "tBodyAccJerk.mean...X"    |       "tBodyAccJerk.mean...Y"          
[11] "tBodyAccJerk.mean...Z"    |       "tBodyGyro.mean...X"             
[13] "tBodyGyro.mean...Y"       |       "tBodyGyro.mean...Z"             
[15] "tBodyGyroJerk.mean...X"   |       "tBodyGyroJerk.mean...Y"         
[17] "tBodyGyroJerk.mean...Z"   |       "tBodyAccMag.mean.."             
[19] "tGravityAccMag.mean.."    |       "tBodyAccJerkMag.mean.."         
[21] "tBodyGyroMag.mean.."      |      "tBodyGyroJerkMag.mean.."        
[23] "fBodyAcc.mean...X"        |       "fBodyAcc.mean...Y"              
[25] "fBodyAcc.mean...Z"        |       "fBodyAcc.meanFreq...X"          
[27] "fBodyAcc.meanFreq...Y"    |       "fBodyAcc.meanFreq...Z"          
[29] "fBodyAccJerk.mean...X"    |       "fBodyAccJerk.mean...Y"          
[31] "fBodyAccJerk.mean...Z"    |       "fBodyAccJerk.meanFreq...X"      
[33] "fBodyAccJerk.meanFreq...Y"|       "fBodyAccJerk.meanFreq...Z"      
[35] "fBodyGyro.mean...X"       |       "fBodyGyro.mean...Y"             
[37] "fBodyGyro.mean...Z"       |       "fBodyGyro.meanFreq...X"         
[39] "fBodyGyro.meanFreq...Y"   |       "fBodyGyro.meanFreq...Z"         
[41] "fBodyAccMag.mean.."       |       "fBodyAccMag.meanFreq.."             
[43] "fBodyBodyAccJerkMag.mean.."|      "fBodyBodyAccJerkMag.meanFreq.."     
[45] "fBodyBodyGyroMag.mean.."  |       "fBodyBodyGyroMag.meanFreq.."    
[47] "fBodyBodyGyroJerkMag.mean.."|     "fBodyBodyGyroJerkMag.meanFreq.."   
[49] "tBodyAcc.std...X"          |      "tBodyAcc.std...Y"                 
[51] "tBodyAcc.std...Z"         |       "tGravityAcc.std...X"              
[53] "tGravityAcc.std...Y"      |       "tGravityAcc.std...Z"            
[55] "tBodyAccJerk.std...X"     |       "tBodyAccJerk.std...Y"           
[57] "tBodyAccJerk.std...Z"     |       "tBodyGyro.std...X"              
[59] "tBodyGyro.std...Y"        |       "tBodyGyro.std...Z"              
[61] "tBodyGyroJerk.std...X"    |       "tBodyGyroJerk.std...Y"          
[63] "tBodyGyroJerk.std...Z"    |       "tBodyAccMag.std.."              
[65] "tGravityAccMag.std.."     |       "tBodyAccJerkMag.std.."          
[67] "tBodyGyroMag.std.."       |       "tBodyGyroJerkMag.std.."         
[69] "fBodyAcc.std...X"         |       "fBodyAcc.std...Y"               
[71] "fBodyAcc.std...Z"         |       "fBodyAccJerk.std...X"           
[73] "fBodyAccJerk.std...Y"     |       "fBodyAccJerk.std...Z"           
[75] "fBodyGyro.std...X"        |       "fBodyGyro.std...Y"              
[77] "fBodyGyro.std...Z"        |       "fBodyAccMag.std.."              
[79] "fBodyBodyAccJerkMag.std.."|       "fBodyBodyGyroMag.std.."         
[81] "fBodyBodyGyroJerkMag.std.."     

Information on summarising the data further to get averages across all activities for each subject and all subjects for each activity is outlined in the "Readme.md"  file that accompanies the R script (run_analysis.R) in the GitHub project directory.

**The first 6 rows and 5 columns of the Tidy Data set showing the averages of the first three 'mean' attributes for the 6 activities of subject 1 is as follows:**

**SubjectCode** | **ActivityName** |**tBodyAcc.mean...X** |**tBodyAcc.mean...Y** |**tBodyAcc.mean...Z**

1       1   |         LAYING   |    0.2215982   |   -0.040513953     |   -0.1132036   
2       1   |         SITTING  |    0.2612376   |   -0.001308288     |   -0.1045442    
3       1   |        STANDING  |    0.2789176   |   -0.016137590     |   -0.1106018   
4       1   |         WALKING  |    0.2773308   |   -0.017383819     |   -0.1111481    
5       1 | WALKING_DOWNSTAIRS |    0.2891883   |   -0.009918505     |   -0.1075662   
6       1 |  WALKING_UPSTAIRS  |    0.2554617   |   -0.023953149     |   -0.0973020    


[1]: Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
