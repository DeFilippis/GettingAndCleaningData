##This script performs the following functions:
##    1.  Merges the training and the test sets to create one data set.
##    2.  Extracts only the measurements on the mean and standard deviation for each measurement. 
##    3.  Uses descriptive activity names to name the activities in the data set
##    4.  Appropriately labels the data set with descriptive variable names. 
##    5.  From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##Merges Training and Testing Datasets
X_test <- read.table("test/X_test.txt")
X_train <- read.table("train/X_train.txt")
X <- rbind(X_test, X_train)

Y_test <- read.table("test/y_test.txt")
Y_train <- read.table("train/y_train.txt")
Y <- rbind(Y_test, Y_train)

S_train <- read.table("train/subject_train.txt")
S_test <- read.table("test/subject_test.txt")
S <- rbind(S_train, S_test)

##Removes all objects from memory that contain test or train in their name
rm(list = ls()[grep("test|train", ls())])

##Gets data_labels from "features.txt" and applies them to dataset's column names
data_labels <- read.table("features.txt")
colnames(X)<- data_labels[,2]

##Subsets the data to only include columns that contain "mean" or "std"
X <- dataset[, grep("\\mean()\\b|\\-std()\\b", colnames(X))]

##Use Descriptive Activity Names to Name the Dataset 
activity_labels <- read.table("activity_labels.txt")
Y[,1] <- activity_labels[Y[,1], 2]
colnames(Y) <- "activity"
colnames(S) <- "subject"

##Bind all the datasets together
clean_dataset <- cbind(S, Y, X)

##Rename columns to more readable form:
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

##Write out the data
write.table(clean_dataset, "clean_data.txt", row.name=FALSE)

##Output tidy dataset.   
tidy <- aggregate(. ~subject + activity, clean_dataset, mean)
tidy <- tidy[order(tidy$subject,tidy$activity),]

##Another possibility is to transform data frame into data table and use lapply like so:
##    Masterdt <- data.table(clean_dataset)
##    tidyData <- Masterdt[, lapply(.SD, mean), by = 'subject,activity']

#Write tidy dataset to tidy.txt
write.table(tidy, file = "tidy.txt", row.names = FALSE)
