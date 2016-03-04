# Getting and Cleaning Data Course Project

This is the course project for - Getting and Cleaning Data. For the script to work, you need to download the zip file and copy all files on the current working directory (no subdirectories).

The script - `run_analysis.R`, does the following:

1. Loads the feature, activity labels, and activity data
2. Assigns column names on activity data
3. Merges test and train data
4. Filter column names to only include numeric columns that contains either `mean` or `std` string values
5. Tidy up the numeric variable names, by removing special characters and using uppercase `M` for mean and uppercase `S` for std
6. Aggregate by activity and subject and compute the mean of all numeric variables
7. Add activity labels, and remove the activity code column
8. Save the tidy data set to a file, called - `tidyData.txt`

