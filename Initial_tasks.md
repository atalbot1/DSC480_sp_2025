## DSC 480 Initial tasks

The study group is `Unicare-study`

-   Computational setup
    -   Set up IDEs, github repos, fork, clone to machine
-   Summary stats/exploratory for the `events` and `report` tables
-   check Erik's values in the google docs <https://docs.google.com/spreadsheets/d/1Jf4D3LjJ49RnQsqT4BSUVtXIk1SqiXzcHipsk1egrj4/edit?usp=sharing> `Unicare-study` vs all combined. For this, `2025-1-15_data_check.qmd` will get you started. See below.
    -   total admissions on ibis vs pre-ibis
    -   coverage days on ibis vs pre-ibis
    -   reproduce the admissions count bar plots (in R of course)
-   Descriptive statistics for combined `Unicare` when using Ibis vs `MIIA` when not using Ibis.
    -   See `Ibis-MIIA.qmd`. There is a lot there but just look at the first few code chunks to start.
        -   It uses `first_reminder_complete_date` as the ibis start date (See below). This needs to be change and the analysis run again.
    -   total days under observation
    -   total inpatient days
    -   proportion with at least one inpatient admission
    -   inpatient admission counts
-   Descriptive statistics for pre-Ibis vs during Ibis. (See `2024-pre-post.Rmd`)
-   Write a function that takes a filename as an argument and reads and cleans the file. All you need to do is make the code in `read_clean.R` into a function.

### The data

#### `events` table

Each row is an event- hospital admission, ER, etc

#### `report` table

Each row corresponds to a patient. So this is more like a `patient` table. it contains all the patient information such as age, and chronic conditions. There is a lot of overlap in the two tables. Importantly, the patient id `pid` is common. Often you will want to create data frames by joining on `pid`. The file `read_clean.R` will read in the data and do a little cleaning. You should understand and be able to explain what it is doing. It creates two data frames:

-   `events_full`
-   `report_full`

#### Important dates

-   `coverage_start_date`
-   `ibis_coverage_start_date`
-   `ibis_coverage_end_date`

Typically, `coverage_start_date < ibis_coverage_start_date < ibis_coverage_end_date`, and these dates define when a patient was using the Ibis tablet device. The idea is to compare different groups; either using Ibis or not, or to compare pre-ibis

#### Data files

`2024_11_25_utilization_report.csv` `2024_11_25_utilization_events.csv`

Until CITI training is complete we will work with toy versions of these data sets, where the row values for all the columns have been shuffled independently.

#### R and Quarto files

-   `read_clean.R`
-   `2025-1-15_data_check.qmd`
-   `Ibis_MIIA.qmd`

You are welcome to use .R or Quarto files for your work. Sometimes .R files are more handy for experimenting or for scratch work. Finished work reports should be Quarto, rendered as html or pdf.
