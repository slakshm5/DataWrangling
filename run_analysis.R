
setwd('C:/Users/Sarah/Documents/R Files/Samsung Data/UCI HAR Dataset')
library(readr)
library(dplyr)

# read features and activity labels
features <- read.table("features.txt")
activity_labels <- read.table("activity_labels.txt")

# read training set labels and data
train_data <- read.table("train/X_train.txt")
train_labels <- read.table("train/Y_train.txt")
train_subject <- read.table("train/subject_train.txt")

# read test set labels and data
test_data <- read.table("test/X_test.txt")
test_labels <- read.table("test/Y_test.txt")
test_subject <- read.table("test/subject_test.txt")

# merge training set and test set into single data set
all_data <- bind_rows(train_data, test_data)
all_labels <- bind_rows(train_labels, test_labels) 
all_subjects <- bind_rows(train_subject, test_subject)
all_dataset <- bind_cols(all_data, all_labels, all_subjects)

rm(train_data)
rm(train_labels)
rm(train_subject)
rm(test_data)
rm(test_labels)
rm(test_subject)

# extract mean and std deviation columns
names(all_dataset) <- make.names(features$V2)
mean_std_indicator <- grepl("mean|std", features[, 2])
mean_std_data <- all_dataset[ which (mean_std_indicator == TRUE)]
all_dataset <- bind_cols(mean_std_data, all_labels, all_subjects)
colnames(all_dataset)[80:81] <- c("Activity", "Subject")

# label all observations with descriptive activity labels and names
all_dataset$Activity <- activity_labels$V2[all_dataset$Activity]
names(all_dataset) <- gsub("\\(\\)", "", names(all_dataset))
names(all_dataset) <- gsub("Acc", "Acceleration", names(all_dataset))
names(all_dataset) <- gsub("Gyro", "Gyroscope", names(all_dataset))
names(all_dataset) <- gsub("std", "StandardDeviation", names(all_dataset))
names(all_dataset) <- gsub("^t", "Time", names(all_dataset))
names(all_dataset) <- gsub("^f", "Frequency", names(all_dataset))
names(all_dataset) <- gsub("-", "", names(all_dataset))

#create tidy data set with avg for variable + subject
tidy_data <- group_by(all_dataset, Subject, Activity)
tidy_data <- summarise_each(tidy_data, funs(mean))

write.table(tidy_data, file ="tidy.txt")

