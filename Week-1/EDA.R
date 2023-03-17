# Statistics and R | HarvardX Course 
# Week 1.5: Introduction to Exploratory Data Analysis
# Sebastian Quirarte | sebastianquirajus@gmail.com | 12 Mar 23 

# Exploratory Data Analysis (EDA) is a key part of what we do when we analyze data.

# We start out every analysis with EDA to familiarize ourselves with the data. 
# First, we want to check to see if some of the samples or experiments produce 
# unusable data and take them out of the analysis.

# We also perform EDA at the end to check for nonsensical results.
# We will introduce some basic EDA tools such as histogram, the Q-Q plot, scatter plots, 
# boxplot, stratification, log transforms, and several summary statistics.

# ------------------------------ Histogram ----------------------------------- #

install.packages("UsingR")
library(UsingR)

# Getting height data 
x <- father.son$fheight
length(x) # There are 1078 individuals in our data set 

# Sample of 20 heights, rounding to 1 decimal place 
round(sample(x, 20), 1)

# Creating histogram 
hist(x, main = "Height Histogram", xlab = "Height in Inches")

# Empirical commutative distribution function 

# Reports the the % of individuals that are below a certain threshold
xs <- seq(floor(min(x)), ceiling(max(x)), 0.1)

# Ploting function 
plot(xs, ecdf(x)(xs), type="l",
     xlab = "Height in Inches", ylab = "F(x)")

# ------------------------------- QQ-Plot ------------------------------------ #

# Quantile-Quantile (Q-Q) plot 
ps <- seq(0.01, 0.99, 0.01)
qs <- quantile(x, ps)
normalqs <- qnorm(ps, mean(x), sd(x))
plot(normalqs, qs, xlab = "Normal Percentiles", ylab = "Height Percentiles")
abline(0,1) # Identity line 

# Function to compare Q-Q plot to normal distribution 
qqnorm(x)
qqline(x)

# ----------------------- QQ-Plot Exercises ---------------------------------- #

# Loading data 
load("Week-1/skew.RData")
# 1000 x 9 dimensional matrix 'dat'
dim(dat)

# Using QQ-plots, compare the distribution of each column of the matrix to a normal. 
# That is, use qqnorm() on each column.

# To accomplish this quickly, you can use the following line of code to set up a grid for 3x3=9 plots.
par(mfrow = c(3,3))

# Then you can use a for loop, to loop through the columns, and display one qqnorm() plot at a time. 
for (i in 1:9) {
  qqnorm(dat[,i])
}

# Columns 4 and 9 are skewed
par(mfrow = c(1,1))
hist(dat[,4]) # Positive skew 
hist(dat[,9]) # Negative skew 

# ---------------------------- Boxplot --------------------------------------- #
hist(exec.pay)
qqnorm(exec.pay)
qqline(exec.pay)

boxplot(exec.pay, ylab = "10,000s of USD$", ylim = c(0, 400))
mean(exec.pay)
median(exec.pay)

# ---------------------- Boxplot Exercises ----------------------------------- #

# The InsectSprays data set measures the counts of insects in agricultural 
# experimental units treated with different insecticides. 
head(InsectSprays)
InsectSprays

# Create boxplot 
plot <- ggplot(data = InsectSprays, aes(x = spray, y = count))
plot + geom_boxplot()

# Let's consider a random sample of finishers from the New York City Marathon in 2002. 
# This dataset can be found in the UsingR package. Load the library and then load the nym.2002 dataset.

# Use boxplots and histograms to compare the finishing times of males and females. 
# Which of the following best describes the difference?

# Boxplots 
boxplot_NY <- ggplot(data = nym.2002, aes(x = gender, y = time))
boxplot_NY + geom_boxplot()  


