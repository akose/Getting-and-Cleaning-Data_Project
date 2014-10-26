run_analysis <- function()
{
  # Here are the data for the project:
  # https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
  # You should create one R script called run_analysis.R that does the following. 
  #
  # 1. Merges the training and the test sets to create one data set.
  # 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
  # 3. Uses descriptive activity names to name the activities in the data set
  # 4. Appropriately labels the data set with descriptive variable names. 
  # 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  # 
  # Good luck!
  #
  library(plyr)

  # check if files exist
  Check_Files <- function ()
  {
    setwd("./UCI HAR Dataset")
    file_name <<- matrix(c("./test/subject_test.txt","./test/X_test.txt","./test/y_test.txt","./train/subject_train.txt","./train/X_train.txt","./train/y_train.txt","./features.txt","./activity_labels.txt"))
    #checks if files are located where expected
    if(!all(sapply(FUN = file.exists,X = file_name)))
    { 
      print(append("file(s) not found ",file_name[which(!sapply(FUN = file.exists,X = file_name))]))
      setwd("../") 
      stop() 
    }
  }
  
  #reads and merges data in files together
  Merge_Label_Data <- function()
  {
    # use rbind because the data sets have the same number of rows
    #look into what order we want to rbind
    #rbinding test then train
    message("reading " ,file_name[4]," and ",file_name[1])#," and ",file_name[3])
    Subject_Label <- rbind(read.table(file_name[4]),read.table(file_name[1]))
    message("reading " ,file_name[6]," and ",file_name[3])
    Activity_Label <<- rbind(read.table(file_name[6]),read.table(file_name[3]))
    message("reading " ,file_name[5]," and ",file_name[2])
    Train_Test_Data <- rbind(read.table(file_name[5]),read.table(file_name[2]))
    message("reading Data Labels")
    Data_Col_Names <- read.table(file_name[7])
    colnames(Subject_Label) <- "Subject"
    colnames(Activity_Label) <- "Activity"
    colnames(Train_Test_Data) <- Data_Col_Names$V2
    message("merging subject, Training and Test data")
    Merged_Data <<-cbind(Subject_Label,Activity_Label,Train_Test_Data)
  }
  
  Descriptive_Activity_Names <- function()
  {
    #Try using gsubfn
    Merged_Data$Activity <<- gsub(1,"WALKING",x = Merged_Data$Activity)
    Merged_Data$Activity <<- gsub(2,"WALKING_UPSTAIRS",x = Merged_Data$Activity)
    Merged_Data$Activity <<- gsub(3,"WALKING_DOWNSTAIRS",x = Merged_Data$Activity)
    Merged_Data$Activity <<- gsub(4,"SITTING",x = Merged_Data$Activity)
    Merged_Data$Activity <<- gsub(5,"STANDING",x = Merged_Data$Activity)
    Merged_Data$Activity <<- gsub(6,"LAYING",x = Merged_Data$Activity)
  }
  
  Extract_Data <- function()
  {
    columns <- sort(append(which(grepl("std()",colnames(Merged_Data),fixed = TRUE)),which(grepl("-mean()",colnames(Merged_Data),fixed = TRUE))))
    Merged_Data <<- Merged_Data[,c(1,2,columns)]
  }
  
  Tidy_Data <- function()
  {
    Tidy <<- ddply(Merged_Data, .(Subject, Activity), numcolwise(mean))
  }
  
  Check_Files()
  Merge_Label_Data()
  Descriptive_Activity_Names()
  Extract_Data()
  Tidy_Data()
  write.table(Tidy, "../UCI_HAR_Tidy_Dataset.txt", row.names=FALSE)
  #DONE#Merges the training and the test sets to create one data set.
  #DONE#Extracts only the measurements on the mean and standard deviation for each measurement. 
  #DONE#Uses descriptive activity names to name the activities in the data set
  #DONE#Appropriately labels the data set with descriptive variable names. 
  #DONE#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  
  
  
  setwd("../")
}
