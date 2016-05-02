# Load the tidyr package
install.packages("tidyr")
library(tidyr)

# From 150 obs and one categorical columns to 600 objs with 3 categorical columns
iris.tidy <- iris %>%
  gather(key, Value, -Species) %>% # Species is already a categorical col
  separate(key, c("Part", "Measure"), "\\.") # Sepal.Length, Sepal.Width, Petal.Length, Petal.Width

# Sepal.Length Sepal.Width Petal.Length Petal.Width Species Flower
# 1          5.1         3.5          1.4         0.2  setosa      1
# 2          4.9         3.0          1.4         0.2  setosa      2
# 3          4.7         3.2          1.3         0.2  setosa      3
# 4          4.6         3.1          1.5         0.2  setosa      4
# 5          5.0         3.6          1.4         0.2  setosa      5
# 6          5.4         3.9          1.7         0.4  setosa      6


# gather will generate flatten version of the dataset with specifying data to keep untouched 
# (species and flower) and keep the row value in first column "value" and the column name in "key"
# Flower column was created as an observation index in order to reconstruct afterward

iris <- cbind(iris, "Flower" = as.integer(row.names(iris)))
gather(iris, key, value, -Species, -Flower)
 
# Species Flower          key value
# 1  setosa      1 Sepal.Length   5.1
# 2  setosa      2 Sepal.Length   4.9
# 3  setosa      3 Sepal.Length   4.7
# 4  setosa      4 Sepal.Length   4.6
# 5  setosa      5 Sepal.Length   5.0
# 6  setosa      6 Sepal.Length   5.4


# after spliting the columns (separate) based on ".", use the Measure (length & width) as column to store the values
spread(iris, Measure, value)

# order data with 2 columns
mtcars[order(mtcars$mpg),]

