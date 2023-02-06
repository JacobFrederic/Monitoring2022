#This is a code for investigating among ecological variables

#First, remember to check if the necessary packages (in this case sp) are already installed, if not type: 
#install.packages("sp")
library(sp)   #use library(sp) or require(sp) to access it
              #search https://cran.r-project.org/web/packages/gstat/vignettes/gstat.pdf to find information about the data set

data(meuse)   #used to gather all the data of meuse
meuse         #using the name of the dataset will result in the data frame being shown
View(meuse)   #shows the data frame in a pop-up window
              #dev.off can be used to shut down any open windows. it may be used in case of an error message related to it
head(meuse)   #only shows you the column names and the first few rows
names(meuse)  #exclusively shows you the names of the columns

#To calculate the mean, median and some additional informartion (quartiles, minimum and maximum), use the following function
summary(meuse)

#To plot different variables, it's first necessary to use the following function to link the data within the table to the specific variable
attach(meuse)
#Now a plot can be performed, the following functions as an example:
plot(cadmium,zinc)
#Alternatively this can be performed without the function attach by adding meuse$ in front of each variables within the plot-function like this:
#plot(meuse$cadmium,meuse$zinc)
pairs(meuse)  #function for a scatterplot matrix, creates all potential plots of different variables, shows all potential relationships in one function

#If only a part of all pairs is required, it's possible to limit the plots shown by using only certain columns and assigning them to an object (in this case pol for pollution):
pol <- meuse[,3:6]
pairs(pol, col="green",cex=1.25, pch=15) #function to plot the partial amount of meuse
#In this example the colour has been chosen to be red, the size was increased by the factor 1.5 and the shape was chosen to be filled squares
#The following function is another way of achieving this by using the column names instead
pairs(~ cadmium + lead + zinc, data=meuse)

#To create a spatial dataset, we must transform the x and y values into coordinates by using this function:
coordinates(meuse) = ~x+y 

#The function ~spplot() can now be used to create an image of the spatial distributions of all measurements or for visualizing the distribution of the values of the specific variables
#In this case, these are the concentration of different elements at a riverbank
spplot(meuse, "zinc", main="Concentration of zinc")
spplot(meuse, c("copper","zinc")) #creates an array (which is why it is important to add a c), plotting several variables together

#With the ~bubble() function, the different concentration can be visualized by different symbol sizes instead of different colours, offering a clearer and more colourblind-friendly overview
bubble(meuse, "zinc")
