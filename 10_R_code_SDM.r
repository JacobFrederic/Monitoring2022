#Using Species Distribution Modelling for prediction (of for example occurence) and understanding (for example the underlying factors of species distribution)

#First, install and access all necessary packages
install.packages("sdm")
install.packages("rgdal",dependencies=T)
library(sdm)
library(raster)             #needed for predictors
library(rgdal)    

#We are looking for the species.shp file within the sdm package (it's placed in a folder that is prenamed as external) with the following function
#At the same time we assign it to the name file
file <- system.file("external/species.shp",package="sdm")
#Now the shapefile can be read and put into R
species <- shapefile(file)  #this function requires the raster package

#To have a first look at the file information, we use the following commands
species
plot(species)
#Now we want to view the occurences
species$Occurrence
#To filter out all the data points where there are no occurences, we cann add the condition of Occurence having the value 1
presences <- species[species$Occurrence == 1,] 
#Alternatively by excluding absences:
species[species$Occurrence != 0,]
#Accordingly, the absences can be assigned:
absences <- species[species$Occurrence != 1,] 

#Now this can be plotted with two different colours to visualize the distribution
plot(presences,col="blue",pch=20)
points(absences,col="red",pch=20)               #this function adds the points to the previous plot instead of creating a new plot

#From this data we can create a map of the probability of the distribution
#For this the environmental data (temperature, precipitation, elevation, vegetation) must be uploaded
#This stack is called predictors, the factors that predict the distribution
path <- system.file("external",package="sdm")   #this simplifies the listing of the predictors in the next step
lst <- list.files(path=path,pattern="asc$",full.names=T)
lst

#This list can be stacked and assigned to the object preds to then plot the different predictors "intensities"
preds <- stack(lst)
plot(preds)

#Now we set the data for the SDM by creating a single object encompassing both the species data and the predictors
datasdm <- sdmData(train=species,predictors=preds)
datasdm
#With this data and the ~sdm() function we can create a model
m1 <- sdm(Occurrence ~ elevation + precipitation + temperature + vegetation,data=datasdm,methods="glm")
#Creating the raster output layer with the model m1:
p1 <- predict(m1,newdata=preds)
#This final map of predicted occurence can be plotted
plot(p1)

#This map can now be stacked together with the predictors and visualized together
s1 <- stack(preds,p1)
plot(s1)
