# Colors
barplot(c(12,4,21,17,13,9), col = 1:6)
barplot(c(12,4,21,17,13,9), col = rainbow(6))
barplot(c(12,4,21,17,13,9), col = heat.colors(6))
barplot(c(12,4,21,17,13,9), col = terrain.colors(6))
barplot(c(12,4,21,17,13,9), col = topo.colors(6))
barplot(c(12,4,21,17,13,9), col = cm.colors(6))

# Color Brewer
install.packages("RColorBrewer")
x <- c(12,4,21,17,13,9)
accent6 <- brewer.pal(6, "Accent")
barplot(x, col = accent6)

barplot(x, col = brewer.pal(6, "Set3"))

# basic plot
plot(UCBAdmissions)

# basic bar plot
barplot(c(12,4,21,17,13,9))

# Advanced  bar plot
data(chickwts)
feeds <- table(chickwts$feed)
b <- barplot(feeds[order(feeds)],
        horiz = TRUE,
        las = 1,  # las gives orientation of axis labels
        col = c(rainbow(6)),
        border = NA, # No borders on bars
        main = "Frequencies of Different Feeds\nin chickwts Dataset", # \n = line break
        xlab = "Number of Chicks")

# axis flip
coord_flip()


# Pie Chart
pie(c(12,4,21,17,13,9))

pie(feeds[order(feeds, decreasing = TRUE)],
    init.angle = 90, # Start as 12 o clock instead of 3
    clockwise = TRUE, # Default is FALSE
    col = rainbow(6),
    main = "Pie Chart of Feeds from chickwts")


# Histogram
h <- hist(lynx,
          breaks = 11, # Suggests 11 bins
          #          breaks = seq(0, 7000, by = 100),
          #          breaks = c(0, 100, 300, 500, 3000, 3500, 7000),
          freq = FALSE, # Proportion of the distribution
          col = "thistle1",
          main = "Histogram of Annual Canadian Lynx Trapping\n1821-1934",
          xlab = "Number of Lynx Trapped")

# IF freq = FALSE, this will draw a normal distributuion

curve(dnorm(x, mean = mean(lynx), sd = sd(lynx)),
      col = "thistle4",
      lwd = 2,
      add = TRUE)

# Histogram2 - with lines

fertility <- swiss$Fertility
h <- hist(fertility,
          prob = TRUE, # Flipside of "freq = FALSE", probablility distribution
          ylim = c(0, 0.04),
          xlim = c(30, 100),
          breaks = 11,
          col = "#E5E5E5",
          border = 0,
          main = "Fertility for 47 French-Speaking\nSwiss Provinces, c. 1888")

# Normal Curve (if prob = TRUE)
curve(dnorm(x, mean = mean(fertility), sd = sd(fertility)),
      col = "red",
      lwd = 3, # pixel thickness
      add = TRUE)

# Kernel density lines
lines(density(fertility), col = "blue")
lines(density(fertility, adjust = 3), col = "darkgreen")

# Lineplot under histogram
rug(fertility, col = "red")


# BoxPlot

boxplot(USJudgeRatings,
        horizontal = TRUE,
        las = 1, # Make all labels horizontal
        notch = TRUE, # Notches for CI for mediam)
        ylim = c(0,10), # Specify range on Y axis
        col = "slategray3", 
        boxwex = 0.5, # Width of the box as proportion of the original
        whisklty = 1, # Whisker line type; 1 = solid line
        staplelty = 0, # Staple (line at end) type; 0 = none
        outpch = 16, # Symbols for outliers; 16 = filled circle
        outcol = "slategray1",
        main = "Lawyers' Rating of the State Judges in the\nUS Superio Court (c. 1977)",
        xlab = "Lawyers' Ratings")
    
# Changing graphical parameters 
oldpar <- par()
par(mfrow = c(1, 3), # Number of rows/cols
    cex.main = 3) # Main title 3x bigger
par(oma = c(1, 1, 1, 1), # margin fix
    mar = c(4, 5, 2, 1))
par(oldpar)

# Export to PNG

png(filename= "~/Extract_feeds.png",
    width = 888,
    height = 571)
 # Chart
dev.off()


# Export to PDF
pdf("~/Extract.pdf",
    width = 9, # size in inches
    height = 6)
barplot(feeds[order(feeds)],
        horiz = TRUE,
        las = 1,  # las gives orientation of axis labels
        col = c(rainbow(6)),
        border = NA, # No borders on bars
        main = "Frequencies of Different Feeds\nin chickwts Dataset", # \n = line break
        xlab = "Number of Chicks")
dev.off()
