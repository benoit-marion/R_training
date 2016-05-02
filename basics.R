# GGPlot
library(ggplot2)
vignette("ggplot2-specs")
vignette("extending-ggplot2")

install.packages("psych")
library(psych)

# List all objects in the workspace
ls()

# List files in current workspace
dir()

# List objects
rm()
rm(list = ls())


# Datasets
library(datasets)
data()
data(airmiles)

# import file
data.csv <- read.csv("Datasets/cul_apps.csv", header = TRUE)
data.txt <- read.table("Datasets/cul_apps.txt", header = TRUE, sep  = "\t")

# Display first 10 rows
head(data, n = 10)

# Summary of the data
summary(cars$speed)
summary(cars)

# require("psych")
describe(cars)

# Show col, row and classes attributes
attributes(mtcars)

# order data
mtcars[order(mtcars$mpg),]
mtcars[order(-mtcars$mpg),]

# order data based on 2 columns, first using top values of cyl with top values of mpg
mtcars[order(-mtcars$cyl, -mtcars$mpg),]


# class overview of dataset
sapply(df, class)

fivenum(cars$speed) 

# find vector in dataset
match("x", data)

# Cumulative sum, cumulate sum per row order -> cumsum()
set.seed(1L)
DT <- data.table(A = rep(letters[2:1], each = 4L), B = rep(1:4, each = 2L), C = sample(8)) 
cumsum(DT$B)


# boxplot data
boxplot.stats(cars$speed)

# Usage of [[x]] and [y,z]
n <- c(2, 3, 5) 
s <- c("aa", "bb", "cc", "dd", "ee") 
b <- c(TRUE, FALSE, TRUE, FALSE, FALSE) 
x <- list(n, s, b, 3)   

# display class of data - example with today's date
class(Sys.Date())

x # x contains copies of n, s, b
x[2] # vectors in second object of the list
x[[2]][3] # third vector of second object in the list
?"["

# Keep only selected columns, 1,3 and 4
mtcars[,c(1,3,4)]
# drop 3rd and 5th columns
mtcars[,c(-3, -5)]

# Remainder (%%) if zero it can be divided if not it's what remain from the division
41 %% 5

# remove factors
as.numeric(as.character(x))

# Define columns in Global Environment when working exclusively on one dataframe
data(diamonds)
attach(diamonds)
carat

# Google R style Guide
browseURL("https://google.github.io/styleguide/Rguide.xml")

# Libraries list and popularities
browseURL("http://www.crantastic.org")

# Colors chart
browseURL("http://research.stowers-institute.org/efg/R/Color/Chart/")
browseURL("http://colorbrewer2.org")
install.packages("RColorBrewer")



