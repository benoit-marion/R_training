install.packages("GGally")
library(GGally)
#Example


diamonds.samp <- diamonds[sample(1:dim(diamonds)[1],200),]

# Custom Example
ggpairs(
  diamonds.samp[,1:5],
  mapping = ggplot2::aes(color = cut),
  upper = list(continuous = wrap("density", alpha = 0.5), combo = "box"),
  lower = list(continuous = wrap("points", alpha = 0.3), combo = wrap("dot", alpha = 0.4)),
  diag = list(continuous = wrap("densityDiag")),
  title = "Diamonds"
)

### other view
ggally_mysmooth <- function(data, mapping, ...){
  ggplot(data = data, mapping=mapping) +
    geom_density(mapping = aes_string(color="cut"), fill=NA)
}
ggpairs(
  diamonds.samp[,1:5],
  mapping = aes(color = cut),
  upper = list(continuous = wrap("density", alpha = 0.5), combo = "box"),
  lower = list(continuous = wrap("points", alpha = 0.3), combo = wrap("dot", alpha = 0.4)),
  diag = list(continuous = ggally_mysmooth),
  title = "Diamonds"
)