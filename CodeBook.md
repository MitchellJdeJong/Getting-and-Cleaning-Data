Title | Author | Date
------|--------|-----
Getting and Cleaning Data Course Project | Mitchell J deJong | 15 Sept 2018


##Study design and data processing
This project takes the data from the Human Activity Recognition Using Smartphones Data Set and creates a tidy dataframe with only the information showing the mean value for the mean and standard deviation measurements. This is done in R using the 'tidyr', 'plyr' and 'dplyr' packages.

###Collection of the raw data Description of how the data was collected.
The raw data was collected by monitoring 30 subjects using the sensors on smartphones attached at the waist while they performed six basic exercises. The relevant data for our purposes is divided into training and test subgroups, with the data set, data labels, and subjects involved for each group in three seperate files. We combine these six sources with a file listing the features measured to get the data we work with.

##Creating the tidy datafile
To create the tidy datafile, our code carries out the following steps:
1. Download the data from the [Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
2. Read the seven relevant files, using the feature list as the column name for the data set, and the names 'subject' and 'exercise' as the column names for the subjects and labels files.
3. Replace the numbers (1-6) in the label data with the relevant exercises ('Walking'-'Laying') and give it the column name 'exercise'
4. Combine the data with the labels and subjects for both training and test data, then combine training and test data into one dataset.
5. (Optional) Tidy environment by removing the individual parts that went into our combined dataset.
6. Use regular expressions to find only those columns which include the mean or standard deviation of the measurments and create a new dataframe with only those columns.
7.Group this smaller dataset by all possible combinations of subject, exercise, and measurement type. This will sort the 679734 observations into 11880 total groups.
8. Create a narrow dataset with columns "subject", "exercise", "measurement", and "mean(value)" and place the mean value for each of the 11880 groups into the fourth column
9. Save resulting dataset as "tidy_data.txt"

##Description of the variables in the tiny_data.txt file General description of the file including:
The final tidy dataset will have 11880 observations in four columns. It gives the average value of each measurement for each subject for each exercise. The variables are 'subject', 'exercise', 'measurement', and 'mean(value)'.

###Variable 1: "subject"

The "subject" variable gives an integer from 1-30 representing the 30 human subjects who participated in the study.

###Variable 2: "exercise"

The "exercise" column contains factor variables showing which of the  six exercises ('WALKING', 'WALKING_UPSTAIRS', 'WALKING_DOWNSTAIRS', 'SITTING', 'STANDING', and 'LAYING') is being performed.

###Variable 3: "measurement"

The "measurement" column shows character variables which show what sort of measurement was recorded. The measurements were taken using an accelerometer and a gyroscope and include:
*fBodyAcc
*fBodyAccJerk
*fBodyGyro
*tBodyAcc
*tBodyAccJerk
*tBodyGyro
*tBodyGyroJerk
*tGravityAcc
for which we have recordings of both standard deviation and mean, in X,Y, and Z coordinates.

We also have:
*fBodyAccMag
*fBodyAccJerkMag
*fBodyGyroJerkMag
*fBodyGyroMag
*tBodyAccJerkMag
*tBodyAccMag
*tBodyGyroJerkMag
*tBodyGyroMag
*tGravityAccMag
which have standard deviation and mean, but are not devided into a coordinate system. In total we have 66 unique types of measurement data.

###Variable 4: "mean_value"

The "mean_value" column shows numeric variables which represent the average value the the measurement from column three for each combination of subject and exercise. The "mean_value" variable takes values between negative one and positive one.


##Sources
The 'Human Activity Recognition Using Smartphones Data Set' was completed by Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012