Getting-and-cleaning-data-project
=================================

This is a repo for the course project in "Getting and cleaning data" coursera course


The script "run_analysis.R" takes the data from the folder "UCI HAR Dataset", that has to be located in R working directory,
and manipulates data to create 2 tidy data sets. 

Part 1 creates manipulates the raw data to create a tidy data set for the questions 1-4 in the assignement.
Part 2 creates a tidy data set for the question 5.

The file "codebook.txt" is a modified version of the initial codebook, provided by the authors of the dataset.

In the beginning of it, I describe the variables added by me and their meaning.

Than there is a text from authors, describing the process of signal processing and features selection, modified to 
describe only the parts used in our final tidy data.

#Part1:

##Creating a first tidy data set for questions 1-4

Step 1. Getting train and test data into R. I loaded the files in the UCI HAR directory and the first level
of subdirectories, ignoring the "Inertial Signals" "rawest" data.

Step 2. Grabbing appropriate column names for both sets

Step 3. Getting activity lavels (i.e. numbers 1,2,3,4,5 or 6), corresponding to performed activity, and adding as extra column in both train and test data

Step 4. Getting id's of subjects, who performed each activity and adding them as an extra 
column of the data:

Step 5.  Last step before merging train and test data - I want to keep the information
about whether the subject performed in the test data set or in the train data
set, so I am creating an extra column called "dataset"

Step 6. Merging the train and test data

Step 7. Getting activity names for each activity label and merging them with our 
dataset, so that we have descriptive activity names instead of labels like
1, 2, 3, 4, 5 or 6

Step 8. To find out which columns correspond to "mean" or "standard deviation" values,
we look for "std" and "mean" in text of column names (this corresponds to the
2nd step in the assignement), and select out only those columns.

Step9. Saving the data as a first tidy data set 

#Part2. 

##Creating a second tidy data set for the question #5.

To do this, we simply need to group our data by activityName and subject, and
then apply mean() to each column

For that we will use {dplyr}'s summarize_each function, which allows us to 
apply a function to each column without explicitly telling it. Variables
used for grouping (subject and activityName) are excluded automatically,
which leaves us only the "dataset" variables, which we need to exclude 
ourselves