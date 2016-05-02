# Create Triple function
triple <- function(x) 
{ y <- 3 * x
  return(y) }
triple(6)

# Create Triple function, with default function and condition with 0
math_magic <- function(a, b = 1) 
{ if(b == 0) { return(0) }
  a*b + a/b }
math_magic(4,0)


# Function to return NULL if negative
my_filter <- function(x) 
{ 
  if(x >= 0) { return(x) } else { return(NULL) }
}

# If in a function
pow_two <- function(x, print_info = TRUE) {
  y <- x ^ 2
  if(print_info == TRUE) { print(paste(x, "to the power two equals", y)) }
  return(y)
}
pow_two(3, TRUE)

# Interpret function
interpret <- function(num_views) {
  if (num_views > 15) {
    print("You're popular!")
    return(num_views)
  } else {
    print("Try to be more visible!")
    return(0)
  }
}

# The linkedin and facebook vectors have already been created for you
linkedin <- c(16, 9, 13, 5, 2, 17, 14)
facebook <- c(17, 7, 5, 16, 8, 13, 14)

# The interpret() can be used inside interpret_all()
interpret <- function(num_views) {
  if (num_views > 15) {
    print("You're popular!")
    return(num_views)
  } else {
    print("Try to be more visible!")
    return(0)
  }
}

# Define the interpret_all() function and sum only popular days
interpret_all <- function(views, vsum = TRUE) {
  count <-0
  for(i in 1:length(views)) {
    count <- count + interpret(views[i])
    if(vsum) {
      print(count)
    } else {
      print(NULL)
    }
  }
}

# Call the interpret_all() function on both linkedin and facebook
interpret_all(linkedin)
interpret_all(facebook)

# apply functions
## lapply for applying function over list or vector, output = list
## sapply try to simplify list to array
## vapply similar to sapply but define the output



# lapply basic
nyc <- list(pop = 56789,
            cities = c("New York", "Chicago", "Los Angeles", "Miami"),
            capital = FALSE)

lapply(nyc, class)

# lapply with strsplit
pioneers <- c("GAUSS:1777", "BAYES:1702", "PASCAL:1623", "PEARSON:1857")

split_math <- lapply(pioneers, strsplit, ":")
split_math <- strsplit(pioneers, ":")
tolower(lapply(split_math))

# generate list with sample and repeat 5 times
temp <- list(sample(-10:20))[rep(1,5)]
data.table(A=rep(letters[2:1], each=4L), B=rep(1:4, each=2L), C=sample(8))

# rep can use the amount of time to be repeated (time = 2) or if each vector should be repeated (each = 2)        
        
# sapply allow to generate vectors (when possible) instead of list - simplified lapply
# subet data using logical operation
below_zero <- function(x) { subset(x, x < 0) }
freezing_s <- sapply(temp, below_zero)
freezing_l <- lapply(temp, below_zero)
identical(freezing_s, freezing_l)

# Concatenate
print_info <- function(x) { cat("The average temperature is", mean(x), "\n") }
sapply(unlist(temp[[1]]), print_info)

# vapply and naming vectors
basics <- function(x) { c(min(x), mean(x), max(x)) }
vapply(temp, basics, c("min" = 0, "mean" = 0, "max" = 0))

# alternative, naming vectors in the function
basics <- function(x) { c(min = min(x), mean = mean(x), max = max(x)) }
vapply(temp, basics, numeric(3)) # character(3) or logical(3) for other value type


# Rank - takes a group of values and calculates the rank of each value within the group, e.g.
rank(c(21, 22, 24, 23))
# has output [1] 1 2 4 3
