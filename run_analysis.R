# load files onto R, with assumption that all files are already extracted on the
# current working directory

features <- read.table("features.txt")
activity_lables <- read.table("activity_labels.txt")

x_train <- read.table("X_train.txt")
subject_train <- read.table("subject_train.txt")
y_train <- read.table("y_train.txt")

x_test <- read.table("X_test.txt")
subject_test <- read.table("subject_test.txt")
y_test <- read.table("y_test.txt")

# name columns
colnames(subject_test) <- "subject"
colnames(subject_train) <- "subject"
colnames(y_test) <- "activity_code"
colnames(y_train) <- "activity_code"
colnames(activity_lables) <- c("code","activityName")
colnames(x_test) <- features[,2]
colnames(x_train) <- features[,2]

# merge columns
test.all <- cbind(subject_test,y_test,x_test)
train.all <- cbind(subject_train,y_train,x_train)

# merge rows
mydata.all <- rbind(test.all, train.all)

# filter for column names with mean and std
mydata.filtered <-  mydata.all[(grep(("subject|activity_code|mean|std"),colnames(mydata.all)))]

# rename columns to remove non-standard characters and capitalize first character of mean and std
# for readability
names(mydata.filtered) <- gsub('-mean', 'Mean', names(mydata.filtered))
names(mydata.filtered) <- gsub('-std', 'Std', names(mydata.filtered))
names(mydata.filtered) <- gsub('[-()]', '', names(mydata.filtered))

# aggregate by activity and subject, and then remove the group columns
library(dpylr)
mydata.agg <- mydata.filtered %>% group_by(activity_code,subject) %>% summarise_each(funs(mean))

# add activity lables and then finally remove the activity_code column
mydata.comp <- merge(activity_lables, mydata.agg, by.x = "code", by.y = "activity_code")
mydata.comp <- mydata.comp[,2:82]

# save data set to text file
write.table(mydata.comp, file = "tidyData.txt", row.names = FALSE, quote = FALSE)

