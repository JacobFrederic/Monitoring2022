#Point pattern analysis for population analysis
library(spatstat)                                   #access the spatstat package
#Use setwd function to set up a working directory
setwd("C:/Users/jacob/Documents/R/lab")
covid <- read.table("covid_agg.csv",header=TRUE)    #upload the necessary file and assign it to the object covid
#With this data we can create a planar point pattern in spatstat with the following functions
#First we must use the ppp function to define the x and y axis as longitude and latitude as well as their respective ranges
attach(covid)                                       #attaching the covid data set so R can find the data
ppp(lon,lat,c(-180,180),c(-90,90))
covid_planar <- ppp(lon,lat,c(-180,180),c(-90,90))  #this can be assigned to for example the object covid_planar
density_map <- density(covid_planar)                #converting the data into a virtual map that shows the density of the measured data
plot(density_map)                                   #plots said density map
points(covid_planar,pch=19)                         #adding the locations of the data points onto the density map
#To change the colour spectrum of the plot indicating the density the following function can be used
#The function colorRampPalette is filled with an array of the desired colours, (100) is added to indicate that there should be 100 intermediate steps between the colours
cl <- colorRampPalette(c('violet','blue','cyan','green','yellow','orange','red','magenta'))(100)
plot(density_map, col = cl)
points(covid_planar)
