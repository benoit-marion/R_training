# packages
install.packages("dplyr")
# libraries
library(dplyr)

### example data
install.packages("hflights")
library(hflights)

## Create tbl dataframe
hflights <- tbl_df(hflights)
## to reverse -> as.data.frame(hflights)

hflights[,11:21]

glimpse(hflights)
str(hflights)

####################
## Data cleaning

## Look up table
# Lookup table example, entries is original data, lut is the look out table
entries <- c("AA", "AS", "AA", "AA", "B6", "AS", "AS")
lut <- c("AA" = "American", 
         "AS" = "Alaska", 
         "B6" = "JetBlue")
entries <- lut[entries]

# More complete example
lut <- c("AA" = "American", "AS" = "Alaska", "B6" = "JetBlue", "CO" = "Continental", 
         "DL" = "Delta", "OO" = "SkyWest", "UA" = "United", "US" = "US_Airways", 
         "WN" = "Southwest", "EV" = "Atlantic_Southeast", "F9" = "Frontier", 
         "FL" = "AirTran", "MQ" = "American_Eagle", "XE" = "ExpressJet", "YV" = "Mesa")

# Use lut to translate the each rows of UniqueCarrier column of hflights
hflights$UniqueCarrier <- lut[hflights$UniqueCarrier] 

# Finding unique values of a column
unique(hflights$CancellationCode)

#####################
## Dyplr Verbs

select(), which returns a subset of the columns,
mutate(), used to add columns from existing data,
arrange(),  that reorders the rows according to single or multiple variables,
filter(), that is able to return a subset of the rows,
summarise(),  which reduces each group to a single row by calculating aggregate measures.

# Select
select(df, var1, var2) # ou can also use : to select a range of variables and - to exclude some variables
select(df, 1:4, -2) # select 1, 3, 4
select(hflights, -(Year:Month), -(DepTime:Diverted)) # only keep 2 cols

# Select helper functions

starts_with("X"): every name that starts with "X",
ends_with("X"): every name that ends with "X",
contains("X"): every name that contains "X",
matches("X"): every name that matches "X", where "X" can be a regular expression,
num_range("x", 1:5): the variables named x01, x02, x03, x04 and x05,
one_of(x): every name that appears in x, which should be a character vector.

# Mutate
mutate(df, z = x + y)

mutate(c1, Date = paste(Year, Month, DayofMonth, sep = "-"))

mutate_each(weather5, funs(as.numeric), CloudCover:WindDirDegrees)
# apply as.numeric() to all columns from CloudCover through WindDirDegrees (reading left to right in the data), saving the result to

# Filter - similar to WHERE clause

filter(df, a > b)

x < y, TRUE if x is less than y
x <= y, TRUE if x is less than or equal to y
x == y, TRUE if x equals y
x != y, TRUE if x does not equal y
x >= y, TRUE if x is greater than or equal to y
x > y, TRUE if x is greater than y
x %in% c(a, b, c), TRUE if x is in the vector c(a, b, c)
is.na(x)
!is.na(x)

& (and), | (or), and ! (not)

filter(df, !is.na(x))

# & or , give same result
filter(df, a > b & c > d)
filter(df, a > b, c > d)


# Arrange
arrange(df, a, b, c)
arrange(df, a, desc(b), c)
arrange(df, (a + b))

# Combination
arrange(filter(hflights, Dest == "DFW" & DepTime < 2000), desc(AirTime))

# Summarise
summarise(df, min_x = min(x), max_y = max(y))

min(x) - minimum value of vector x.
max(x) - maximum value of vector x.
mean(x) - mean value of vector x.
median(x) - median value of vector x.
quantile(x, p) - pth quantile of vector x.
sd(x) - standard deviation of vector x.
var(x) - variance of vector x.
IQR(x) - Inter Quartile Range (IQR) of vector x.
diff(range(x)) - total range of vector x.

first(x) - The first element of vector x.
last(x) - The last element of vector x.
nth(x, n) - The number n element of vector x.
n() - The number of rows in the data.frame or group of observations that summarise() describes.
n_distinct(x) - The number of unique values in vector x.

# Pipe
mean(c(1, 2, 3, NA), na.rm = TRUE)
c(1, 2, 3, NA) %>% mean(na.rm = TRUE)

hflights %>% 
  mutate(diff = TaxiOut - TaxiIn) %>% 
  filter(!is.na(diff)) %>% 
  summarise(avg = mean(diff))

# Exercise on finding what plane are slower than car ride (based on 70 mph)

hflights %>%
  select(Dest, UniqueCarrier, Distance, ActualElapsedTime) %>%
  mutate(RealTime = ActualElapsedTime + 100, mph = Distance / RealTime * 60) %>%
  filter(!is.na(mph), mph < 70)  %>%
  summarise(
    n_less = n(),
    n_dest = n_distinct(Dest),
    min_dist = min(Distance),
    max_dist = max(Distance)
  )

# Group_by

hflights %>%
  group_by(UniqueCarrier) %>%
  summarise(
    n_flights = n(),
    n_canc = sum(Cancelled == 1),
    p_canc = n_canc / n() * 100,
    avg_delay = mean(ArrDelay, na.rm = TRUE)) %>%
  arrange(avg_delay, p_canc)


hflights %>%
  filter(!is.na(ArrDelay)) %>%
  group_by(UniqueCarrier) %>%
  summarise(p_delay = mean(ArrDelay > 0)) %>%
  mutate(rank = rank(p_delay)) %>%
  arrange(rank)

# Which plane (by tail number) flew out of Houston the most times? How many times? adv1
adv1 <- hflights %>%
  group_by(TailNum) %>%
  summarise(n = n()) %>%
  arrange(desc(n)) %>%
  filter(row_number() == 1)

# How many airplanes only flew to one destination from Houston? adv2
adv2 <- hflights %>%
  group_by(TailNum) %>%
  summarise(ndest = n_distinct(Dest)) %>%
  filter(ndest == 1) %>%
  summarise(nplanes = n()) 

# Find the most visited destination for each carrier: adv3
adv3 <- hflights %>%
  group_by(UniqueCarrier, Dest) %>%
  summarise(n = n()) %>%
  mutate(rank = rank(-n))  %>%
  filter(rank == 1)

# Find the carrier that travels to each destination the most: adv4
adv4 <- hflights %>%
  group_by(Dest, UniqueCarrier) %>%
  summarise(n = n()) %>%
  mutate(rank = rank(-n))  %>%
  filter(rank == 1)



# Find the most visited destination for each carrier
hflights %>%
  group_by(UniqueCarrier, Dest) %>%
  summarise(n = n()) %>%
  mutate(rank = rank(-n))  %>%
  arrange(rank)

# Find the carrier that travels to each destination the most
hflights %>%
  group_by(Dest, UniqueCarrier) %>%
  summarise(n = n()) %>%
  mutate(rank = rank(-n))  %>%
  arrange(rank)

## dplyr and SQL

my_db <- src_mysql(dbname = "dplyr", 
                   host = "dplyr.csrrinzqubik.us-east-1.rds.amazonaws.com", 
                   port = 3306, 
                   user = "dplyr",
                   password = "dplyr")
nycflights <- tbl(my_db, "dplyr")

glimpse(nycflights)

summarise(nycflights, 
          n_carriers = n_distinct(carrier), 
          n_flights = n())

nycflights %>%
  group_by(carrier) %>%
  summarise(
    n_flights = n(),
    avg_delay = mean(arr_delay)
  ) %>%
  arrange(avg_delay)


