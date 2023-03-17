# Statistics and R | HarvardX 
# Week 3: Inference P-values, Confidence Intervals and Power Calculations
# Sebastian Quirarte | sebastianquirajus@gmail.com | 17/Mar/23

# ------------------------ Confidence Intervals ------------------------------ #

# A confidence interval includes information about your estimated effect size 
# and the uncertainty associated with this estimate. Here we use the mice data 
# to illustrate the concept behind confidence intervals. 

chowPopulation <- read.csv("Week-3/FemaleControlsPopulation.csv")
chowPopulation <- unlist(chowPopulation)

mean(chowPopulation) # > 23.89338

# Calculating mean of a sample of the population 
n <- 30 
chow <- sample(chowPopulation, n)
mean(chow) # > 22.87033

# Standard error (Assuming normal distribution)
se <- sd(chow)/sqrt(n)
se # > 0.5577412

# A 95% confidence interval (we can use percentages other than 95%) is a random 
# interval with a 95% probability of falling on the parameter we are estimating. 
# Keep in mind that saying 95% of random intervals will fall on the true value 
# (our definition above) is not the same as saying there is a 95% chance that the 
# true value falls in our interval. 

pnorm(2) - pnorm(-2)

Q <- qnorm(1- 0.05/2)
interval <- c(mean(chow)-Q*se, mean(chow)+Q*se )
interval

interval[1] < mean(chow) & interval[2] >mean(chow)

library(rafalib)
B <- 250
mypar()
plot(mean(chowPopulation)+c(-7,7),c(1,1),type="n",
     xlab="weight",ylab="interval",ylim=c(1,B))
abline(v=mean(chowPopulation))
for (i in 1:B) {
  chow <- sample(chowPopulation, n)
  se <- sd(chow)/sqrt(n)
  interval <- c(mean(chow)-Q*se, mean(chow)+Q*se)
  covered <- 
    mean(chowPopulation) <= interval[2] & mean(chowPopulation) >= interval[1]
  color <- ifelse(covered,1,2)
  lines(interval, c(i,i),col=color)
}

# Small sample size and the CLT

mypar()
plot(mean(chowPopulation)+c(-7,7),c(1,1),type="n",
     xlab="weight",ylab="interval",ylim=c(1,B))
abline(v=mean(chowPopulation))
Q <- qnorm(1- 0.05/2)
N <- 5
for (i in 1:B) {
  chow <- sample(chowPopulation,N)
  se <- sd(chow)/sqrt(N)
  interval <- c(mean(chow)-Q*se, mean(chow)+Q*se)
  covered <- mean(chowPopulation) <= interval[2] & mean(chowPopulation) >= interval[1]
  color <- ifelse(covered,1,2)
  lines(interval, c(i,i),col=color)
}

# ---------------------------- Power Calculations ---------------------------- #

# Statistical power is the the probability of rejecting the null hypothesis when 
# the alternative is true.

# ------------------------- Monte Carlo Simulations -------------------------- # 

# A Monte Carlo simulation is a model used to predict the probability of a variety 
# of outcomes when the potential for random variables is present. 
# Monte Carlo simulations help to explain the impact of risk and uncertainty in 
# prediction and forecasting models.

# The rnom(n,mean,sd) allows us to create random variables.







