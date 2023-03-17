# Statistics and R | HarvardX 
# Week 2: Random Variables and Probability Distributions
# Sebastian Quirarte | sebastianquirajus@gmail.com | 15/Mar/23

# ----------------------- Install and Load Library/Data ---------------------- # 

install.packages("dplyr", "ggplot2") 
library(dplyr)
library(ggplot2)

# Load data 
mice_data <- read.csv("Week-2/femaleMiceWeights.csv")
# View data 
mice_data

# -------- Seperate control (chow) and treatment (high fat, hf) diets -------- # 

# Filter control (chow) data (long version)
chow <- filter(mice_data, Diet == "chow")
chow <- select(chow, Bodyweight)
chow <- unlist(chow)
# View data 
chow 

# Filter control (chow) data (short version)
hf <- filter(mice_data, Diet == "hf") %>% select(Bodyweight) %>%
  unlist
# View data 
hf 

# ------------------------------ Compare data -------------------------------- # 

mean(chow)
mean(hf)

mean(hf) - mean(chow) # > 3.02 

# Box plot 
ggplot(data=mice_data, aes(x=Diet, y=Bodyweight, color=Diet)) + geom_point() +
  geom_boxplot(alpha=0.6) 

# There is an increase of 3.02 in the mean weight of mice that were given the 
# high fat (hf) diet. Is this statistically significant?

# ----------------------------- Sample of Data ------------------------------- # 

# In statistics, the data obtained from an experiment is considered a random variable
# because if the experiment is repeated the values won't be exactly the same. 

# Load population data 
population <- read.csv("Week-2/femaleControlsPopulation.csv")
# View and get info about data 
head(population)
tail(population)
nrow(population)

# Transform dataframe into numeric vector 
population <- unlist(population)
# Sample() function takes a random sample of size n from a data set
sample(population, 10) 

# --------------------------- Random Variables Exercises --------------------- # 

# Using data from "femaleControlsPopulation.csv" 

# What is the average of these weights?
mean(population) # > 23.89338

# Set the seed to 1:
set.seed(1)
# Take a random sample of size 5. What is the absolute value (use abs()) of the 
# difference between the average of the sample and the average of all the values?
abs(mean(sample(population, 5)) - mean(population)) # > 0.3293778

# After setting the seed at 5,
set.seed(5)
# take a random sample of size 5. What is the absolute value of the difference 
# between the average of the sample and the average of all the values? 
abs(mean(sample(population, 5)) - mean(population)) # > 0.3813778

# Why are the answers from 2 and 3 different?
# > Because the average of the samples is a random variable. 

# -------------- Introduction to null distributions and p-values ------------- # 

# The null hypothesis indicates that there is no significant difference between treatments. 

# Comparing treatment and control with null hypothesis (treatment = control)
n <- 10000
nulls <- vector("numeric", n)
for (i in 1:n) {
  treatment_null <- sample(population, 12)
  control_null <- sample(population, 12)
  nulls[i] <- (mean(treatment_null) - mean(control_null))
}

# Histogram of null hypothesis values 
hist(nulls)

# p-value, How often was the null hypothesis was larger than the observed value 
obs <- mean(hf - chow)
# The p-value is the answer to the question: What is the probability that an 
# outcome from the null distribution is bigger than what we observed when the 
# null hypothesis is true?
mean(abs(nulls) > obs) # > p-value = 0.028

# ----------------------- Null Distribution Exercises  ----------------------- #

# Using data from "femaleControlsPopulation.csv" 

# Set the seed at 1, then using a for-loop take a random sample of 5 mice 1,000 times.
# Save these averages.
set.seed(1)
avg_weights <- vector("numeric", 1000)
for (i in 1:1000) {
  avg_weights[i] <- mean(sample(population, 5))
}
avg_weights
mean(population)
mean(avg_weights)
# What proportion of these 1,000 averages are more than 1 gram away from the 
# average of the population?
values <- ((avg_weights) > (mean(population) + 1) | (avg_weights < (mean(population)-1)))
mean(values) # > 0.503

# We are now going to increase the number of times we redo the sample from 1,000 
# to 10,000. Set the seed at 1, then using a for-loop take a random sample of 5 
# mice 10,000 times. Save these averages.
set.seed(1)
avg_weights <- vector("numeric", 10000)
for (i in 1:10000) {
  avg_weights[i] <- mean(sample(population, 5))
}
avg_weights
mean(population)
mean(avg_weights)
# What proportion of these 10,000 averages are more than 1 gram away from the 
# average of x (population)?
values <- ((avg_weights) > (mean(population) + 1) | (avg_weights < (mean(population)-1)))
mean(values) # > 0.5084

# --------------------- Probability Distributions Exercises ------------------ #

# Load data 
install.packages("gapminder")
library(gapminder)
data(gapminder)
dat <- gapminder 

# View data 
head(dat)

# Create a vector x of the life expectancy of each country for the year 1952. 
# Plot a histogram of these life expectancy to see the spread of the different countries.
x <- filter(dat, year == 1952) %>% select(lifeExp) %>% unlist
hist(x)
x

# What is the proportion of countries in 1952 that have a life expectancy less 
# than or equal to 40?
mean(x <= 40) # > 0.2887324

# -------------------- sapply() on a custom function ------------------------- #

# Suppose we want to plot the proportions of countries with life expectancy q for 
# a range of different years. R has a built in function for this, plot(ecdf(x)),
# but suppose we didn't know this. The function is quite easy to build, by turning
# the code from previous question into a custom function, and then using sapply().

# Our custom function will take an input variable q, and return the proportion of 
# countries in x less than or equal to q. The curly brackets, { and }, allow us 
# to write an R function which spans multiple lines:

prop = function(q) {
  mean(x <= q)
}

# Try this out for a value of q: prop(40)
prop(40)

# Now let's build a range of qs that we can apply the function to:
qs = seq(from=min(x), to=max(x), length=20)

# Print qs to the R console to see what the seq() function gave us. 
qs

# Now we can use sapply() to apply the prop function to each element of qs:
props = sapply(qs, prop)

# Take a look at props, either by printing to the console, or by plotting it over qs:
plot(qs, props)

# Note that we could also have written this in one line, by defining the prop 
# function inside of sapply() but without naming it:
    
props = sapply(qs, function(q) mean(x <= q))

# This last style is called using an "inline" function or an "anonymous" function. 
# Let's compare our homemade plot with the pre-built one in R:

plot(ecdf(x))


 

