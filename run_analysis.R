library("data.table")
library("plyr")
#TASK 1: LOAD AND MERGE DATA
#load the data
train_X <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")
train_Y <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/Y_train.txt")
train_sub <-read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")
test_X <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")
test_Y <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/Y_test.txt")
test_sub <-read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")
all_X <- rbind(train_X,test_X)
all_Y <- rbind(train_Y,test_Y)
all_sub <-rbind(train_sub,test_sub)

#TASK 2: EXTRACT ONLY MEASUREMENTS OF MEAN AND STANDARD DEVIATION
#load the list of features
features_list <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt")
#collect only mean and std data
##*option 1: onlye -mean() and -std() functions are included. Derived means are not included. 
#sel_features <- grep(pattern = "[^[:alnum:]]mean[^[:alnum:]]|[^[:alnum:]]std[^[:alnum:]]",features_list$V2, perl=TRUE,value=FALSE)
##*Option 2: ALL variables mentioning mean and std are included
sel_features <- grep(pattern = "mean|std|Mean",features_list$V2, perl=TRUE,value=FALSE)

#TASK 3,4: USE DESCRIPTIVE ACTIVITY NAMES TO LABEL THE ACTIVIES IN THE DATA SET
sel_x_data <- all_X[,sel_features] 

#rename the headings
for (i in seq_along(sel_features)){
  hname<-paste("V",toString(sel_features[i]),sep="")
  sel_x_data <- setnames(sel_x_data,hname,gsub("[^[:alnum:] ]", "", toString(features_list[sel_features[i],2])))
}
#add and rename the subject number column
all_merged <- cbind(all_sub,sel_x_data)
all_merged <-setnames(all_merged,"V1","subjectNumber")
#add and rename the Y column (assuming here that we want to keep the y values because that would be common sense.)
all_merged <- cbind(all_merged,all_Y)
all_merged <-setnames(all_merged,"V1","yValue")

#TASK 5: CREATE A SECOND INDEPENDENT TIDY DATA SET WITH THE AVERAGE OF EACH VARIABLE FOR EACH ACTIVITY AND SUBJECT
summarised_set <- ddply(all_merged,"subjectNumber",numcolwise(mean))
write.table(summarised_set,"cleaned_set.txt",row.names=FALSE)
