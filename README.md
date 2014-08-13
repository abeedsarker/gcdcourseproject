gcdcourseproject
================
Getting and cleaning data project

Usage: source('~/gcdcourseproject/run_analysis.R')
Where gcdcourseproject is the working directory.

NOTE: The data set must be present (as it is in its original form) in the directory: 'getdata-projectfiles-UCI HAR Dataset'. The internal structure of this directory must be the same as the same as in the original SAMSUNG data set.

OUTPUT: 'cleaned_set.txt'

This file contains a summarized version of the original samsung data set. There are 30 rows in this data set, each row corresponding to a subject. The columns contain the averages for several 'mean' and 'standard deviation' measures from the original data set for each subject. The last column contains the mean for the y_values for each subject from the data set. The column headers represent the feature names from the original data set with the punctuations and symbols removed.

APPROACH:

The run_analysis.R file is thoroughly documented and the code for each of the 5 steps are shown. (see the in-code documentation for detailed explanation).
The general approach is as follows:

1. load the test and training set files and merge them together

2. load the features from the features.txt file and identify the variable representing the means and standard deviations of the measures using regular expressions

3. select only those specific columns from the merged table and rename the columns to represent the corresponding features

4. summarize the set by averaging each of the feature values for each subject 

5. write the summarized data as a text file (cleaned_set.txt)

VARIANTS:

The script includes code for two options of generating the cleaned data. In the first one, only features ending with '-mean()' or '-std()' are included. Derived means are ignored. For the second option, all feature names with 'mean' and 'std' substrings are included. Depending on which version of the cleaned data is prefered, the relevant code can be uncommented.

The code book contains details of all the variables included in option 2.

REQUIRED PACKAGES:

data.table

plyr