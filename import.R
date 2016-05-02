## List file in current directory
dir()

###########################################################################
## CSV, XLS, XLSX                                                        ##
###########################################################################

# packages
install.packages("readr")
install.packages("data.table") 
install.packages("readxl")
install.packages("gdata")
install.packages("XLConnect")

# libraries
library(readr)
library(data.table)
library(readxl)
library(gdata)
library(XLConnect)

# Import CSV
read.csv()
# Example
data <- read.csv("datafile.csv", stringsAsFactors = FALSE)

# Import txt tab
read.delim()

# generic import
read.table(file, col.names = c("type", "calories", "sodium"), sep = "\t")

# assign names manually
hotdogs <- read.delim("hotdogs.txt", header = FALSE)
names(hotdogs) <- c("type", "calories", "sodium")

# defining a colClass as NULL drop the column
hotdogs2 <- read.delim("hotdogs.txt", header = FALSE, 
                       col.names = c("type", "calories", "sodium"),
                       colClasses = c("factor","NULL","numeric"))

## Library readr
#   col_types classes:
#   c to a character
#   d to a double
#   i to an integer
#   l to a logical
#   _ skips the column

## ReadR: Limit amount of rows to be read using n_max, or rows to be skipped with skip
read_tsv("potatoes.txt", skip = 0, n_max = 5)

## Data Table:
fread("potatoes.txt", skip = 0, nrows = 20)

## Examples, Suppose you have a dataset that contains 5 variables and you want to keep the first and fifth variable, named "a" and "e"
fread("path/to/file.txt", drop = 2:4)
fread("path/to/file.txt", select = c(1, 5))
fread("path/to/file.txt", drop = c("b", "c", "d")
fread("path/to/file.txt", select = c("a", "e"))


## readxl package
excel_sheets() # read sheet names
read_excel() # Does not support URL as path, need to download first using download.file("URL", "filename")

## Read all sheets and make a list with lapply
lapply(excel_sheets("data.xlsx"), read_excel, path = "data.xlsx")

## Gdata - no header: header = FALSE
read.xls()

## Load multiple files
latinFile <- file.path(path.package('gdata'),'xls','latin-1.xls')
latin1 <- read.xls(latinFile, fileEncoding="latin1")
colnames(latin1)

# Change names of columns from dataset
columns <- c("country",  paste0("year_", 1967:1974))
names(urban_pop) <- columns

# Sorting data on one columns to get top numbers first
urban_pop_sorted <- urban_pop[order(urban_pop$year_1974, decreasing = TRUE),]

# Merge tables columns with same row definition (using -1 to remove first col)
urban_all <- cbind(urban_sheet1, urban_sheet2[,-1], urban_sheet3[,-1])

# Remove all rows containing NAs: urban_all_clean
urban_all_clean <- na.omit(urban_all)

## XLConnect
# Create book connection with xls
book <- loadWorkbook("cities.xlsx")
# list sheets
getSheets(book)
# read table
readWorksheet(book, sheet = "year_2000")
# advanced reading
readWorksheet(book, sheet = "year_2000",
              startRow = 3, endRow = 4,
              startCol = 2, header = FALSE)
# create sheet
createSheet(book, name = "year_2010")
# write in sheet
writeWorksheet(book, data_to_add, sheet = "year_2010")
# Save as file
saveWorkbook(book, "cities_extended.xlsx")

###########################################################################
## JSON                                                                  ##
###########################################################################
# Installl packages
install.packages("jsonlite")
# Load libraries
library(jsonlite)

# Example
fromJSON("http://www.omdbapi.com/?i=tt0095953&r=json")

# Other functions
toJSON()
prettify()
minify()

## Understing JSON format ' is used to avoid escape with "
# Simple array -> vector
json1 <- '[1, 2, 3, 4, 5, 6]'
fromJSON(json1)

# List of with a and b with 1 array
json2 <- '{"a": [1, 2, 3], "b": [4, 5, 6]}'
fromJSON(json2)

# matrix of 2x2
json3 <- '[[1, 2], [3, 4]]'
fromJSON(json3)

# Data frame of col a and b with 3 rows
json4 <- '[{"a": 1, "b": 2}, {"a": 3, "b": 4}, {"a": 5, "b": 6}]'
fromJSON(json4)

## minify and prettify for readable or compact version of JSON

# Convert mtcars to a pretty JSON: pretty_json
pretty_json <- toJSON(mtcars, pretty = TRUE)

# Print pretty_json
pretty_json

# Minify pretty_json: mini_json
mini_json <- minify(pretty_json)

# Print mini_json
mini_json



###########################################################################
## RData                                                                 ##
###########################################################################
# Example
url_rdata <- "https://s3.amazonaws.com/assets.datacamp.com/course/importing_data_into_r/wine.RData"
download.file(url_rdata, "wine_local.RData")
load("wine_local.RData")
summary(wine)

# for one time usage (not saved locally)
load(url("https://s3.amazonaws.com/assets.datacamp.com/course/importing_data_into_r/wine.RData"))
summary(wine)


###########################################################################
## SQL                                                                   ##
###########################################################################

# Installl packages
install.packages("RMySQL") 
# Load libraries
library(DBI)
library(RMySQL)
# example
con <- dbConnect(RMySQL::MySQL(),
                 dbname = "company",
                 host = "courses.csrrinzqubik.us-east-1.rds.amazonaws.com",
                 port = 3306,
                 user = "student",
                 password = "datacamp")
dbListTables(con)
#   [1] "employees" "products" "sales"
dbReadTable(con, "employees")
#     id name started_at
#   1 1 Tom 2009-05-17
#   2 4 Frank 2012-07-06
#   3 6 Julie 2013-01-01
#   4 7 Heather 2014-11-23
#   5 9 John 2015-05-12
dbDisconnect(con)

# SQL query -- note the \ for escaping the " character required for string
dbGetQuery(con, "SELECT name FROM employees
 WHERE started_at > \"2012-09-01\"")
#       name
#   1 Julie
#   2 Heather
#   3 John

## Query can be break in small steps, in case of larget data that need to be handle by chunks using n argument inside dbFetch()
# Sending the specified query with dbSendQuery();
# Fetching the result of executing the query on the database with dbFetch();
# Clearing the result with dbClearResult().
res <- dbSendQuery(con, "SELECT * FROM products
 WHERE contract = 1")
dbFetch(res, n = 2)     # calling again dbFetch(res) give the remaining rows results
#   id name contract
#   1 2 Call Plus 1
#   2 9 Biz Unlimited 1
dbClearResult(res)

# Getting information about the results of the query
dbGetInfo(res)


###########################################################################
## Web                                                                   ##
###########################################################################

### Note: fromJSON(), read.csv(), read.xls() already support URL

# Installl packages
install.packages("httr")
# Load libraries
library(httr)

# Downlad file using URL
download.file()

# Get the url, save response to resp
url <- "http://docs.datacamp.com/teach/"
resp <- GET(url)

# Print resp
print(resp)

# Get the raw content of resp
raw_content <- content(resp, as = "raw")

# Print the head of content
head(raw_content)

# Working example
url <- "https://www.omdbapi.com/?t=Annie+Hall&y=&plot=short&r=json"
resp <- GET(url)
content(resp)

###########################################################################
## SAS, STATA, SPSS import                                               ##
###########################################################################

# Installl packages
install.packages("haven")
install.packages("foreign")
# Load libraries
library(haven)
library(foreign)

################# Haven ###############
# Read sas
ontime <- read_sas("ontime.sas7bdat")
ontime$Airline <- factor(ontime$Airline)
# Read strata
ontime <- read_stata("ontime.dta")
ontime <- read_dta("ontime.dta")
_sav(sugar <- read_dta("http://assets.datacamp.com/course/importing_data_into_r/trade.dta")
# Transform labelled data to factor
as_factor(ontime$Airline) # or
as.character(as_factor(ontime$Airline))
# SPSS
read_sav(file.path("~","datasets","ontime.sav"))

################ Foreign###############
## STATA
# convert.factors TRUE by default
ontime <- read.dta("ontime.dta")
ontime <- read.dta("ontime.dta", convert.factors = FALSE)

read.dta(file,
         convert.factors = TRUE,
         convert.dates = TRUE,
         missing.type = FALSE)

# convert.factors: convert labelled STATA values to R factors
# convert.dates: convert STATA dates and times to Date and POSIXct
# missing.type: if FALSE, convert all types of missing values to NA
#               if TRUE, store how values are missing in attributes

## SPSS
read.spss(file,
          use.value.labels = TRUE,
          to.data.frame = FALSE)
# use.value.labels: convert labelled SPSS values to R factors
# to.data.frame: return data frame instead of a list
# trim.factor.names
# trim_values
# use.missings
                       