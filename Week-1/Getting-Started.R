# Statistics and R | HarvardX Course 
# Week 1: Getting Started 
# Sebastian Quirarte | sebastianquirajus@gmail.com | 11 Mar 23 

# --------------------- First Assignment: Exercises -------------------------- #

# Create a numeric vector containing the numbers 2.23, 3.45, 1.87, 2.11, 7.33, 18.34, 19.23.
v <- c(2.23, 3.45, 1.87, 2.11, 7.33, 18.34, 19.23)

# What is the average of these numbers?
mean(v) # > 7.794286

# Use a loop to determine the value of i^2 for i = 1 to i = 25.
sum <- 0 

for (i in (1:25)) {
  i <- i^2 
  sum <- sum + i
}

sum # > 5525 

# The cars dataset is available in base R. You can type cars to see it. 
# Use the class() function to determine what type of object is cars.

# Load data set 
data(cars)
# Display type of object 
class(cars) # > data.frame 

# How many rows does the cars object have? 
nrow(cars) # > 50 

# What is the name of the second column of cars? 
colnames(cars)[2] # > "dist" 

# The simplest way to extract the columns of a matrix or data.frame is using [. 
# For example you can access the second column with cars[,2].
cars[,2] # displays as vector 

cars["dist"] # displays as data frame 

# What is the average distance traveled in this dataset?
mean(cars[,2]) # > 42.98

# Familiarize yourself with the which() function. Which row of cars has a a distance of 85?
which(cars["dist"] == 85) # > 50 

# --------------------- Getting Started: Exercises --------------------------- #

# Read in the file femaleMiceWeights.csv and report the exact name of the column containing the weights.
data <- read.csv("Week-1/femaleMiceWeights.csv")
head(data) # > 'Bodyweight'

# The [ and ] symbols can be used to extract specific rows and specific columns of the table.
# What is the entry in the 12th row and second column?
data[12,2] # > 26.25
  
# You should have learned how to use the $ character to extract a column from a 
# table and return it as a vector. Use $ to extract the weight column and report 
# the weight of the mouse in the 11th row.
data$Bodyweight[11] # > 26.91

# The length() function returns the number of elements in a vector.
# How many mice are included in our dataset?
length(data$Bodyweight) # > 24

# To create a vector with the numbers 3 to 7, we can use seq(3,7) or,
# because they are consecutive, 3:7. View the data and determine what rows are 
# associated with the high fat or hf diet. Then use the mean() function to compute 
# the average weight of these mice.
seq(3,7) # > 3 4 5 6 7 
3:7 # > 3 4 5 6 7 

# High fat (hf) data 
data$Bodyweight[13:24]

# What is the average weight of mice on the high fat diet?
mean(data$Bodyweight[13:24]) # > 26.83417

# One of the functions we will be using often is sample(). Read the help file for
# sample() using ?sample. Now take a random sample of size 1 from the numbers 13
# to 24 and report back the weight of the mouse represented by that row. Make sure 
# to type set.seed(1) to ensure that everybody gets the same answer.
?sample

# Returns random number from 13-24, using seed(1) so always returns 21 after seed cmd is run
set.seed(1)
sample(13:24, 1) # > 21

data$Bodyweight[21] # > 34.02

# -------------- Importing and Manipulating Data with dplyr ------------------ #

# The dplyr package makes it easier to code data manipulations and read said code

# Install and load dplyr package 
install.packages("dplyr")
library(dplyr)

# Load data 
data <- read.csv("Week-1/femaleMiceWeights.csv")
# View data
data 

# Using filter command 
chow <- filter(data, Diet == "chow")
chow
# Using select command 
Bodyweight <- select(chow, Bodyweight)
Bodyweight
# Convert dataframe to vector 
unlist(Bodyweight)
class(unlist(Bodyweight)) # > "numeric" 

# Using pipe command (does the same as the laste three commands)
controls <- filter(data, Diet == "chow") %>% select(Bodyweight) %>% unlist 
controls

# --------------------------- dplyr exercises -------------------------------- #

# Download data 
install.packages("downloader")
library(downloader)
url = "https://raw.githubusercontent.com/genomicsclass/dagdata/master/inst/extdata/msleep_ggplot2.csv"
filename <- basename(url)
download(url,filename)

# Read data 
data <- read.csv("Week-1/msleep_ggplot2.csv")
head(data)

# Read in the msleep_ggplot2.csv file with the function read.csv() and use the 
# function class() to determine what type of object is returned.
class(data)

# Now use the filter() function to select only the primates.
primates <- filter(data, order == "Primates")
# How many animals in the table are primates?
nrow(primates)

# What is the class of the object you obtain after subsetting the table to only include primates?
class(primates)

# Now use the select() function to extract the sleep (total) for the primates.
primates_sleep <- select(primates, sleep_total)
# What class is this object?
class(primates_sleep) # > "data.frame"

# Using pipes
primates_sleep <- filter(data, order == "Primates") %>% select(primates, sleep_total)
primates_sleep

# Now we want to calculate the average amount of sleep for primates (the average
# of the numbers computed above). One challenge is that the mean() function requires 
# a vector so, if we simply apply it to the output above, we get an error. 
# Look at the help file for unlist() and use it to compute the desired average.
unlist(primates_sleep)

# What is the average amount of sleep for primates?
mean(unlist(primates_sleep)) # > 10.5

# For the last exercise, we could also use the dplyr summarize() function. 
# We have not introduced this function, but you can read the help file and repeat 
# exercise 5, this time using just filter() and summarize() to get the answer.
?summarize

# What is the average amount of sleep for primates calculated by summarize()
summarize(primates, mean(sleep_total)) # > 10.5 



