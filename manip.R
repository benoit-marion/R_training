# proportionate data (-> percentage)
round(prop.table(data), 2) * 100

# extract from array
?margin.table()

# array to table
data <- as.data.frame.table(dataset)

# drop a column (using negative number of the column to drop)
data <- data[, -4]
data[,4] <- NULL

# Add a column based on calculation of other columns
mtcars2 <- cbind(mtcars, ratio = (mtcars$hp / mtcars$wt * 100))

# Apply means/medians on combination of columns based on col (2) or rows (1)
apply(mtcars[,3:4], 1, mean) # gives average of disp + hp per rows (160 + 110 -> 135)
apply(mtcars[,3:4], 2, mean) # gives average for disp and hp cols (230.7219, 146.6875)

# Get frequency on 2 columns
DF <- table(adult$RBMI, adult$SRAGE_P)

# Use apply on DF to get frequency of each group
apply(DF, 2, function(x) x/sum(x)) 

# while loop - increase crt 1 if less than 7 + break if divisible by 5 + print value
ctr <- 1
while(ctr <= 7) {
  if(ctr %% 5 == 0) { break
  }
  print(paste("ctr is set to", ctr))
  ctr <- ctr + 1
}

# if else
num_views <- 14
if (num_views > 15) {
  print("You're popular!")
} else {
  print("Try to be more visible!")
}

# while loop with If Else
speed <- 64
while (speed > 30) {
  print(paste("Your speed is ", speed))
  if(speed > 80) { break
  }
  if (speed > 48) {
    print("Slow down big time!")
    speed <- speed - 11
  } else {
    print("Slow down!")
    speed <- speed - 6 }
}

# For loop
# generate a loop from a list of things (can be vectors in dataframe)

cities <- c("New York", "Paris", "London", "Tokyo", "Rio de Janeiro", "Cape Town")
cities

# Can include If and breaks (here if #characters = 6 it skip it)

for(city in cities) 
{
  if(nchar(city) == 6) 
    { next }
  print(city)
}

# For loop with i as the index of the loop

for(i in 1:length(cities)) 
{ 
  if(nchar(cities[i]) == 6) 
  { next } 
  print(paste((cities[i]), "position", i)) 
}


# The tic-tac-toe matrix has already been defined for you
ttt <- matrix(c("O", NA, "X", NA, "O", NA, "X", "O", "X"), nrow = 3, ncol = 3)

# define the double for loop
for (i in 1:nrow(ttt)) {
  for (j in 1:ncol(ttt)) {
    print(paste("On row", i, "and column", j, "the board contains", ttt[i,j]))
  }
}


# The linkedin vector has already been defined for you
linkedin <- c(16, 9, 13, 5, 2, 17, 14)

# Extend the for loop
for (li in linkedin) 
{ print(li)
  if (li > 10) { print("You're popular!") } else { print("Be more visible!") }
  # Add code to conditionally break iteration
  if (li > 16)  { print("This is ridiculous, I'm outta here!")
  { break } }
  # Add code to conditionally skip iteration
  if (li < 5) { 
    print("This is too embarrassing!") 
  { next } }
  
}

# Count R characters before "u"

rquote <- "R's internals are irrefutably intriguing"
chars <- strsplit(rquote, split = "")[[1]]
u <- match("u", chars)
rcount <- 0
for(i in 1:length(tolower(chars))) {
  if(chars[i] == "r") {
    rcount <- rcount + 1 
  } else { 
  next 
  }
}
rcount

# If in a function
pow_two <- function(x, print_info = TRUE) {
  y <- x ^ 2
  if(print_info == TRUE) { print(paste(x, "to the power two equals", y)) }
  return(y)
}
pow_two(3, TRUE)

###### Subset of data

# subetting only 1 col - to keep dataframe format use drop = FALSE
mtcarsh_df <- mtcars[1:4, 3, drop = FALSE]
mtcarsh_vec <- mtcars[1:4, 3, drop = TRUE]

# keeping specific data
cars_to_keep <- rownames(mtcars[1:3,])
mtcars[cars_to_keep,]

# keeping cars with hp > 220
mtcars[mtcars[,4] > 220,]


# subset in a dataframe with two conditions on variables
HEC7 <- subset(HEC, subset=(Hair == "Black" & Eye == "Brown"))
HEC7 <- subset(HEC, subset=(Hair == "Black" | Eye == "Brown"))

# select from minimum value (which)
hotdogs[which.min(hotdogs$sodium),]

######### Data frame type
######### Long vs Wide

#### Long ####
##   Subject Gender   Test Result
## 1       1      M   Read     10
## 2       2      F  Write      4
## 3       1      M  Write      8
## 4       2      F Listen      6
## 5       2      F   Read      7
## 6       1      M Listen      7

#### Wide ####
##   Subject Gender Read Write Listen
## 1       1      M   10     8      7
## 2       2      F    7     4      6

# From Wide to long
wide_col <- colnames(iris[,1:4])
iris_long <- reshape(iris,
                        varying = wide_col,
                        v.names = "Measure",
                        timevar = "Measure_type",
                        times = wide_col,
                        direction = "long",
                        new.row.names = 1:1000)
head(iris_long)

# From long to wide
# Note that the combination of the uniqueness of idvar will define the rows definition

chickwts_long <- cbind(chickwts, id = 1:nrow(chickwts))
chickwts_wide <- reshape(chickwts_long,
                        timevar = "feed",
                        idvar = "id",
                        direction = "wide")
head(chickwts_wide)

#### Reshape2 #### 
install.packages("reshape2")
library(reshape2)

#Wide to long
observations_wide
##   Subject Gender Read Write Listen
## 1       1      M   10     8      7
## 2       2      F    7     4      6

long_reshaped2 <- melt(observations_wide,
                       id.vars=c("Subject", "Gender"),
                       measure.vars=c("Read", "Write", "Listen"),
                       variable.name="Test",
                       value.name="Result")
long_reshaped2
##   Subject Gender   Test Result
## 1       1      M   Read     10
## 2       2      F   Read      7
## 3       1      M  Write      8
## 4       2      F  Write      4
## 5       1      M Listen      7
## 6       2      F Listen      6

## long to wide, data to keep are first indicated (combining with +), data to split indicated with ~
observations_long
##   Subject Gender   Test Result
## 1       1      M   Read     10
## 2       2      F  Write      4
## 3       1      M  Write      8
## 4       2      F Listen      6
## 5       2      F   Read      7
## 6       1      M Listen      7

long_reshaped2 <- dcast(observations_long,
                        Subject + Gender ~ Test,
                        value.var="Result")
long_reshaped2
##   Subject Gender Listen Read Write
## 1       1      M      7   10     8
## 2       2      F      6    7     4



head(DF)
#   Under-weight Healthy-weight Over-weight Obese xmax xmin  X
# 18           30            254          80    52  416    0 18
# 19           22            248          76    45  807  416 19
# 20           14            191          68    43 1123  807 20
# 21           15            168          70    45 1421 1123 21
# 22           13            145          56    44 1679 1421 22
# 23           15            142          59    58 1953 1679 23

DF_melted <- melt(DF, id = c("X", "xmin", "xmax"), variable_name = "FILL")
head(DF_melted) 

#   X xmin xmax         FILL value
# 1 18    0  416 Under-weight    30
# 2 19  416  807 Under-weight    22
# 3 20  807 1123 Under-weight    14
# 4 21 1123 1421 Under-weight    15
# 5 22 1421 1679 Under-weight    13
# 6 23 1679 1953 Under-weight    15


