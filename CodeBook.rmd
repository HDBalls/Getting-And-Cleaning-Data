CodeBook
---------------------------------------------------------------
This codebook will show all the transformations as well as the extract and load steps that determined the run_analysis.R
It will also define the variables in the final data extract.

##Dataset Information:

The dataset was obtained from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
 
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. 
Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. 
The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). 
The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. 
The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.
The data set used can be downloaded from <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>. 

##Input Data & Source files

The following data files were provided.:

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.
- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

##Loads and Transformations

The following transformations and loads were done:

- `X_train.txt` is loaded into `features_Train`.
- `y_train.txt` is loaded into `activity_Train`.
- `subject_train.txt` is loaded into `subject_Train`.
- `X_test.txt` is loaded into `features_Test`.
- `y_test.txt` is loaded into `activity_Test`.
- `subject_test.txt` is loaded into `subject_Test`.
- `features.txt` is loaded into `feature_Names`.
- `activity_labels.txt` is loaded into `activity_Labels`.
- The subjects in both the training and test datasets were merged to form a single dataset - subject`.
- The activities in training and test datasets were merged to form a single dataset - `activity`.
- The features of both the test and training datasets were merged to form a single dataset - `features`.
- The name of all the features were updated using the`feature_Names` file.
- The `features`, `activity` and `subject` datasets were merged to form a single dataset - `complete_Data`.
- All columns that contain std or mean in either activity or subject were moved into a new dataset`required_Columns` .
- The `extracted_Data` dataset is created with data from columns in the `required_Columns` dataset (above).
- The Activity` column existing in the `extracted_Data` datasets is updated with descriptive names of the activities extracted from `activity_Labels`. 
- The `Activity` column is changed to a factor variable.
- Acronyms and abbreviations in variable names in the `extracted_Data` datasets eg 'Acc', 'Gyro', 'Mag', 't' and 'f' are replaced with more descriptive labels such as 'Accelerometer', 'Gyroscpoe', 'Magnitude', 'Time' and the 'Frequency'.
- The `tidyData` datasets is created as a set with the following: average for each activity as well as the subject of `extractedData`. 
- The entries in  the`tidyData` datasets are sorted based on the activity and subject.
- All the data in the `tidyData` datasets is written into a file called `Final_Tidy_Data.txt`.

##Output Data Set Format

The output : `Final_Tidy_Data.txt` is a a space-delimited  file. 
The header line contains the names of the variables. 

##Output Data Set Data
The 'Final_Tidy_Data.txt`file contains the mean and standard deviation values of the data derived from the input files that were provided
