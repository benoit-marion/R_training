# install ggvis
install.packages("ggvis")

# ggvis is already installed for you; now load it and start playing around
library(ggvis)

# load dataset
data("mtcars")

# change the code below to plot the disp variable of mtcars on the x axis
mtcars %>% ggvis(~disp, ~mpg) %>% layer_points()

# Change the code below to make a graph with red points
mtcars %>% ggvis(~wt, ~mpg, fill := "red") %>% layer_points()

# Change the code below draw smooths instead of points
mtcars %>% ggvis(~wt, ~mpg) %>% layer_smooths()

# Change the code below to make a graph containing both points and a smoothed summary line
mtcars %>% ggvis(~wt, ~mpg) %>% layer_points() %>% layer_smooths()

