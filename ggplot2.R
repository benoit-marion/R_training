# Install packages
install.packages("ggplot2")
install.packages("RColorBrewer")
install.packages("GGally")

# Load the ggplot2 package
library(ggplot2)
library(RColorBrewer)
display.brewer.all()

# geoms
geom_abline()
geom_area()
geom_bar()
geom_boxplot()
geom_errorbar()
geom_errorbarh()
geom_histogram()
geom_hline()
geom_jitter()
geom_linerange()
geom_point()
geom_pointrange()
geom_polygon()
geom_rect()
geom_ribbon() # surface chart with transparency
geom_rug()
geom_segment()
geom_step()
geom_text()
geom_vline()


# Explore the mtcars data frame with str()
str(mtcars)

# Execute the following command -- factor() is used to not use cyl continous but categorical data
ggplot(mtcars, aes(x = factor(cyl), y = mpg)) +
  geom_point()

# Other example of factor impact, in order to apply colors
# Factoring cyl make it 1,2,3 instead of 4, 6, 8 (cyl value)
mtcars$cyl <- as.factor(mtcars$cyl)
plot(mtcars$wt, mtcars$mpg, col = mtcars$cyl)

# Plot with size for a dimension
ggplot(mtcars, aes(x = wt, y = mpg, size = disp)) +
  geom_point()


# Plot for all observations with smooth line per category -- shading error can be removed se = FALSE
ggplot(diamonds, aes(x = carat, y = price, col = clarity)) +
  geom_point() +
  geom_smooth()


# aes can be used directly in he geom_point
ggplot(diamonds, aes(x = carat, y = price)) +
  geom_point(aes(col = clarity))


## Basic plot --- For linear model, lm() + subset with lapply()
## Include addition of line, abline() + addition of legend, legend()

mtcars$cyl <- as.factor(mtcars$cyl)
plot(mtcars$wt, mtcars$mpg, col = mtcars$cyl)
carModel <- lm(mpg ~ wt, data = mtcars)
abline(carModel, lty = 2)
lapply(mtcars$cyl, function(x) {
  abline(lm(mpg ~ wt, data = mtcars, subset = (cyl == x)), col = x)
})
legend(x = 5, y = 33, legend = levels(mtcars$cyl), 
       col = 1:3, pch = 1, bty = "n")


## Using ggplot + including addition smooth line for the group
ggplot(mtcars, aes(x = wt, y = mpg, col = cyl)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  geom_smooth(aes(group = 1), method = "lm", se = FALSE, linetype = 2)


## Using facets, based on species col
ggplot(iris.wide, aes(x = Length, y = Width, col = Part)) +
  geom_jitter() +
  facet_grid(. ~ Species)
as.character()

## Dot plot with colors, shape and size
ggplot(mtcars, aes(wt, mpg, col = cyl)) +
  geom_point(shape = 1, size = 4)
  
## "fill" is normall not used with dots, except if the shape has borders
ggplot(mtcars, aes(x = wt, y = mpg, fill = cyl)) +
    geom_point(shape = 21, size = 6)

## more examples with mtcars
ggplot(mtcars, aes(mpg, qsec, col = factor(cyl), shape = factor(am), size = hp/wt)) +
  geom_point()

ggplot(mtcars, aes(mpg, qsec, col = factor(cyl), shape = factor(am), size = hp/wt)) +
  geom_text(aes(label = rownames(mtcars)))

## Geom bar
ggplot(mtcars, aes(x = factor(cyl), fill = factor(am))) +
  geom_bar()

## Stack using fill position
ggplot(mtcars, aes(x = factor(cyl), fill = factor(am))) +
  geom_bar(position = "fill")

## To have colors bar not stacked but on same line use dodge position
ggplot(mtcars, aes(x = factor(cyl), fill = factor(am))) +
  geom_bar(position = "dodge")

## Example with axis names and legend title (name), colors attributes (labels) and color definition (values)
val = c("#E41A1C", "#377EB8")
lab = c("Manual", "Automatic")
cyl.am +
  geom_bar(position = "dodge") +
  scale_x_discrete("Cylinders") +
  scale_y_continuous("Number") +
  scale_fill_manual(name = "Transmission", values = val, labels = lab)

## One dimension data - but with jitter and limits on y axis
ggplot(mtcars, aes(x = mpg, y = 0)) + 
  geom_jitter() +
  scale_y_continuous(limits = c(-2,2))

## Jitter can also be used inside a geom_point as a position
ggplot(diamonds, aes(clarity, price, col = price)) +
  geom_point(alpha = 0.5, position = "jitter")

## Define jitter width using an attribute
ggplot(mtcars, aes(cyl, wt)) +
  geom_jitter(width = 0.1)

## Example with transparency on dots
ggplot(mtcars, aes(wt, mpg, col = cyl)) +
  geom_point(size = 4, alpha = 0.6)

## Histogram, density and binwidth
ggplot(mtcars, aes(mpg)) + 
  geom_histogram(aes(y = ..density..), binwidth = 1)

## Example of position dodge as an object and alpha in a bar plot
posn_d <- position_dodge(0.2)
ggplot(mtcars, aes(cyl, fill = am)) +
  geom_bar(position = posn_d, alpha = 0.6)


## Generate an histogram with 2 dimensions stacked filled, it allow to know the percentage of change of distrubtion according to first dimension mapped
## Use of brew palette
# Definition of a set of blue colors in HEX
blues <- brewer.pal(9, "Blues")

# Make a color range using colorRampPalette() and the set of blues
blue_range <- colorRampPalette(blues)

# Use blue_range to adjust the color of the bars, use scale_fill_manual()
ggplot(diamonds, aes(x = cut, fill = clarity)) +
  geom_bar(position = "fill") +
  scale_fill_manual(values = blue_range(11))

## Example of area plot
ggplot(diamonds, aes(x = cut, y = price, fill = clarity)) +
  geom_area()
## Area with transparency
ggplot(fish, aes(x = Year, y = Capture, fill = Species)) +
  geom_ribbon(aes(ymax = Capture, ymin = 0), alpha = 0.3)

## Get ratio of data with population included in the row defintion
ggplot(economics, aes(x = date, y = unemploy/pop)) +
  geom_line()

## second plot on a line bar with period overlay (recession)
ggplot(economics, aes(x = date, y = unemploy/pop)) +
  geom_line() +
  geom_rect(data = recess, inherit.aes = FALSE, aes(xmin = begin, xmax = end, ymin = -Inf, ymax = +Inf), fill = "red", alpha = 0.2)


## Geom line, with smooth example and groups + colors

ggplot(ChickWeight, aes(Time, weight, col = Diet)) +
  geom_line(aes(group = Chick))

ggplot(ChickWeight, aes(Time, weight, col = Diet)) +
  geom_line(aes(group = Chick), alpha = 0.3) +
  geom_smooth(lwd = 1, se = FALSE)

## Bar plot with facet
ggplot(titanic, aes(x = factor(Class), fill = factor(Sex))) +
  geom_bar(position = "dodge") +
  facet_grid(".~Survived")

## Smooth line
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, col = Species)) +
  geom_point() +
  geom_smooth()

ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, col = Species)) +
  geom_point() +
  geom_smooth(se = FALSE, span = 0.4)

# with linera model
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, col = Species)) +
  geom_point() +
  geom_smooth(method = "lm")

ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, col = Species)) +
  geom_point() +
  geom_smooth(method = "lm", fullrange = TRUE)

# using a group assign to 1 to only have one line
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, group = 1, col = Species)) +
  geom_point() +
  geom_smooth(method = "lm", fullrange = TRUE)

# To add the smooth line as part of the legend, include the col = inside the aes
ggplot(mtcars, aes(x = wt, y = mpg, col = factor(cyl))) +
  geom_point() +
  stat_smooth(method = "lm", se = F) +
  stat_smooth(aes(group = 1, col = "All"), span = 0.7)

# Combine color with brewer pal and assign them with scale_color_manual()
ggplot(mtcars, aes(x = wt, y = mpg, col = factor(cyl))) +
  geom_point() +
  stat_smooth(method = "lm", se = F) +
  stat_smooth(aes(group = 1, col = "All"), span = 0.7) +
  scale_color_manual("Cylinders", values = c(brewer.pal(3, "Dark2"), "black"))



####### Coordinates Layers

# Zoomin
iris.smooth <- ggplot(iris, aes(x = Sepal.Length,
                                y = Sepal.Width,
                                col = Species)) +
  geom_point(alpha = 0.7) + geom_smooth()

iris.smooth
iris.smooth + scale_x_continuous(limits = c(4.5, 5.5)) # Cut the graph to only specified area
iris.smooth + coord_cartesian(xlim = c(4.5, 5.5)) # Zoom in the graph to specified area
iris.smooth + coord_equal()

# Histogram, with density and percentage stack view
ggplot(adult, aes (x = SRAGE_P, ..count../sum(..count..), fill= factor(RBMI))) + 
  geom_histogram(binwidth = 1, position = "fill") +
  BMI_fill


# Polar chart

wide.bar <- ggplot(mtcars, aes(x = 1, fill = factor(cyl))) +
  geom_bar(width = 1)

wide.bar + coord_polar(theta = "y")

# facet grid - free scale
ggplot(mtcars, aes(mpg, rownames(mtcars), col = factor(am))) +
  geom_point() +
  facet_grid("gear~.", scales = "free", space = "free")

ggplot(mtcars, aes(mpg, rownames(mtcars), col = factor(am))) +
  geom_point() +
  facet_grid(".~gear", scales = "free", space = "free")

or

ggplot(mtcars, aes(mpg, rownames(mtcars), col = factor(am))) +
  geom_point() +
  facet_wrap(~ gear, nrow = 2)

ggplot(mtcars, aes(mpg, rownames(mtcars), col = factor(am))) +
  geom_point() +
  facet_grid("gear~.", scale = "free_y", space = "free_y") +
  theme(strip.text.y = element_text(angle = 0))


#####################  Pier chart  ####################

ggplot(mtcars, aes(x = factor(cyl), fill = factor(am))) +
  geom_bar(position = "fill")

ggplot(mtcars, aes(x = factor(1), fill = factor(am))) +
  geom_bar(position = "fill", width = 1) +
  facet_grid(".~cyl") +
  coord_polar(theta = "y")

##################### stat_summary ####################

ggplot(mtcars, aes(x = cyl, y = wt)) +
  geom_point()

ggplot(mtcars, aes(x = cyl, y = wt)) +
  stat_summary(fun.y = mean, geom = "bar", fill = "skyblue") +
  stat_summary(fun.data = mean_sdl, fun.args = list(mult = 1), geom = "errorbar", width = 0.1)


#####################     GGally   ####################

install.packages("GGally")
library(GGally)

group_by_am <- grep("am", colnames(mtcars))
my_names_am <- (1:11)[-group_by_am]

ggparcoord(mtcars, my_names_am, groupColumn = group_by_am,  alpha = 0.8)

ggparcoord(mtcars, my_names_am, groupColumn = group_by_am,  alpha = 0.8,
           scale = "uniminmax",
           order = "anyClass")

GGally::ggpairs(mtcars)





##################### Theme details ###################




text
  title
    plot.title
    legend.title
  axis.title
    axis.title.x
    axis.title.y
  legend.text
    axis.text.x
    axis.text.y
  strip.text
    strip.text.x
    strip.text.y 

line
  axis.ticks
    axis.ticks.x
    axis.ticks.y
  axis.line
    axis.line.x
    axis.line.y
  panel.grid
  panel.grid.major
    panel.grid.major.x
    panel.grid.major.y
  panel.grid.minor
    panel.grid.minor.x
    panel.grid.minor.y

rect
  legend.background
  legend.key
  panel.background
  panel.border
  plot.background
  strip.background 

legend.position = c(0.85, 0.85) / "bottom" / "none"
legend.direction = "horizontal"
  
  + theme( 
    plot.background = element_rect(fill = myPink, color = "black", size = 3),
    axis.line = element_line(color = "black"),
    strip.text = element_text(size = 16, color = "red"),
    axis.title.y = element_text(color = "red", hjust = 0, face = "italic"),
    axis.title.x = element_text(color = "red", hjust = 0, face = "italic"),
    axis.text = element_text(color = "black")
    panel.background = element_blank(),
    legend.key = element_blank(),                    # legend mark background
    legend.background = element_blank(),
    strip.background = element_blank()
  )
  
# change spacing in the grid
library(grid)
z + theme(
  panel.margin.x = unit(2, "cm"),
  plot.margin = unit(c(0,0,0,0), "cm")
)

base_size

library(ggthemes)


