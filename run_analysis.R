testFile <- "UCI HAR Dataset/test/X_test.txt"
trainFile <- "UCI HAR Dataset/train/X_train.txt"
testFileY <- "UCI HAR Dataset/test/y_test.txt"
trainFileY <- "UCI HAR Dataset/train/y_train.txt"

activityFile <- "UCI HAR Dataset/activity_labels.txt"
featuresFile <- "UCI HAR Dataset/features.txt"
subjectTestFile <- "UCI HAR Dataset/test/subject_test.txt"
subjectTrainFile <- "UCI HAR Dataset/train/subject_train.txt"


dfTest <- read.table(testFile, header=FALSE)
dfTrain <- read.table(trainFile, header= FALSE)

dfActivityTest <- read.table(testFileY, header=FALSE)
dfActivityTrain <- read.table(trainFileY, header= FALSE)

dfActivityNames <- read.table(activityFile, header=FALSE)
dfFeatures <- read.table(featuresFile, header=FALSE)
dfSubjectTest <- read.table(subjectTestFile, header=FALSE)
dfSubjectTrain <- read.table(subjectTrainFile, header=FALSE)

activityFactor <- dfActivityNames[,2][dfActivityTest[,1]]
dfTest <- cbind(activityFactor, dfTest)
activityFactor <- dfActivityNames[,2][dfActivityTrain[,1]]
dfTrain <- cbind(activityFactor, dfTrain)

dfTest <- cbind(dfSubjectTest, dfTest)
dfTrain <- cbind(dfSubjectTrain, dfTrain)


df <- rbind(dfTest, dfTrain)

cfacs <- as.character(dfFeatures[,2])
names(df) <- c("subject", "activity", cfacs)  # add new column names


df <- df[, grep("mean\\(\\)|Mean|std\\(\\)|subject|activity", names(df))]

aggdata <-aggregate(. ~ subject + activity, data=df, FUN=mean)

write.table(aggdata, "tidy_set.txt", row.name=FALSE)
