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
