= Transformations applied =

Here are the transformations/steps applied in forming the tidy data

* read activity labels from activity_labels.txt and assign a meaningful column
  name
* read feature names from features.txt and fix the issues with the names of the   variables. Specifically, the following steps were done:
  ** remove ()
  ** replace BodyBody with Body
  ** replace strings starting with 't' with 'time' for time domain
  ** replace strings starting with 'f' with 'freq' for frequency domain
  ** replace 'Acc' with 'Accelerometer' for a more descriptive name
  ** replace 'Gyro' with 'Gyroscope' for a more descriptive name
  ** replace '-mean-' with 'Mean' for camel case
  ** replace '-std-' with 'Std' for camel case
  ** replace '-mean' with 'Mean' for camel case (var names ending with mean)
  ** replace '-std' with 'Std' for camel case (var names ending with std)
  ** replace ',g' with 'G' for camel case

* read training data for activity, subject and feature values
* assign colnames to features
* form regex for cols we are interested in
* select the cols based on the regex into a new data frame
* add the subject id and activity id for the corresponding feature row
* repeat the same for test data

* combine the training and test data with rbind
* apply group_by based on subject and activity and summarise_each for
  mean and stdev to obtain stats for each measurement

* fix names of cols with 'SummarizedMean' and 'SummarizedStd' for mean
  and std

* output tidy data


= Variable naming =

To conform to tidy data principles of having clean and descriptive variable
names, the above conventions have been followed. In general, variables have
been named with camel case and the descriptions have been picked form the
info about the project

Ex: here's a list of a few variable name examples. The complete list of variables is found in tidy_data.txt

"activityId"
"subjectId"
"timeBodyAccelerometerMeanXSummarizedMean"
"timeBodyAccelerometerMeanYSummarizedMean"
"angleYGravityMeanSummarizedStd"
"angleZGravityMeanSummarizedStd"
"activityDescr"
