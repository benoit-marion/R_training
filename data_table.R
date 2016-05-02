install.packages("data.table")
library(data.table)

#############
data.table()
DT[i, j, by]
DT[row selection / WHERE, columns selection / SELECT, group by]


# selecting rows
# .N = number of rows, to display the beflore last row:
DT[.N-1]
DT2[.N-1:0,] # two last ones

DT[ A == "a"] # subset of dataset with col A value = a 
DT[, A == "a"] # return a logical vector value
DT[ A %in% c("a", "c")] # subset of dataset with col A value = a or c
DT[Length * Width > 20 ] # subset combined col

# selecting cols, using .() as a wrapper

DT[, B]   # return a vector
DT[,.(B)] # return a dataframe.
DT[,.(B,C)] # return a dataframe with multiple col.

# recycling - if one function result is smaller length than table, it recycles the data

DT <- data.table(A = 1:5, B = letters[1:5])
DT[,.(A, B, C = sum(A))]  # the sum get replicated for each row


DT <- data.table(iris)
DT[, .(mean = mean(Sepal.Length)), by = .(Species)]


DT[, .(mean = mean(Sepal.Length)), by = .(substr(Species,1 ,1))]

# Group the specimens by Sepal area (to the nearest 10 cm2) and count how many occur in each group.
DT[, .N , .(10* round(Sepal.Length * Sepal.Width / 10))]

# Now name the output columns `Area` and `Count`
DT[, .(Count = .N), .(Area = 10*round(Sepal.Length * Sepal.Width / 10))]

# Chaining

set.seed(1L)
DT <- data.table(A = rep(letters[2:1], each = 4L), B = rep(1:4, each = 2L), C = sample(8)) 

DT[, cumsum(C), by = .(A, B)]

# Cumsum of C while grouping by A and B, and then select last two values of C while grouping by A
DT[, .(C = cumsum(C)), by = .(A, B)][.N-1:0, C, by = A] # wrong, only use 2 last rows
DT[, .(C = cumsum(C)), by = .(A, B)][, .(C = tail(C, 2)), by = A] # COrrect use 2 last for of C for each group of A

DT <- data.table(iris)

# generate median for each dimension + order by decreasing species (factored)
DT[, .(Sepal.Length = median(Sepal.Length), Sepal.Width = median(Sepal.Width), Petal.Length = median(Petal.Length), Petal.Width = median(Petal.Width)), by = Species][order(-Species)]

# .SD allow to automatically use all columns excelt the one in group by
# It refers to the subset of data for each group.
DT[, lapply(.SD, median), by = Species][order(-Species)]


# .SDcols= allow to define a subset of columns
DT[,lapply(.SD, sum), .SDcols=2:4] # col number 2, 3, 4
DT[,lapply(.SD, sum), .SDcols=paste0("H", 1:2)] # -> col H1 and H2

# Select all but the first row of groups 1 and 2, 1:3
# returning only the grp column and the Q columns. 
DT[, .SD[-1] , by = grp, .SDcols = paste0("Q", 1:3)]

# Get the sum of all columns x, y and z and the number of rows in each group while grouping by x
# counting rows has been added as a new col N.SD()
DT[, c(lapply(.SD, sum), N = .N), by = x]

# Cumulative sum of column x and y while grouping by x and z > 8
DT[, .(x = cumsum(x), y = cumsum(y)), by = .(by1 = x, by2 = z > 8)]

# Deleting and updating columns
# :=

# Adding column x and z, and x being the reverse of existing x in DT and z being new column added with 10:6
DT[, c("x", "z") := .(rev(x), 10:6)]
DT[, ':=' (x = rev(x), z = 10:6)] # same as above but different reading

# remove columns
DT[, c("x", "z") := NULL] # multiple cols
DT[, y := NULL] # only y
DT[, (2) := NULL] # delete col num 2
MyCols <- c("x", "z")
DT[, (MyCols) := NULL] # programic list of cols
DT[, paste0("colNamePrefix", 1:4) := NULL]
iris[, grep("Petal", colnames(iris)) := NULL,] # drop columns with Petal

DT[2:4, z := sum(y), by = x] # the sum apply on the group values (x)

DT[, ':=' (B = B +1, C = A + B, D = 2)] # chain of modification

## SET functions
set()         # a loopable low overhead version of :=
setnames()    # to set or change column names
setcolorder() # reorder the columns of a data.table


# set() - Update value of colulmn z by rownumber +1
for (i in 1:5) DT[i, z := i+1]
for (i in 1:5) set(DT, i, 3L := i+1) # 3L = col numb
for (i in 2:4) set(DT, sample(1:10, 3) , i, NA)  # Loop through columns 2,3 and 4, and for each one select 3 rows at random and set the value of that column to NA.

# setnames()
setnames(DT, "y", "z") # update col name y into z
setnames(DT, colnames(DT), tolower(colnames(DT))) # change all names to lower case
setnames(DT, colnames(DT), paste0(colnames(DT), "_2")) # add _2

# setcolorder()
setcolorder(DT, c("y", "x"))
setcolorder(DT, rev(colnames(DT))) # reverse the order

## Indexing

# set column key, reorder + indexing
setkey(DT, A)
# after index
DT["a"] # directly return row where A = "a"
DT["b", mult = "first"] # only return first
DT["b", mult = "last"] # only return last
DT[ c("b", "d")] # even if d doesn't exist
DT[ c("b", "d"), nomatch = 0] # only existing values are returned (default = NA)

# 2 columns key
setkey(DT, A, B)
key(DT) # to find back the keys used in the data table
DT[.("b", 5)] # "b" exist in A and 5 in B

# First and last row of the "b" and "c" groups
DT[c("b","c"), .SD[c(1,.N)], by = .EACHI]

# Copy and extend code for instruction 4: add printout
DT[c("b","c"), {print(.SD);.SD[c(1,.N)]}, by=.EACHI]

## Ordered joins
DT <- data.table(A = letters[c(2, 1, 2, 3, 1, 2, 3)], 
                 B = c(5, 4, 1, 9, 8, 8, 6), 
                 C = 6:12, 
                 key= "A,B")


DT[.("b", 4), roll = TRUE] # return the value before the gap
DT[.("b", 4), roll = "nearest"] # return the nearest value around the gap
DT[.("b", 4), roll = -Inf] # return previous value
DT[.("b", 4), roll = +Inf] # return next value
DT[.("b", 7:8), roll = TRUE] # as 7:8 doesn't exist it use the last known value
DT[.("b", 7:8), roll = TRUE, rollends = FALSE] # rollends false prevent the above
DT[.("b", 7:8), roll = 2] # only roll for a distance of 2

# Look at the sequence (-2):10 for the "b" group
DT[.("b", (-2):10)]

# Add code: carry the prevailing values forwards
DT[.("b", (-2):10), roll = TRUE]

# Add code: carry the first observation backwards
DT[.("b", (-2):10), roll = TRUE, rollends = TRUE]



https://rpubs.com/davoodastaraky/dataTable





