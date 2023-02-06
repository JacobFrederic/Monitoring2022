#Working with landsat data at 30m spatial resolution from the Amazon rain forest
#The image's name is p224r63_2011: path 224 and row 63 from 2011
install.packages("RStoolbox")
library(RStoolbox)
library(raster)
setwd("C:/Users/jacob/Documents/R/lab")
#To upload the image the function ~brick("") can be used which creates a rasterbrick object containing several bands of one satellite image, formed by a pixelmatrix
p224r63_2011 <- brick("p224r63_2011_masked.grd") #In this case we assign the function to the image name
#Next a plot of the image can be created
plot(p224r63_2011)

#With the function ~colorRampPalette() a colour palette with a gradient of 150 steps is created and then assigned to an object
colour <- colorRampPalette(c("blue","green","yellow"))(150) 
plot(p224r63_2011,col=colour)                   #plot with the specified colours

#The function ~par() creates multiple graph within the same raster
#mfrowspecifies the size with the depth and width
par(mfrow=c(2,2))

#To display the different bands in different colors multiple colour palettes can be created and each be plotted

#band 1 in blue
clb <- colorRampPalette(c("blue4","royalblue2","skyblue"))(100) 
plot(p224r63_2011$B1_sre,col=clb)               #band 1 = B1_sre
#band 2 in green
clg <- colorRampPalette(c("dark green","palegreen4","darkseagreen1"))(100) 
plot(p224r63_2011$B2_sre,col=clg)               #band 2 = B2_sre
#band 3 in red
clr <- colorRampPalette(c("brown4","red3","indianred1"))(100) 
plot(p224r63_2011$B3_sre,col=clr)               #band 3 = B3_sre
#band 4, the NearInfraRed
clnir <- colorRampPalette(c("firebrick4","darkorange2","lightgoldenrod"))(100) 
plot(p224r63_2011$B4_sre,col=clnir)             #band 4 = B4_sre 

#The function ~plotRGB() can be used to stack the different band layers on top of each other
plotRGB(p224r63_2011,r=3,g=2,b=1,stretch="Lin")
plotRGB(p224r63_2011,r=4,g=3,b=2,stretch="Lin")
plotRGB(p224r63_2011,r=3,g=4,b=2,stretch="Lin")
plotRGB(p224r63_2011,r=3,g=2,b=4,stretch="Lin")
dev.off() # close the multiframe

#histogram stretching
par(mfrow=c(2,1))
plotRGB(p224r63_2011,r=4,g=3,b=2,stretch="Lin")
plotRGB(p224r63_2011,r=4,g=3,b=2,stretch="hist") #this stretches the values it's possiblt to look inside the forest better (for example seeing bare soil and openings within the forest)

#To see the changes over time in the same place we can upload another image from 1988
p224r63_1988 <- brick("p224r63_1988_masked.grd")
#Use the ~plotRGB() function and assign the parameters to the different bands according to the following to create a plot in natural colours
plotRGB(p224r63_1988,r=3,g=2,b=1,stretch="lin")
#b4 contains the NearInfraRed data, by adding g=4 instead of g=2 (and b=2), the data of it is visualized as green in the image, showing the distribution of area with forest
plotRGB(p224r63_1988,r=3,g=4,b=2,stretch="lin")
#To show the difference between 1988 and 2011 the following set of commands can be followed to show the two corresponding plots next to each other
par(mfrow=c(2,1))
plotRGB(p224r63_1988,r=3,g=4,b=2,stretch="lin")
plotRGB(p224r63_2011,r=3,g=4,b=2,stretch="lin")

#Next, we can calculate the difference between the images pixel by pixel using a multitemporal analysis
difnir <- p224r63_1988[[4]]-p224r63_2011[[4]]
cl <- colorRampPalette(c("green","yellow","red"))(100)  #creating a colour palette highlighting the difference (reduction of Infrared reflection=red, increase green and no difference yellow)
plot(difnir,col=cl)

#With this data we can also calculate the difference in the vegetation index
#For this we have to calculate the DVI by comparing the values of reflection of NearInfraRed and Red light
dvi2011 <- p224r63_2011[[4]]-p224r63_2011[[3]]
dvi1988 <- p224r63_1988[[4]]-p224r63_1988[[3]]
plot(dvi2011)                                  #shows a map with distinctions between for example trees in green and areas with more water in red and orange tones
difdvi <- dvi1988-dvi2011
cl <- colorRampPalette(c("blue","green","red"))(100)
plot(difdvi,col=cl)                            #shows a map showing the loss (red) and gain (blue) of vegetation compared to areas that didn't change (green)
