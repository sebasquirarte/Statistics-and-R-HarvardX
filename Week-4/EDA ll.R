# Statistics and R | HarvardX 
# Week 4: The Exploratory Data Analysis 2 
# Sebastian Quirarte | sebastianquirajus@gmail.com | 17/Mar/23

install.packages("UsingR")
library(UsingR)

# Load data
data("father.son")
dat <- father.son
# View data 
head(dat)
tail(dat)
str(dat)

plot(dat$fheight, dat$sheight)

# ------------------------ Robust Summary Statistics ------------------------- # 

## MAD (Median Absolute Diviation)

# 1.4826median{|Xi - median(Xi)|}

# In statistics, the median absolute deviation (MAD) is a robust measure of the 
# variability of a univariate sample of quantitative data.

## Spearman correlation 

# In statistics, Spearman's rank correlation coefficient or Spearman's ρ, named 
# after Charles Spearman and often denoted by the Greek letter rho ρ, is a 
# nonparametric measure of rank correlation (statistical dependence between the
# rankings of two variables). It assesses how well the relationship between two 
# variables can be described using a monotonic function.

# In genomics data, where outliers are common, the median, the MAD, and other 
# robust statistics are usually preferable.






