# Downloading data zip file
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "data.zip")

# Unziping...
unzip(zipfile = "data.zip")

# Reading test data set
x_test <- read.table(file = "UCI HAR Dataset/test/X_test.txt")
y_test <- read.table(file = "UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table(file = "UCI HAR Dataset/test/subject_test.txt")

# Reading train data set
x_train <- read.table(file = "UCI HAR Dataset/train/X_train.txt")
y_train <- read.table(file = "UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table(file = "UCI HAR Dataset/train/subject_train.txt")

# Reading features/variables and creating column names
variables <- read.table("UCI HAR Dataset/features.txt")
variables <- as.character(variables[, 2])
col_names <- c("subject", variables, "activity")

# Merging test data
test <- cbind(subject_test, x_test, y_test)
names(test) <- col_names

# Merging train data
train <- cbind(subject_train, x_train, y_train)
names(train) <- col_names

# Merging test and train
data <- rbind(test, train)

# extract mean() and standard deviation columns
filtered_varibables <- grep(col_names,pattern = "mean\\(\\)|std\\(\\)", value = TRUE)
col_names2 <- c("subject", filtered_varibables, "activity")
data <- data[, col_names2]

# Uses descriptive activity names to name the activities in the data set
activity_lables <- read.table(file = "UCI HAR Dataset/activity_labels.txt", col.names = c("lable", "name"), colClasses = c("integer", "character"))

for(i in 1:nrow(activity_lables)) {
    lable <- activity_lables$lable[i]
    name <- activity_lables$name[i]
    data[data$activity == lable, "activity"] <- name
}

# Break rows by subject and activity
# In each group of rows calculate the mean for each of the variables
group_data <- aggregate(. ~ subject + activity, data, mean)

# Order the grouped data by subject than by activity for better visualization of the data
group_data <- group_data[order(group_data$subject, group_data$activity), ]

# Save the data frame in a new file
write.csv(x = group_data, "group_data.csv")
