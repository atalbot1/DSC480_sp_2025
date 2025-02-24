
library(tidyverse)
library(lubridate)
source("read_clean.R")

# Read and process data
events <- read_clean("events_toy.csv")
report <- read_clean("report_toy.csv")

# Define a function to replace dates with days since coverage_start_date and create logical columns
convert_dates_to_days <- function(df) {
  df <- df %>%
    mutate(across(contains("timestamp"), ~as.POSIXct(.x, origin = "1970-01-01", tz = "UTC"))) %>%
    mutate(across(contains("timestamp"), ~as_date(.x))) %>%
    rename_with(~str_replace(., "timestamp", "date"), contains("timestamp"))
  
  if(all(c("coverage_start_date", "ibis_coverage_start_date", "ibis_coverage_end_date") %in% colnames(df))) {
    df <- df %>%
      mutate(across(contains("date"), ~as.numeric(.x - coverage_start_date), .names = "days_since_{col}")) %>%
      select(-contains("date")) %>%
      mutate(event_between_coverage = if_else(days_since_coverage_start_date >= 0 & days_since_coverage_start_date <= days_since_ibis_coverage_start_date, 1, 0),
             event_between_ibis_coverage = if_else(days_since_ibis_coverage_start_date >= 0 & days_since_ibis_coverage_start_date <= days_since_ibis_coverage_end_date, 1, 0)) %>%
      mutate(agreement_coverage = if_else(event_between_coverage == existing_coverage_column, TRUE, FALSE),
             agreement_ibis_coverage = if_else(event_between_ibis_coverage == existing_ibis_column, TRUE, FALSE))
  }
  
  return(df)
}

# Apply transformation to both datasets
events_full <- convert_dates_to_days(events)
report_full <- convert_dates_to_days(report)

# Function to tweak dates by adding a random number of days
tweak_dates <- function(df) {
  df <- df %>%
    mutate(across(contains("timestamp"), ~ .x + runif(n(), -5, 5) * 86400))
  return(df)
}

# Apply to toy dataset
toy_data <- tibble(timestamp = c(rep(1732424400, 10)))
toy_data_tweaked <- tweak_dates(toy_data)



