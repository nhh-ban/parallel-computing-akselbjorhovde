# Load the tictoc package for timing
library(tictoc)
library(tidyverse)
library(knitr)

tic.clearlog()

# Timing the execution of the three methods
#1
tic("Original Script")
source("scripts/1 Original Solution.R")
toc(log = TRUE)
#2
tic("Parallel Loop")
source("scripts/2 Parallel computing.R")
toc(log = TRUE)
#3
tic("Parallel MTweedieTests")
source("scripts/3 Modify MTweedieTest.R")
toc(log = TRUE)

#Get the timing log
tl <- tic.log()

df <- data.frame(Operation = character(0), Time = character(0))

#Go through the log and split each entry
for (i in 1:length(tl)) {
  entry <- tl[[i]]
  split_entry <- strsplit(entry, ": ")
  
  #Extract the source and time
  operation <- split_entry[[1]][1]
  time <- split_entry[[1]][2]
  
  df <- rbind(df, data.frame(Operation = operation, Time = time))
}

print(df)

#-----------------------------------------------------------------------------
#Answers:
#Observe that 1,2,3 uses from more to less time.
#It is probably because initial only uses one core for the five different N's (>10000)
#The second uses one core for each of the N's so will be faster, less operations per core,
#but one core still has to prosess a large number of N (=10000).
#The third splits the calculations evenly between the cores and is most efficient(N<10000)