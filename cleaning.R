install.packages("dplyr")
install.packages("tidyr")
install.packages("stringr")
install.packages("lubridate")
install.packages("stringr")
install.packages("reshape2")
library(dplyr)
library(tidyr)
library(stringr)
library(lubridate)
library(stringr)
library(reshape2)


dim(mtcars)
# rows + cols
names(mtcars)
# names of cols

# packages
install.packages("dplyr")
# libraries
library(dplyr)

glimpse(mtcars)
summary(mtcars)

head(mtcars, 10) # ten rows

print(mtcars) # show complete dataset

# Load the tidyr package
install.packages("tidyr")
library(tidyr)

# wide to long
# gather(data, key, value, ...)
# key = bare name of new key column, value = bare name of new value column, ... = bare names of col to gather ot not (using -)

wide_df
# col A B C
# 1 X 1 2 3
# 2 Y 4 5 6

gather(wide_df, my_key, my_val, -col) # you can use X1:X31 to select all col from X1 to X31
#  col my_key my_val
# 1 X A 1
# 2 Y A 4
# 3 X B 2
# 4 Y B 5
# 5 X C 3
# 6 Y C 6

# long to wide
# spread(data, key, value)
# key = bare name of column continaing keys, value = bare name of column containing values

long_df
#  col my_key my_val
# 1 X A 1
# 2 Y A 4
# 3 X B 2
# 4 Y B 5
# 5 X C 3
# 6 Y C 6

spread(long_df, my_key, my_val)
#  col A B C
# 1 X 1 2 3
# 2 Y 4 5 6


# separate(data, col, into)
# can use <sep = ""> to specify separator
# col = bare name of column to seperate
# into = character vector of new column names

year_mo = 2010-10
separate(data, year_mo, c("year", "month")) # automatically use "-" as sep

# unite(data, col, ... )
# can use <sep = ""> to specify separator
# col : bare name of new col
# ... bare names of columns to unite

unite(data, sep = "-", year_mo, year, month) # default sep is "_"


install.packages("lubridate")
library(lubridate)

ymd("2015-08-05")
ymd("2015 August 05")
mdy()
hms()``
ymd_hms()


install.packages("stringr")
library(stringr)

str_trim("     this is a test             ")
# [1] "this is a test"
str_pad("24499", width = 7, side = "left", pad = "0")
# [1] "0024499
str_detect()
str_replace(data, "string1", "string2")


#### missing values

any(is.na(data)) # -> detect if any NAs
sum(is.na(data)) # -> sum of NAs
summary(data) # -> display per column

complete.cases(data) # -> detect missing values
data[complete.cases(data),] # keep only complete values
na.omit(data) # remove all missing values
which(is.na(data)) # give row location if missing values

#find and replace
nas <- which(is.na(data$col))
data[nas,] <- 0

#find data with index of row
i <- which(data$col == 10)
data[i,] <- 0

#replace missing values with NA, None
str_replace(data$col, "^$", NA)
data$col[data$col == ""] <- "None"


### melt data, columns to variable
install.packages("reshape2")
library(reshape2)

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
