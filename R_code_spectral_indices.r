#Using remote sensing to calculating vegetation indices
library(raster)
library(RStoolbox)#for classifying data
library(patchwork)
setwd("C:/Users/jacob/Documents/R/lab")
l1992 <- brick("defor1.png")
#Bands contain the following information: 1 is NIR, 2 red and 3 green
#Plot the png data with NIR being shown as red, red as green and green as blue
plotRGB(l1992,r=1,g=2,b=3,stretch="Lin")
#Proceed accordingly with the picture from 2006
l2006 <- brick("defor2.png")
plotRGB(l2006,r=1,g=2,b=3,stretch="Lin")
#Using the ~par() function we can see the difference of the location between 1992 and 2006
par(mfrow=c(2,1))
plotRGB(l1992,r=1,g=2,b=3,stretch="Lin")
plotRGB(l2006,r=1,g=2,b=3,stretch="Lin")
#Calculating the vegetation indices using the DVI 
#DVI is a unit that puts NIR and red in relation to estimate the vegeation coverage
#A small difference relates to low plant coverage or plants in a stressed state
dvi1992 <- l1992[[1]]-l1992[[2]]
cl <- colorRampPalette(c("darkblue","yellow","red","black"))(100)
plot(dvi1992,col=cl)
dvi2006 <- l2006[[1]]-l2006[[2]]
plot(dvi2006,col=cl)
#The resulting images highlight a significant loss of forested (red) area in favour of more agricultural land use (yellow)
#Using R the areas can be classified into different categories using an automatically generated values of the NIR and red values
#In the following a unsupervised classification will be conducted
d1c <- unsuperClass(l1992,nClasses=2) #nClasses=2 signals that there will be 2 classes
d1c             #showing some of the characteristics of d1c
plot(d1c$map)   #plotting the data with class 1 being forest and class 2 being anthropogenic impacted areas
freq(d1c$map)   #showing the frequency of pixels attributed to each class
f1992 <- 306841/(306841+34451) #forest
h1992 <- 34451/(34451+306841) #human/anthropogenic impact
f1992
h1992
# 1992
# class 1: forest - 306841 - ~90 %
# class 2: human  -  34451 - ~10 %
#Proceeding accordingly with the data from 2006
d2c <- unsuperClass(l2006,nClasses=2)
d2c
plot(d2c$map) #the classes are reversed this time so forest is class 2 and human affected area class 1
freq(d2c$map)
f2006 <- 179249/(163477+179249)
h2006 <- 163477/(163477+179249)
f2006
h2006
# 2006
# class 2: forest - 179249 - ~52 %
# class 1: human  - 163477 - ~48 %
