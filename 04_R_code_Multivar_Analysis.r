#Community ecology example using multivariate analysis in R

#Use a working directory to access external stored files and data and install the necessary packages
setwd("C:/Users/jacob/Documents/R/lab")
install.packages("vegan")       #package for vegetation analysis and community ecology
library(vegan)

#To import a complete saved R project that contains several files from the working directory the function load can be used as follows:
load("biomes_multivar.RData")   #In this example this data consists of two tables, namely biomes.cv and biometypes.cv
 
#If a multivariate analysis is to be conducted, the function decorana which stands for detrended correspondence analysis can be used and assigned to an object:
multivar <- decorana(biomes)    #Just like in a principal component analysis this function simplifies the data by creating new data dimensions in a matrix
multivar                        #can be used to show the properties of multivar

#Call:
#decorana(veg = biomes) 

#Detrended correspondence analysis with 26 segments.
#Rescaling of axes with 4 iterations.
#Total inertia (scaled Chi-square): 2.1153 

#                       DCA1   DCA2    DCA3    DCA4
#Eigenvalues          0.5117 0.3036 0.12125 0.14267
#Additive Eigenvalues 0.5117 0.2985 0.12242 0.12984
#Decorana values      0.5360 0.2869 0.08136 0.04814
#Axis lengths         3.7004 3.1166 1.30055 1.47888

#To visualize the data a plot can be created showing the decorana matrix with DCA1 and DCA2
plot(multivar)
attach(biomes_types)             #To add the biome type labels, the function ~attach() can be used to integrate the second table called biomes_types
#With the function ~ordiellipse() we can add circles around points within the same biome, 
#It is important to define in which table
#type defines which kind of ellipse will be used, here factor = biomes; 
#kind = ehull to create a specific shape of ellipse
#lwd = linewidth 
ordiellipse(multivar,type,col=c("dodgerblue3","green","orange","yellow"),kind="ehull",lwd=2)
#The function ~ordispider() can be used to attach the labels to the ellipses in the form of a "spider net"
ordispider(multivar,type,col=c("dodgerblue3","green","orange","yellow"),label = T)

#~pdf("") can be used to save the plot in pdf format
pdf("multivar.pdf")
