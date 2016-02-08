The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

DATA
-----
Source: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

SCRIPT
------
run_analysis.R

DEPENDENCIES
--------------
* Data should be downloaded, unzipped and the working directory should be set to its path. Eg:
setwd('C:/ABC Path Samsung Data/UCI HAR Dataset')
* readr and dplyr packages should be installed.

VARIABLES
----------
train_data: Raw training data
train_labels: Training labels
train_subject: Subjects in training set
test_data: Raw test data
test_labels: Test labels
test_subject: Subjects in test set
all_data
all_dataset
mean_std_indicator: Indicates whether or not columns have "mean" or "std" in their names
mean_std_data: Data with mean and std columns
tidy_data: Data on grouping by Subject and Activity and summarising


TRANSFORMATIONS
---------------
The training and test data, labels and subjects were merged using bind_rows and bind_cols
Only the mean and stdev columns were extracted using the grep function

To rename the  activities to more meaningful names, 
* "(", ")" and "-" were removed
* "t" when occuring as the first letter in the name, was replaced with Time
* "f" when occuring as the first letter in the name, was replaced with Frequency
* "Acc" was replaced with "Acceleration"
* "Gyro" was replaced with "Gyroscope"
This was done using gsub

The data was grouped by Subject and Activity, and the mean for each group was calculated.
