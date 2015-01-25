# @author Vinod Damle
# @Date January 2015

library(dplyr)

# read the activity labels
activity.labels <- read.table("activity_labels.txt", stringsAsFactors = FALSE, header = FALSE)
names(activity.labels) <- c("activityId", "activityDescr")

# read the feature names, fix names
featnames <- read.table("features.txt",stringsAsFactors = FALSE)
# fix the variable names - remove ()
featnames$V2 <- gsub("\\(", "", featnames$V2)
featnames$V2 <- gsub("\\)", "", featnames$V2)
featnames$V2 <- gsub("BodyBody", "Body", featnames$V2) # some vars have an (unnecessary) extra Body
# add descriptive name for 't' as 'time'
featnames$V2 <- gsub("^t", "time", featnames$V2)
# add descriptive name for 'f' as 'freq'
featnames$V2 <- gsub("^f", "freq", featnames$V2)
# Add descriptive name for Acc and Gyro
featnames$V2 <- gsub("Acc", "Accelerometer", featnames$V2)
featnames$V2 <- gsub("Gyro", "Gyroscope", featnames$V2)
# fix the hyphens in the mean and stdev related entries to make them camel case
featnames$V2 <- gsub("-mean-", "Mean", featnames$V2)
featnames$V2 <- gsub("-std-", "Std", featnames$V2)
# fix the hyphens in the mean and stdev related entries to make them camel case
featnames$V2 <- gsub("-mean", "Mean", featnames$V2)
featnames$V2 <- gsub("-std", "Std", featnames$V2)
# remove "," in some of the entries and convert to camel case
featnames$V2 <- gsub(",g", "G", featnames$V2)

# read the training data set
train.activity <- read.table("y_train.txt", stringsAsFactors = FALSE, header = FALSE)
names(train.activity) <- c("activityId")
train.subj <- read.table("subject_train.txt", stringsAsFactors = FALSE, header = FALSE)
names(train.subj) <- c("subjectId")
train.features.raw <- read.table("X_train.txt", stringsAsFactors = FALSE, header = FALSE)
# assign colnames to features from featnames
names(train.features.raw) <- featnames$V2
# form regex for Mean/Stdev related colnames we are interested in
temp1 <- names(train.features.raw)[grepl("*Mean$|*MeanX$|*MeanY$|*MeanZ$", names(train.features.raw))]
temp2 <- names(train.features.raw)[grepl("*Std$|*StdX$|*StdY$|*StdZ$", names(train.features.raw))]
mean.stdev.colnames <- c(temp1, temp2)

# filter out the columns we are not interested in based on regex formed earlier
train.features <- train.features.raw[, which(names(train.features.raw) %in% mean.stdev.colnames)]
train.features <- mutate(train.features, subjectId = train.subj$subjectId)
train.features <- mutate(train.features, activityId = train.activity$activityId)





# train.activity <- merge(train.activity, activity.labels, by = "V1", na.rm = TRUE)

# read the test data set
test.activity <- read.table("y_test.txt", stringsAsFactors = FALSE, header = FALSE)
names(test.activity) <- c("activityId")
test.subj <- read.table("subject_test.txt", stringsAsFactors = FALSE, header = FALSE)
names(test.subj) <- c("subjectId")
test.features.raw <- read.table("X_test.txt", stringsAsFactors = FALSE, header = FALSE)
# assign colnames to features from featnames
names(test.features.raw) <- featnames$V2
# filter out the columns we are not interested in based on regex formed earlier
test.features <- test.features.raw[, which(names(test.features.raw) %in% mean.stdev.colnames)]
test.features <- mutate(test.features, subjectId = test.subj$subjectId)
test.features <- mutate(test.features, activityId = test.activity$activityId)

# combine the training and test data using rbind
combined.features <- rbind(train.features, test.features)
# form groups based on subjectId and activityId
tidy.data <- group_by(combined.features, subjectId, activityId)

# get the mean and standard deviation for each column
tidy.data <- summarise_each(tidy.data, funs(mean, sd))

# merge the activity description into the data frame
tidy.data <- merge(tidy.data, activity.labels, by = "activityId")

# Rename the colnames to be something more intuitive -- remove _ char
final.featnames <- names(tidy.data)
final.featnames <- gsub("_mean", "SummarizedMean", final.featnames)
final.featnames <- gsub("_sd", "SummarizedStd", final.featnames)
names(tidy.data) <- final.featnames

# output the tidy data set
write.table(tidy.data, file = "tidy_data.txt", row.names = FALSE)
