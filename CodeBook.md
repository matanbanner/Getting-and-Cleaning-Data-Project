## What does the run_analysis.R do:

1. Download the data as zip file

2. Extracting the file

3. Prepare test/train data sets:
  3.1 Reading data set from the files X_*.txt and y_*.txt (* can be test or train)
  3.2 Reading subject data from the files subject_*.txt
  3.3 For each test or train, binding the columns of the all above (e.g for test: subject_column | x_test_columns | y_test_column)

4. Reading data's feature names (the column names for the sets) from the file features.txt

5. Binding test and train by rows to create a single data frame

6. Name the columns for the data set by the features we read and adding names for subject and y column. We name the y_column to be "activity"

7. save in the data frame only the columns: subject, activity and the ones which ends with mean() or std()

8. Reading activity labels names from activity_labels.txt

9. Replace the numerical labels in activity column with descriptive names

10. Break rows by subject and activity, and for each group of rows calculate the mean for each of the variables

11. Order the data frame by subject than by activity

11. Save the data frame in a new file, group_data.csv
