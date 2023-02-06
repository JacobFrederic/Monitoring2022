#Point pattern analysis for population analysis

library(spatstat)                                   #access the spatstat package
library(rgdal)                                      #access the rgdal package

#Use setwd function to set up a working directory
setwd("C:/Users/jacob/Documents/R/lab")

covid <- read.table("covid_agg.csv",header=TRUE)    #upload the necessary file and assign it to the object covid
#With this data we can create a planar point pattern in spatstat with the following functions

#First we must use the ~ppp() function to define the x and y axis as longitude and latitude as well as their respective ranges
attach(covid)                                       #attaching the covid data set so R can find the data
ppp(lon,lat,c(-180,180),c(-90,90))
covid_planar <- ppp(lon,lat,c(-180,180),c(-90,90))  #this can be assigned to for example the object covid_planar
density_map <- density(covid_planar)                #converting the data into a virtual map that shows the density of the measured data
plot(density_map)                                   #plots said density map
points(covid_planar,pch=19)                         #adding the locations of the data points onto the density map

#To change the colour spectrum of the plot indicating the density the following function can be used
#The function ~colorRampPalette() is filled with an array of the desired colours, (100) is added to indicate that there should be 100 intermediate steps between the colours
cl <- colorRampPalette(c('violet','blue','cyan','green','yellow','orange','red','magenta'))(100)
plot(density_map, col = cl)
points(covid_planar)

#The next step will be to add the coastlines to the plotted image to better visualize the data
coastlines <- readOGR("ne_10m_coastline.shp")       #this function extracts the coastline shp-file from the lab folder and assigns the information to the object coastlines
#Like before we assign a colour palette to an object cl, plot the data with this colour scheme and then add the points and the coastlines with the following functions
cl <- colorRampPalette(c('green','chartreuse','yellow','orange','red'))(500)
plot(density_map,col=cl)
points(covid_planar,pch=19,cex=0.5)
plot(coastlines,add=TRUE)                           #the add=TRUE line indicates that instead of a new plot with the coastline data, the coastlines will be showed on top of the previous plot

#To interpolate the data between the measured points we can do the following:
marks(covid_planar) <- cases                        #used to assign the cases from the data file to marks on the covid_planar object
cases_map <- Smooth(covid_planar)                   #interpolates the data in covid_planar and assigns the results to the object cases_map
plot(cases_map,col=cl)
points(covid_planar)
plot(coastlines,add=T)
