# clean-har-dataset
Course proj in Getting & Cleaning data - work with HAR project dataset

= Contents =

The repo consists of the following files:

- run_analysis.R - R script to clean and summarize the data
- README.md - README file describing the high level info about running the script
- CodeBook.md - File describing the variables, data and the transformation applied

= Pre-requisites =

* The script requires 'dplyr' package to be installed
* The following files from the UCI HAR dataset folder must be present in the SAME FOLDER/PATH as the run_analysis.R:
  ** activity_labels.txt
  ** features.txt
  ** y_train.txt
  ** subject_train.txt
  ** X_train.txt
  ** y_test.txt
  ** subject_test.txt
  ** X_test.txt

= Running the script =

* After copying the run_analysis.R and the rest of the text files to the
  same folder, you may wish to run the script from command line or RStudio
  or any other means you prefer.
* Running the script should produce a 'tidy_data.txt' file after completion
* Details of the variables in 'tidy_data.txt' are explained in CodeBook.md

= References =

* The following sources were referenced when working on this project

  - Course material and videos/slides
  - Discussion board threads. In particular, the following 2 thread were
    referenced heavily:
    https://class.coursera.org/getdata-010/forum/thread?thread_id=49
    https://class.coursera.org/getdata-010/forum/thread?thread_id=241

  - Tidy data research paper - http://vita.had.co.nz/papers/tidy-data.pdf
