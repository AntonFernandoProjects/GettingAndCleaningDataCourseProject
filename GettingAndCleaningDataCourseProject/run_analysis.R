install.packages("dplyr")
install.packages("gdata")
library(dplyr)
library(gdata) #to use write.fwf

#/UCI HAR Dataset/ Read activity_labels.txt.
activity_labels <- read.table("activity_labels.txt", sep="", header=FALSE, stringsAsFactors=FALSE, na.strings = "NA", col.names = c("activity.num","activity"))

#/UCI HAR Dataset/ Read features.txt. features.txt contains the column names for the data sets for 'test' and 'train'
features <- read.table("features.txt", sep="", header=FALSE, stringsAsFactors=FALSE, na.strings = "NA", col.names = c("","column.names"))
#The second column holds the column names
features <- features[,2]

#Clean column names by replacing or removing undesirable characters
#Replace '-' and ',' with '.'
features <- gsub(pattern="-|,", replacement=".", features)
#Remove "()"
features <- gsub(pattern="\\(\\)", replacement="", features)
#Replace '(' with '.'
features <- gsub(pattern="\\(", replacement=".", features)
#Replace ')' with '.'
features <- gsub(pattern="\\)", replacement=".", features)

#Clean test data
#/test/: Read y_test.txt (this file contains activity as an integer)
y_test <- read.table("test/y_test.txt", sep="", header=FALSE, stringsAsFactors=FALSE, na.strings = "NA", col.names = c("activity.num"))
#/test/: Read subject_test.txt (this file contains list of subjects for the test data set)
subject_test <- read.table("test/subject_test.txt", sep="", header=FALSE, stringsAsFactors=FALSE, na.strings = "NA", col.names = c("subject.id"))
#/test/: Read X_test data and assign the column names from features
X_test <- read.table("test/X_test.txt", sep="", header=FALSE, stringsAsFactors=FALSE, na.strings = "NA", col.names = features)
#/test/: Add the subject.id to the X_test data set
X_test <- mutate(X_test, subject.id=subject_test$subject.id)
#/test/: Add the activity (as an integer value) to the X_test data set
X_test <- mutate(X_test, activity.num=y_test$activity.num)


#clean training data
#/train/: Read y_train.txt (this file contains activity as an integer)
y_train <- read.table("train/y_train.txt", sep="", header=FALSE, stringsAsFactors=FALSE, na.strings = "NA", col.names = c("activity.num"))
#/train/: Read subject_train.txt (this file contains list of subjects for the train data set)
subject_train <- read.table("train/subject_train.txt", sep="", header=FALSE, stringsAsFactors=FALSE, na.strings = "NA", col.names = c("subject.id"))
#/train/: Read X_train data and assign the column names from features
X_train <- read.table("train/X_train.txt", sep="", header=FALSE, stringsAsFactors=FALSE, na.strings = "NA", col.names = features)
#/train/: Add the subject.id to the X_train data set
X_train <- mutate(X_train, subject.id=subject_train$subject.id)
#/train/: Add the activity (as an integer value) to the X_train data set
X_train <- mutate(X_train, activity.num=y_train$activity.num)

#Combine test and cleaning data
dim(X_test)
dim(X_train)
X_merged <- rbind(X_test, X_train)
dim(X_merged)

#Select only the column names for mean,standard deviation, subject.id and activity.num
col_names_mean_std <- grep("mean|std|subject\\.id|activity\\.num", names(X_merged))
X_merged <- X_merged[,col_names_mean_std]

#Merge the X_merged data set with the activity_labels so that the activty label appears in the data set
X_merged <- merge(X_merged,activity_labels, by.x="activity.num", by.y="activity.num", all=TRUE, sort=FALSE)

#Move the "subject.id" column name to the front of the data frame followed by the "activity" column
X_merged  <- X_merged[,c(ncol(X_merged)-1, ncol(X_merged), 1:(ncol(X_merged)-2))]
#Remove the "activity.num" column
X_merged <- select(X_merged,-activity.num)
X_mereged_ordered_by_subjectid <- arrange(X_merged, subject.id)
X_mereged_ordered_by_subjectid <- as.data.frame(X_mereged_ordered_by_subjectid)

#Write X_merged data set to a file
#create a vector of 81 elements
col_width <- rep(18,81)
options( scipen = -10 ) #this option set so digits will be displayed in scientific format
#Write data
write.fwf(X_mereged_ordered_by_subjectid, file="mean_std_tidy_data.txt", append=FALSE, quote=FALSE, sep=" ", na="NA",rownames=FALSE, colnames=FALSE, justify="right", width=col_width, scientific=TRUE)
#Write column names
features_merged_tidy_data <- names(X_mereged_ordered_by_subjectid)
write.table(features_merged_tidy_data, file="features_mean_std_tidy_data.txt", append=FALSE, sep="\n", row.names = FALSE, col.names = FALSE, quote=FALSE)

#Group X_merged by Activity and Subject
X_merged_grouped <- group_by(X_merged, activity, subject.id)
#Get average of each variable(i.e. column) for each activity and subject.id
X_merged_grouped_summary <- summarize_each(X_merged_grouped,funs(mean))
X_merged_grouped_summary <- as.data.frame(X_merged_grouped_summary )
write.fwf(X_merged_grouped_summary, file="average_tidy_data.txt", append=FALSE, quote=FALSE, sep=" ", na="NA",rownames=FALSE, colnames=FALSE, justify="right", width=col_width, scientific=TRUE)
features_average_tidy_data <- names(X_merged_grouped_summary)
write.table(features_average_tidy_data, file="features_average_tidy_data.txt", append=FALSE, sep="\n", row.names = FALSE, col.names = FALSE, quote=FALSE)

