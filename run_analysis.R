library(dplyr)

#Part1. 
#Creating first  tidy data set for 1-4 steps of the assignement

#Step1. Getting train and test data
train=read.table("UCI HAR Dataset/train/X_train.txt")
test=read.table("UCI HAR Dataset/test/X_test.txt")

#Step2. getting the features names,which will serve as our column names (this is 
#actually the 4th step in the assignement, but it is easier to do it first, 
#before merging the datasets)
features=read.table("UCI HAR Dataset/features.txt")
colnames(train)=features[,2]
colnames(test)=features[,2]

#Step3. getting activity labels and adding them as another, 562-th column of train and 
#test data:
trainLabels=read.table("UCI HAR Dataset/train/y_train.txt")
testLabels=read.table("UCI HAR Dataset/test/y_test.txt")
train$activityLabel=trainLabels[,1]
test$activityLabel=testLabels[,1]

#Step4. getting ids of subjects, who performed each activity and adding them as 563th 
#column of the data:
trainSubject=read.table("UCI HAR Dataset/train/subject_train.txt")
testSubject=read.table("UCI HAR Dataset/test/subject_test.txt")
train$subject=trainSubject[,1]
test$subject=testSubject[,1]

#Step5. Last step before merging train and test data - I want to keep the information
#about whether the subject performed in the test data set or in the train data
#set, so I am creating an extra column called "dataset"
train$dataset="train"
test$dataset="test"

#Step6. Merging the data (this corresponds to the 1st step in the assignement):
data=rbind(train,test)
rm(train)
rm(test)

#Step7. getting activity names for each activity label and merging them with our 
#dataset, so that we have descriptive activity names instead of labels like
#1, 2, 3, 4, 5 or 6 (this corresponds to the 3d step in the assignement)
activityNames=read.table("UCI HAR Dataset/activity_labels.txt")
colnames(activityNames)=c("activityLabel","activityName")
data=merge(data,activityNames)

#Step8. to find out which columns correspond to "mean" or "standard deviation" values,
#we look for "std" and "mean" in text of column names (this corresponds to the
#2nd step in the assignement)
index=c(grep("std",colnames(data)),grep("mean",colnames(data)))

#now we extract only the columns we need: the ones we found with "std" and 
#"mean", plus our own columns - subject, dataset and activityName
data=data[,c(index,563:565)]

#Step9. the tidy data for step4 is ready! Let us save it and move on to the 5th step:
#write.table(data,"tidy1.txt",quote=FALSE,row.names=FALSE)



#Part2. Calculating mean of each variable for each activity and each subject:

##to do this, we simply need to group our data by activityName and subject, and
##then apply mean() to each column

##for that we will use {dplyr}'s summarize_each function, which allows us to 
##apply a function to each column without explicitly telling it. Variables
##used for grouping (subject and activityName) are excluded automatically,
##which leaves us only the "dataset" variables, which we need to exclude 
##ourselves
data2=group_by(data,subject,activityName) %>%
        summarise_each(funs(mean),vars=-dataset)

#everything is done! Let us now save this dataset:
write.table(data2,"tidy2.txt",quote=FALSE,row.names=FALSE)














