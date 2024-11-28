#28.11.2024_Louise CHORFI
#résultats, stat et graph sur les escaliers cup

#clean environment and load packages:
rm(list=ls())
library(lubridate)
library(ggplot2)
library(dplyr)
library(tidyr)

#import data from excel
results <- read.table(file = "C:/Users/l_chorfi/Documents/autres exp/R training/escalier cup/results_escalierscup.csv",
           header = TRUE, sep =";")
summary(results) # note : all times are classified as character

#parse dates and times
results$date <- dmy(results$date)
results$date <- as.numeric(results$date)

View(results)

for ( i in 5:10){
  timeconvert <- results[i]  
  print(timeconvert)
  timeconvert <- lapply(timeconvert, hms)
  print(timeconvert)
  summary(timeconvert)
  results[i] <- timeconvert
  }

results[5:10] <- lapply(results[5:10], period_to_seconds)

#add columns for each exercise duration
results$dur_start <- results$start

for ( i in 6:10) {
  results [paste("dur_", colnames(results[i]), sep ="")] <- results[i]- results[i-1]
}
  
results <- rename(results, dur_fullsprint = dur_total)
summary(results)

#actually observation are times and duration !!! 
#need to get to a 
long_results <- results %>%
  pivot_longer(cols = c("start","sprint_top","squat","pyramide", "side",
                        "total", "dur_start", "dur_sprint_top","dur_squat",
                        "dur_pyramide","dur_side", "dur_fullsprint"),
               names_to = "exercise", values_to = "value")

notsolong_results <- long_results %>%
  pivot_wider(names_from = starts_with("dur_"), values_from = "value")



#leeets make some graph :V
time_graph <- ggplot_

#create readable table 
read_results <- results
read_results$date <- as_date(read_results$date)
read_results[5:15] <- lapply(read_results[5:15], seconds_to_period)
View(read_results)
