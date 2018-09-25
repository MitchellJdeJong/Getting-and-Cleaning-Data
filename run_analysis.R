# use setwd() to set working directory containing the 'weardata' folder
#load packages
library(tidyr)
library(plyr)
library(dplyr)


#load vector feature names
features <- read.table('weardata/UCI HAR Dataset/features.txt')

#grab second column as a vector
feature.names <- features[['V2']]

#Fix typo where 'Body' appears twice in the feature name
feature.names <- gsub('BodyBody', 'Body', feature.names)

#load tables
training.data <- read.table('weardata/UCI HAR Dataset/train/X_train.txt', col.names = feature.names)
training.labels <- read.table('weardata/UCI HAR Dataset/train/y_train.txt', col.names = 'exercise')
training.subjects <- read.table('weardata/UCI HAR Dataset/train/subject_train.txt', col.names = 'subject')
test.data <- read.table('weardata/UCI HAR Dataset/test/X_test.txt', col.names = feature.names)
test.labels <- read.table('weardata/UCI HAR Dataset/test/y_test.txt', col.names = 'exercise')
test.subjects <- read.table('weardata/UCI HAR Dataset/test/subject_test.txt', col.names = 'subject')

#replace the 1:6 in the test and training labels with descriptive exercise names
#it wants to output a character string, so we coerce it back into a data frame. Then we fix the column name.
test.labels <- as.data.frame(mapvalues(test.labels[,1], c('1','2','3','4','5','6'), c('WALKING', 'WALKING_UPSTAIRS', 'WALKING_DOWNSTAIRS', 'SITTING', "STANDING", "LAYING")))
training.labels <- as.data.frame(mapvalues(training.labels[,1], c('1','2','3','4','5','6'), c('WALKING', 'WALKING_UPSTAIRS', 'WALKING_DOWNSTAIRS', 'SITTING', "STANDING", "LAYING")))
names(test.labels) <- 'exercise'
names(training.labels) <- 'exercise'

#add the subject number and the labels to the training and test data
combined.training.data <- cbind(training.subjects, training.labels, training.data)
combined.test.data <- cbind(test.subjects, test.labels, test.data)
#Combine it all into one data frame.
combined.df <- rbind(combined.training.data, combined.test.data)

#Tidy environment
rm(training.data,
   training.labels,
   training.subjects,
   test.data,
   test.subjects,
   test.labels,
   features,
   combined.test.data,
   combined.training.data)

#We will be finding the columns that deal with mean or standard deviation.
sdev.and.mean.cols <- grep('mean[^F]|std', feature.names)

#We make a new dataframe with only those columns.
sdev.mean.df <- combined.df[,c(1:2, sdev.and.mean.cols + 2)]

sdev.mean.df <- gather(sdev.mean.df, measurement, value, -subject, -exercise)

#group by subject, exercise, and measurement
sdev.mean.df <- group_by(sdev.mean.df, subject, exercise, measurement)

#summarize data to get the mean of each group

tidy.df <- dplyr::summarize(sdev.mean.df, mean_value = mean(value))

#We now save the tidy dataset as a text file.
write.table(tidy.df, file = 'tidy_data.txt', row.name=FALSE)
