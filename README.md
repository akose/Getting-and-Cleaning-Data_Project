Getting-and-Cleaning-Data_Project
=================================
README.md
This repo explains how all of the scripts work and how they are connected.
#Sctips in Project
There is only one script file that is connected to this project

There are 5 functions in this file named
##Check_Files()
This function checks to see if the the data located https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip was downloaded and unzipped with the default name in to the same directory as the script
##Merge_Label_Data()
This fuction merges and labels the data sets that we need from the unzipped folder
##Descriptive_Activity_Names()
Gives Descriptive Activity names for the tests performed in the training and the testing
##Extract_Data()
Extracts only the data with the mean and standard deviation information 
##Tidy_Data()
creates new dataset from the merged dataset and makes it a tidy data set by getting the average of the results that are duplicated
