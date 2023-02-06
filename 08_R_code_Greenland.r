#Analysis of a time series visualizing temperatures in Greenland

#Access the required packages and set up a working directory where the images are stored
library(raster)
library(ggplot2)
library(RStoolbox)
library(viridis)
library(patchwork)
library(rasterVis)
library(rgdal)
setwd("C:/Users/jacob/Documents/R/lab")

#Upload the satellite images from 2000 as a RasterLayer image and assign it to an object
lst_2000 <- raster("lst_2000.tif")
lst_2005 <- raster("lst_2005.tif")
lst_2010 <- raster("lst_2010.tif")
lst_2015 <- raster("lst_2015.tif")

#For four pictures this is still uploading but with an increasing amount of images it's worth considering using the following fucntions to upload a stack of images
rlist <- list.files(pattern="lst")    #lists the files with a parameter about the pattern containing the beginning of their names
rlist                                 #shows the found files
import <- lapply(rlist,raster)        #applies a function (in this case ~raster() ) to the list of images
TGr <- stack(import)                  #creates a single file with the four images as layers inside of it
plot(TGr)

#Creating a ggplot with the viridis colour palette
#direction can reverse the colour gradient and alpha regulates the transparency of the colour
ggplot() + geom_raster(TGr[[1]],mapping=aes(x=x,y=y,fill=lst_2000)) + scale_fill_viridis(option="mako",alpha=0.8,direction=-1) + ggtitle("2000")

#Using the ~ggplot() function to create maps of the different years and with the help of the patchwork package, in the end they can be shown next to each other
p1 <- ggplot() + geom_raster(TGr[[1]],mapping=aes(x=x,y=y,fill=lst_2000)) + scale_fill_viridis(option="mako",alpha=0.8,direction=-1) + ggtitle("Temperature 2000")
p2 <- ggplot() + geom_raster(TGr[[2]],mapping=aes(x=x,y=y,fill=lst_2005)) + scale_fill_viridis(option="mako",alpha=0.8,direction=-1) + ggtitle("Temperature 2005")
p3 <- ggplot() + geom_raster(TGr[[3]],mapping=aes(x=x,y=y,fill=lst_2010)) + scale_fill_viridis(option="mako",alpha=0.8,direction=-1) + ggtitle("Temperature 2010")
p4 <- ggplot() + geom_raster(TGr[[4]],mapping=aes(x=x,y=y,fill=lst_2015)) + scale_fill_viridis(option="mako",alpha=0.8,direction=-1) + ggtitle("Temperature 2015")
(p1+p2)/(p3+p4)

#To show the difference in temperature between two of the selected years, the following functions can be used
dift = TGr[[4]] - TGr[[1]]
dift
d41 <- ggplot() + geom_raster(dift,mapping=aes(x=x,y=y,fill=layer)) + scale_fill_viridis(option="magma",direction=1) + ggtitle("Change in temperature 2000-2015")
d41

plotRGB(TGr,r=1,g=2,b=4,stretch="lin")
#Shows the temperature changes, but just adding images together, there might be a lot of noise
#the green and blue-ish areas have a higher temperature than at the beginning of the time frame
