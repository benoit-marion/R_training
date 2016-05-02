library(googleVis)
demo(googleVis)

#Motion example
Motion=gvisMotionChart(Fruits, 
 idvar="Fruit", 
 timevar="Year")
plot(Motion)

#Sankey example
Sankey <- gvisSankey(datSK, from="From", to="To", weight="Weight",
+ options=list(
+ sankey="{link: {color: { fill: '#d799ae' } },
+ node: { color: { fill: '#a61d4c' },
+ label: { color: '#871b47' } }}"))

plot(Sankey)

