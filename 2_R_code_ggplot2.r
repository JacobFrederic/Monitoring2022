#Introduction to ggplots

install.packages("ggplot2")             #installs the required package
library(ggplot2)                        #function to open the  package

virus <- c(10,30,40,50,60,80)           #example for measurements of the occurence of a virus as an array
death <- c(100, 240, 310, 470, 580,690) #accordingly, a number of corresponding death measurements

plot (virus,death)                      #old way to create a plot

#Alternatively you can create a data frame that will assign the variables to a corresponding table
data.frame(virus,death)
d <- data.frame(virus,death)            #assigns the data frame to an object d
summary(d)                              #overview of the object and shows univariate statistical info

ggplot(d,aes(x=virus,y=death)) + geom_point()      
#requires to define the variables as asthetics, so geom_point will find them. 
#geom_points creates a scatterplot with the data
ggplot(d,aes(x=virus,y=death)) + geom_point(size=3,col="green") #the points can be edited of the plot can be edited by directly changing the geom_points
#To add more geometries and use them together, the functions can simply be added to the existing function
ggplot(d,aes(x=virus,y=death)) + geom_point(size=3,col="green") + geom_line(col="red") + geom_polygon(col="purple")

#To import and use data from a folder outside of R you can use the function for setting a working directory:
setwd("C:/Users/jacob/Documents/R/lab") #the path within the brackets must match the path of the stored file
#With the ~read.table() function R converts the data from the file into a workable table
read.table("covid_agg.csv",header=TRUE) 
#header=TRUE describes that the first row in the table is not a set of data but contains the names of the variables
covid <- read.table("covid_agg.csv",header=TRUE) #assigns the table to the object "covid"
summary(covid)                          #overview that also includes the information of maximum, minimum, mean and average of cases per country

#Now the ~ggplot() function can be used to create an image of the spatial distribution with varying point sizes to illustrate the amount of cases per country
ggplot(covid,aes(x=lon,y=lat,size=cases)) + geom_point()
