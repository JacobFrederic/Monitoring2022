#First exploration of working with landsat data at 20m spatial resolution from the amazon forest 
#The image's name is p224r63_2011: path 224 and row 63 from 2011
library(raster)

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

#To dispaly the different bands in different colors multiple colour palettes can be created and each be plotted

#band 1 in blue
clb <- colorRampPalette(c("blue4", "royalblue2", "skyblue"))(100) 
plot(p224r63_2011$B1_sre,col=clb) # band 1 = B1_sre

# repeat for band 2 in green
clg <- colorRampPalette(c("dark green", "palegreen4", "darkseagreen1"))(100) 
plot(p224r63_2011$B2_sre, col=clg) # band 2 = B2_sre

# repeat for band 3 in red
clr <- colorRampPalette(c("brown4", "red3", "indianred1"))(100) 
plot(p224r63_2011$B3_sre, col=clr) # band 3 = B3_sre

# plot the final band, the NearInfraRed, which is band number 4 using a new color palette
clnir <- colorRampPalette(c("firebrick4", "darkorange2", "lightgoldenrod"))(100) 
plot(p224r63_2011$B4_sre, col=clnir) # band 4 = B4_sre 

#The function ~plotRGB() can be used t0 stack the different band layers on top of each other
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")
