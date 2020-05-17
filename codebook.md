**Author: Daniel Harakeh**  
_Date: May 17 2020_  
Contact: danielharakeh@gmail.com

## Code Book

The _run_analysis.R_ script downloads a compressed source file, extracts, and creates data frames from the embeded data files before executing the steps required in the course project.

### Download

Download URL: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  
A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones  
Downloaded and unzipped under UCI HAR Dataset

### Create Data Frames
Variable | Source | Description | Dimensions
-------- | ------ | ----------- | ----------
**act** | activity_labels.txt | _activities performed and their labels_ | 6 rows, 2 cols
**ftr** | features.txt | _features obtained from the time and frequency_ | 561 rows, 2 cols
**s_test** | test/subject_test.txt | _test data of 30% of subjects_ | 2947 rows, 1 column
**x_test** | test/x_test.txt | _measured features for test data_ | 2947 rows, 561 cols
**y_test** | test/y_test.txt | _activity labels for test data_ | 2947 rows, 1 cols
**s_train** | test/subject_train.txt | _test data of 70% of subjects_ | 7352 rows, 1 column
**x_train** | test/x_train.txt | _measured features for train data_ |7352 rows, 561 cols
**y_train** | test/y_train.txt | _activity labels for train data_ | 7352 rows, 1 cols

### Merge Training & Test Sets
Using rbind() to merge **x_train** and **x_test**, and assigning result in **x** (10299 rows, 561 cols)  
Using rbind() to merge **y_train** and **y_test**, and assigning result in **y** (10299 rows, 1 column)  
Using rbind() to merge **s_test** and **s_train**, and assigning result in **s** (10299 rows, 1 column)
Using cbind() to merge **s**, **x**, and **y**, and assigning result in **dt** (10299 rows, 563 column)

### Select Mean & Standard Deviation
Using dplyr::select() to extract only columns subject, label and variables containing "mean" and "std", and assigning result in **subset** (10299 rows, 88 cols)

### Use Descriptive Activity Names
Replacing numbers in the label column of **subset** with corresponding activity from column 2 of **activities**

### Use Descriptive Variables Names
* All starting with _t_ replaced by _Time_
* All startibg with _f_ replaced by _Frequency_
* All _Acc_ in column’s name replaced by _Accelerometer_
* All _Gyro_ in column’s name replaced by _Gyroscope_
* All _Mag_ in column’s name replaced by _Magnitude_
* Label column renamed as _Activity_

### Average per Variable by Activity & Subject

Using dplyr::group_by() and dplyr::summarise_all() to group **subset** by subject and activity and apply the mean() function, and assigning the result to **avgset** (180 rows, 88 cols) before writing it a separate .txt file: activity_averages.txt