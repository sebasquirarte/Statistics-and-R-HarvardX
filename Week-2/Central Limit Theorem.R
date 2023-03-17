# Statistics and R | HarvardX 
# Week 2.5: Central Limit Theorem
# Sebastian Quirarte | sebastianquirajus@gmail.com | 16/Mar/23

# The mean is represented by miu (μ) and the standard deviation by sigma (σ)

# Standarized units are calculated by subtracting the mean and dividing by the 
# sandard deviation, this tells us how many standard deviations a given value is
# from the mean

# ---------------------- Normal Distribution Exercises ----------------------- # 

# Using data from "femaleControlsPopulation.csv" 

# Import data 
x <- read.csv("Week-2/femaleControlsPopulation.csv") %>% unlist
# View data 
x 

# Here x represents the weights for the entire population.
# Using the same process as before (in Null Distribution Exercises), set the 
# seed at 1, then using a for-loop take a random sample of 5 mice 1,000 times. 
# Save these averages. After that, set the seed at 1, then using a for-loop take 
# a random sample of 50 mice 1,000 times. Save these averages:

# make averages5
set.seed(1)
n <- 1000
averages5 <- vector("numeric", n)
for(i in 1:n){
  X <- sample(x, 5)
  averages5[i] <- mean(X)
}

# make averages50
set.seed(1)
n <- 1000
averages50 <- vector("numeric",n)
for(i in 1:n){
  X <- sample(x,50)
  averages50[i] <- mean(X)
}

averages5
averages50

# Use a histogram to "look" at the distribution of averages we get with a sample 
# size of 5 and a sample size of 50. How would you say they differ?
hist(averages5)
hist(averages50)
# Answer: They both look roughly normal, but with a sample size of 50 the spread 
# is smaller.

# For the last set of averages, the ones obtained from a sample size of 50, what 
# proportion are between 23 and 25?
mean(averages50 < 23 | averages50 > 25) # > 0.018 
1 - 0.018 # > 0.982 

# Note that you can use the function pnorm() to find the proportion of observations
# below a cutoff x given a normal distribution with mean mu and standard deviation 
# sigma with pnorm(x, mu, sigma) or pnorm( (x-mu)/sigma ).

# What is the proportion of observations between 23 and 25 in a normal distribution 
# with average 23.9 and standard deviation 0.43?
pnorm(25, 23.9, 0.43) - pnorm(23, 23.9, 0.43) # > 0.9765648

# ---------------- Population, Samples, and Estimates Exercises -------------- #

# Using 'micepheno.csv' 

# Loda data 
dat <- read.csv("Week-2/mice_pheno.csv")
# View data 
head(dat)
tail(dat)
nrow(dat)
# Clean data (remove na values)
dat <- na.omit(dat)
nrow(dat)

# Use dplyr to create a vector x with the body weight of all males on the control 
# (chow) diet. #What is this population's average?
library(dplyr)
x <- filter(dat, Diet == "chow", Sex == "M") %>% select(Bodyweight) %>% unlist
mean(x) # > 30.96381

# Now use the rafalib package and use the popsd() function to compute the 
# population standard deviation.
install.packages("rafalib")
library(rafalib)

?popsd

popsd(x) # > 4.420501

# Set the seed at 1. Take a random sample  of size 25 from x.
# What is the sample average?

set.seed(1)
X <- sample(x, 25)
mean(X)

# Use dplyr to create a vector 'y' with the body weight of all males on the high 
# fat (hf) diet. What is this population's average? 
y <- filter(dat, Diet == "hf", Sex == "M") %>% select(Bodyweight) %>% unlist
mean(y)

# Now use the rafalib package and use the popsd() function to compute the 
# population standard deviation. 
popsd(y) # > 5.574609

# Set the seed at 1. Take a random sample  of size 25 from y. 
# What is the sample average?
set.seed(1)
mean(sample(y, 25)) # > 35.8036

# What is the difference in abs value between ybar - xbar and Ybar and Xbar?
set.seed(1)
Y <- sample(y, 25)

abs((mean(y) - mean(x)) - (mean(Y) - mean(X))) # 1.399884

# Repeat the above for females, this time setting the seed to 2.
# What is the difference in abs value between ybar - xbar and Ybar and Xbar?
x <- filter(dat, Diet == "chow", Sex == "F") %>% select(Bodyweight) %>% unlist
y <- filter(dat, Diet == "hf", Sex == "F") %>% select(Bodyweight) %>% unlist

set.seed(2)
X <- sample(x, 25)
set.seed(2)
Y <- sample(y, 25)

abs((mean(y) - mean(x)) - (mean(Y) - mean(X))) # 0.3647172

# -------------------- Central Limit Theorem Exercises ----------------------- #

# If a list of numbers has a distribution that is well approximated by the normal 
# distribution, what proportion of these numbers are within one standard deviation
# away from the list's average?

# > 0.6826 

# What proportion of these numbers are within two standard deviations away from 
# the list's average?

# > 0.9544

# What proportion of these numbers are within three standard deviations away 
# from the list's average? 

# > 0.997

# Define y to be the weights of males on the control diet ('mice_pheno.csv')
y <- read.csv("Week-2/mice_pheno.csv")
y <- filter(y, Diet == "chow", Sex == "M") %>% select(Bodyweight) %>% unlist
y <- na.omit(y)

# What proportion of the mice are within one standard deviation away from the 
# average weight? 
prop <- function (x, n=1) {
  m <- mean(x); s <- n*sd(x)
  mean((x > m - s) & (x < m + s))
}

prop(y) # > 0.6950673

# What proportion of these numbers are within two standard deviations away from 
# the list's average?
prop(y, 2) # > 0.9461883

# What proportion of these numbers are within three standard deviations away from 
# he list's average?
prop(y, 3) # > 0.9910314

# Here we are going to use the function replicate() to learn about the distribution
# of random variables. All the above exercises relate to the normal distribution 
# as an approximation of the distribution of a fixed list of numbers or a population.
# We have not yet discussed probability in these exercises. If the distribution of 
# a list of numbers is approximately normal, then if we pick a number at random 
# from this distribution, it will follow a normal distribution. However, it is 
# important to remember that stating that some quantity has a distribution does
# not necessarily imply this quantity is random. Also, keep in mind that this is 
# not related to the central limit theorem. The central limit applies to averages
# of random variables. Let's explore this concept.

# We will now take a sample of size 25 from the population of males on the chow 
# diet. The average of this sample is our random variable. We will use the replicate() 
# function to observe 10,000 realizations of this random variable. Set the seed at 1, 
# then generate these 10,000 averages. Make a histogram and qq-plot of these 10,000 
# numbers against the normal distribution.
y <- filter(dat, Sex=="M" & Diet=="chow") %>% select(Bodyweight) %>% unlist
set.seed(1)
avgs <- replicate(10000, mean( sample(y, 25)))
mypar(1,2)
hist(avgs)
qqnorm(avgs)
qqline(avgs)
# We can see that, as predicted by the CLT, the distribution of the random variable
# is very well approximated by the normal distribution.

# What is the average of the distribution of the sample average?
mean(avgs) # > 30.96856

# What is the standard deviation of the distribution of sample averages (use popsd())?
popsd(avgs)
  
# --------------------------------- t-test  ---------------------------------- #

library(dplyr)
dat <- read.csv("Week-2/femaleMiceWeights.csv") #previously downloaded

control <- filter(dat,Diet=="chow") %>% select(Bodyweight) %>% unlist
treatment <- filter(dat,Diet=="hf") %>% select(Bodyweight) %>% unlist

?t.test

t.test(control, treatment)
# > t =¨-2.0552, df (degrees of freedom) = 20.236, p-value = 0.053








