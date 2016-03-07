One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The orginal data obtained from the above URL was transformed to provide two new data sets found in the following two files
* 'mean_std_tidy_data.txt' : Extracted measurements on the mean and standard deviation for each measurement of the original dataset.
* 'average_tidy_data.txt' : verage of each variable in the extracted measurement on the mean and standard deviation dataset (for each activity and each subject)

### Data set transformation process:
1. Downloaded and unziped the data set from the URL: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2. Obtained the 'activity names' from the activity_labels.txt' files
3. Obtained the column names for each of the data sets for 'test' and 'train' from the file 'features.txt'
4. Changed the column names for each of the 'test' and 'train' datasets by:
    a. replacing '-' with '.'
    b. removing '()'
    c. replacing '(' and ')' with '.'
5. Read 'y_test.txt' (this file contains activity as an integer). Assign the column name (variable) to this dataset 'activity.num'
6. Read the 'subject' dataset by reading the file 'test/subject_test.txt'. This single column of data was given a variable name 'subject.id'
7. Read the 'test' dataset by reading the file 'test/y_test.txt'. Assign column names to this dataset from the 'features.txt' file read earlier.
8. Used the data from 'subject' to add a column to 'test' dataset.  
9. Used the data from 'activity' dataset to add a column to the 'test' dataset.
10. Repeated steps 5 through 9 on the 'train' dataset to add 'subject.id' and 'activity.num' to the 'train' dataset.
11. Combined the 'test' and 'train' datasets.
12. From the combined dataset, selected the columns with the strings 'mean', 'std', 'subject.id' and 'activity.num'
13. Added a new column to the dataset for 'activity' where there is an 'activity' for each 'activity.num'
14. Moved the "subject.id" column name to the front of the data frame followed by the "activity" column
15. Removed the "activity.num" column
16. Wrote the data to a file 'mean_std_tidy_data.txt' using fixed width columns.
17. Wrote the column names to a different file 'features_mean_std_tidy_data.txt'.
18. Grouped the 'activity' and 'subject' data in the dataset used to geneate the mean and stand deviation data.
19. Generated the average of each column (variable) in the mean and standard deviation dataset.
20. Wrote the data to a file 'average_tidy_data.txt' using fixed width columns.
21. Wrote the column names to a different file 'features_average_tidy_data.txt'.

#### Refer to the README.txt for a description of the column names (variables)
