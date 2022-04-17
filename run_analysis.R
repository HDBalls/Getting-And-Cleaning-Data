#install packages:
install.packages("data.table")
install.packages("dplyr")

#load libraries:
library(data.table)
library(dplyr)

#Read the supplied files:
featureNames <- read.table("features.txt")
activityLabels <- read.table("activity_labels.txt", header = FALSE)

#Read training data
subject_Train <- read.table("train/subject_train.txt", header = FALSE)
activity_Train <- read.table("train/y_train.txt", header = FALSE)
features_Train <- read.table("train/X_train.txt", header = FALSE)

#Read test data
subject_Test <- read.table("test/subject_test.txt", header = FALSE)
activity_Test <- read.table("test/y_test.txt", header = FALSE)
features_Test <- read.table("test/X_test.txt", header = FALSE)

#Merge the training and the test sets to create one single data set
merge_subject <- rbind(subject_Train, subject_Test)
merge_activity <- rbind(activity_Train, activity_Test)
merge_features <- rbind(features_Train, features_Test)

#Rename columns
colnames(merge_features) <- t(feature_Names[2])

#Merge the initially merged datasets into 1:
colnames(merge_activity) <- "Activity"
colnames(merge_subject) <- "Subject"
complete_Data <- cbind(merge_features,merge_activity,merge_subject)

#Extract the column  that have either mean or std in the name.
columns_With_Mean_STD <- grep(".*Mean.*|.*Std.*", names(complete_Data), ignore.case=TRUE)

#Add activity columns, validate, extract main data and revalidate
required_Columns <- c(columns_With_Mean_STD, 562, 563)
dim(complete_Data)
extracted_Data <- complete_Data[,required_Columns]
dim(extracted_Data)

#Use descriptive activity names and set to factor:
extracted_Data$Activity <- as.character(extracted_Data$Activity)
for (i in 1:6){
  extracted_Data$Activity[extracted_Data$Activity == i] <- as.character(activity_Labels[i,2])
}
extracted_Data$Activity <- as.factor(extracted_Data$Activity)

#Check the column names by extracting and eyeballing them:
#The following will be replaced:
#Acc -> Accelerometer
#Gyro -> Gyroscope
#BodyBody -> Body
#Mag -> Magnitude
#Character f -> Frequency
#Character t -> Time
names(extracted_Data)<-gsub("Acc", "Accelerometer", names(extracted_Data))
names(extracted_Data)<-gsub("Gyro", "Gyroscope", names(extracted_Data))
names(extracted_Data)<-gsub("BodyBody", "Body", names(extracted_Data))
names(extracted_Data)<-gsub("Mag", "Magnitude", names(extracted_Data))
names(extracted_Data)<-gsub("^t", "Time", names(extracted_Data))
names(extracted_Data)<-gsub("^f", "Frequency", names(extracted_Data))
names(extracted_Data)<-gsub("tBody", "TimeBody", names(extracted_Data))
names(extracted_Data)<-gsub("-mean()", "Mean", names(extracted_Data), ignore.case = TRUE)
names(extracted_Data)<-gsub("-std()", "STD", names(extracted_Data), ignore.case = TRUE)
names(extracted_Data)<-gsub("-freq()", "Frequency", names(extracted_Data), ignore.case = TRUE)
names(extracted_Data)<-gsub("angle", "Angle", names(extracted_Data))
names(extracted_Data)<-gsub("gravity", "Gravity", names(extracted_Data))

#Do final cleanup for the Tiday Data:
extracted_Data$Subject <- as.factor(extracted_Data$Subject)
extracted_Data <- data.table(extracted_Data)

#Create the final file with the averages
tidyData <- aggregate(. ~Subject + Activity, extracted_Data, mean)
tidyData <- tidyData[order(tidyData$Subject,tidyData$Activity),]
write.table(tidyData, file = "Final_Tidy_Data.txt", row.names = FALSE)