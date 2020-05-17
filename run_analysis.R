#Download and unzip

dwnld = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

if (!file.exists("UCI HAR Dataset.zip"))
  download.file(dwnld, "UCI HAR Dataset.zip", method="curl")

if (!file.exists("UCI HAR Dataset"))
  unzip("UCI HAR Dataset.zip")

#Create data frames

act <- read.table("activity_labels.txt", col.names = c("label", "activity"))
ftr <- read.table("features.txt", col.names = c("n","features"))

s_test <- read.table("test/subject_test.txt", col.names = "subject")
x_test <- read.table("test/X_test.txt", col.names = ftr$features)
y_test <- read.table("test/y_test.txt", col.names = "label")

s_train <- read.table("train/subject_train.txt", col.names = "subject")
x_train <- read.table("train/X_train.txt", col.names = ftr$features)
y_train <- read.table("train/y_train.txt", col.names = "label")

#Merge training and test

x <- rbind(x_train, x_test)
y <- rbind(y_train, y_test)
s <- rbind(s_train, s_test)
dt <- cbind(s, x, y)

#Load dplyr

library(dplyr)

#Extract only mean and sd

subset <- dt %>% select(subject, label, contains("mean"), contains("std"))

#Use descriptive activity names

subset$label <- act[subset$label, 2]

#Label data set with descriptive names

names(subset)<-gsub("^t", "Time", names(subset))
names(subset)<-gsub("^f", "Frequency", names(subset))
names(subset)<-gsub("Acc", "Accelerometer", names(subset))
names(subset)<-gsub("Gyro", "Gyroscope", names(subset))
names(subset)<-gsub("Mag", "Magnitude", names(subset))
names(subset)[2] = "Activity"

#Create another tidy set for average per variable per activity and subject

avgset <- subset %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))

#Write to independent file

write.table(avgset, "activity_averages.txt", row.name=FALSE)