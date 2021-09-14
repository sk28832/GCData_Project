#1
library(dplyr)
#reading in features and activity labels
feature <- read.table("UCI/features.txt")
activity <- read.table("UCI/activity_labels.txt", header = FALSE)

#reading in the test and train data
x_train <- read.table("./UCI/train/X_train.txt", header = FALSE)
x_test <- read.table("./UCI/test/X_test.txt", header = FALSE)
y_train <- read.table("./UCI/train/y_train.txt", header = FALSE)
y_test <- read.table("./UCI/test/y_test.txt", header = FALSE)
subject_train <- read.table("./UCI/train/subject_train.txt", header = FALSE)
subject_test <- read.table("./UCI/test/subject_test.txt", header = FALSE)

#setting column names for all of the tables
colnames(feature) = c("num", "func")
colnames(activity) = c("code", "activity")
colnames(subject_test) = "subject"; colnames(subject_train) = "subject"
colnames(x_train) = feature$func; colnames(x_test) = feature$func
colnames(y_train) = "code"; colnames(y_test) = "code"

#merging
x <- rbind(x_train, x_test)
y <- rbind(y_train, y_test)
sub <- rbind(subject_train, subject_test)
data <- cbind(sub, x, y)

#2
#extracting just mean and std from the data
library(dplyr)
ms_data <- select(data, contains("mean"), contains("std"))

#3
#using the activity names in the ms_data
code_vec <- data$code
ms_data$code <- activity[code_vec, 2]
#adding subject to the ms_data
ms_data$subject <- data$subject

#4
names(ms_data)
#giving meaningful column names to the data
names(ms_data) <- gsub("Acc", "Accelerometer", names(ms_data))
names(ms_data) <- gsub("Gyro", "Gyroscope", names(ms_data))
names(ms_data) <- gsub("Freq", "Frequency", names(ms_data))
names(ms_data) <- gsub("^t", "Time", names(ms_data))
names(ms_data) <- gsub("^f", "Frequence", names(ms_data))
names(ms_data) <- gsub("std", "Standard_Deviation", names(ms_data))
names(ms_data) <- gsub("BodyBody", "Body", names(ms_data))
names(ms_data) <- gsub("Mag", "Magnitude", names(ms_data))
names(ms_data) <- gsub("angle", "Angle", names(ms_data))
names(ms_data) <- gsub("tBody", "TimeBody", names(ms_data))
names(ms_data) <- gsub("gravity", "Gravity", names(ms_data))
write.table(ms_data, "mean_std.txt")

#5
ms_data$subject <- as.factor(ms_data$subject)
gms_data <- group_by(ms_data, code, subject)
summary_gms_data <- summarise_all(gms_data, .funs = mean)
