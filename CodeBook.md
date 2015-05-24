---
title: "CodeBook"
author: "DeFilippis"
date: "Friday, May 22, 2015"
output: html_document
---

#Getting and Cleaning Data, Code Book
##Data Source

This script creates a condensed data set derived from the Human Activity Recognition (HAR) data maintained by the University of California Irvine (UCI).  

The original data can be located here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The original data description can be found here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


##Dataset Information
The original data set comes from experiments that have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

##The Data

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 


##Transformation Details

This script performs the following functions:

* Merges the training and the test sets to create one data set.  Training data is of the form `/X_train.txt` while text data is of the form ` test/X_test.txt`.  This results in a dataset containing  the following content: "Number of Instances: 10299" and "Number of Attributes: 561"
    
* Extracts only the measurements on the mean and standard deviation for each measurement using `features.txt`.  Only 66 of the 561 attributes are means and standard deviation measurements, so this results in a 10299x66 data frame
    
* Appropriately labels the data set with descriptive variable names.  The program reads activity_labels.txt to give the following data labels
    
```{r}
walking
walkingupstairs
walkingdownstairs
sitting
standing
laying
```
    
* The 10299x66 data frame containing features is marged with a 10299x1 data frames containing subject IDs and labels, resulting in a "tidy dataset." The data set changes all feature names according to the following conventions. 
        

```{r}
names(clean_dataset)<-gsub("\\()", "", names(clean_dataset))
names(clean_dataset)<-gsub("-X", "XAxis", names(clean_dataset))
names(clean_dataset)<-gsub("-Y", "YAxis", names(clean_dataset))
names(clean_dataset)<-gsub("-Z", "ZAxis", names(clean_dataset))
names(clean_dataset)<-gsub("Jerk", "JerkSignal", names(clean_dataset))
names(clean_dataset)<-gsub("Acc", "Accelerometer", names(clean_dataset))
names(clean_dataset)<-gsub("Gyro", "Gyroscope", names(clean_dataset))
names(clean_dataset)<-gsub("BodyBody", "Body", names(clean_dataset))
names(clean_dataset)<-gsub("Mag", "Magnitude", names(clean_dataset))
names(clean_dataset)<-gsub("^t", "Time", names(clean_dataset))
names(clean_dataset)<-gsub("^f", "FourierTransform", names(clean_dataset))
names(clean_dataset)<-gsub("tBody", "TimeBody", names(clean_dataset))
names(clean_dataset)<-gsub("-mean()", "Mean", names(clean_dataset), ignore.case = TRUE)
names(clean_dataset)<-gsub("-std()", "STD", names(clean_dataset), ignore.case = TRUE)
names(clean_dataset)<-gsub("-freq()", "Frequency", names(clean_dataset), ignore.case = TRUE)
names(clean_dataset)<-gsub("angle", "Angle", names(clean_dataset))
names(clean_dataset)<-gsub("gravity", "Gravity", names(clean_dataset))
```

As a result attributes look similar to the following:
```{r}
"subject" 
"activity" 
"TimeBodyAccelerometerMeanXAxis" 
"TimeBodyAccelerometerMeanYAxis" 
"TimeBodyAccelerometerMeanZAxis" 
```


* The final result is a 10299x68 data frame that contains  subject IDs in the first column, activity names in the second column, and the last 66 columns are measurements.

##Tidy Data Set
Tidy Data Set Contains: 

* A subject identifier corresponding to the individual performing the experiment.  This variable ranges from 1 to 30.  
* An activity label of the following form: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
* Mean of all measurements collected from the accelerometer and gyroscope 3-axial raw signal.