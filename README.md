**Author: Daniel Harakeh**  
_Date: May 17 2020_  
Contact: danielharakeh@gmail.com

This repo is dedicated to provide instructions related to running the analysis on the data collected from the accelerometers from the Samsung Galaxy S smartphone for Getting and Cleaning Data course project.

##### "Human Activity Recognition Using Smartphones Dataset"

_A full description is available at the site where the data was obtained:_

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+SmartphonesDataset

##### Files

* _run_analysis.R_ downloads the data and creates data frames before executing the steps required the course project:

  * Merges the training and test sets
  * Selects only the mean and sd for each measurement
  * Uses descriptive activity names for the activities
  * Subsitute labels with descriptive names
  * Create a separate set for the average per variable grouped by activity and subject*

* _codebook.md_ describes the datasets, variables, and cleaning process

* _activity_averages.txt_ contains the data generated after executing the last step