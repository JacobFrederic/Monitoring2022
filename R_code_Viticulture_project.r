#First steps: 
#Setting up the working directory 
#Accessing all required packages
setwd("C:/Users/jacob/Documents/R/lab")
library(raster)     #allows modeling with analysis of spatial data
library(ggplot2)    #used to create easily adjustable and visually appealing plots
library(viridis)    #color scheme that works for "almost" everyone
library(patchwork)  #needed to visualize multiple ggplots next to each other
library(RStoolbox)  #allows to fortify raster data
library(maps)       #for overlaying the country borders

#In this project only Europe was covered, therefore these coordinates were set up for later crop functions
Europe <- extent(-15,40,35,70)

#To create maps of the areas that are suitable for viticulture, the parameters have to be defined
#According Hannah et al. (2013 (Climate change, wine, and conservation), the most important parameter is the growing season mean temperature
#In Europe the growing season is defined as April until October
#Cumulating different grape variety acceptance leads to a temperature range of 13.1-20.9°C
rangetsum <- seq(13.1,20.9,by=0.1)
13.6 %in% rangetsum #Test
#Additionally the temperature in winter must not fall below -15°C monthly mean temperature
rangetwin <- seq(-10,15,by=0.1)
#Regarding precipitation, a range from annually 200mm up to 1226mm was considered suitable
rangeprec <- c(200:1226)

#Growing season mean temperature:
#The .tif files from the WorldClim global data set were used as a baseline climate (1970-2000)
#In the following step the monthly average temperature files were uploaded as Raster files into a stack
tavglist <- intersect(list.files(pattern="tavg"),list.files(pattern="tif"))
importtavg <- lapply(tavglist,raster)
tavgmonthly <- stack(importtavg)
tavgmonthly <- crop(tavgmonthly,Europe) #cropping to only show Europe
#From this a subset of April until October was assigned as tavg summer
tavgsum <- tavgmonthly[[4:10]]
tavgsum[[1]]  

t4 <- (ggplot() 
       + annotation_map(map_data("world"),fill="gray90")
       + theme_minimal()
       + geom_raster(tavgsum[[1]],mapping=aes(x=x,y=y,fill=wc2.1_2.5m_tavg_04))
       + ggtitle("April")
       + theme(plot.title=element_text(hjust=0.5))
       + scale_fill_viridis(limits=c(-15,30),option="inferno",alpha=1,direction=1,na.value=NA)
       + coord_fixed() 
       + theme(legend.title=element_blank())
       + annotation_map(map_data("world"),fill=NA,colour="gray20",size=0.3) #double to ensure land mass have a colour underneath the plot and the border lines are above it
       + ylab ("latitude") + xlab ("longitude"))

t5 <- (ggplot() + annotation_map(map_data("world"),fill="gray90") + theme_minimal() + geom_raster(tavgsum[[2]],mapping=aes(x=x,y=y,fill=wc2.1_2.5m_tavg_05)) + ggtitle("May") + theme(plot.title=element_text(hjust=0.5)) + scale_fill_viridis(limits=c(-15,30),option="inferno",alpha=1,direction=1,na.value=NA)  + coord_fixed() + theme(legend.title=element_blank()) + annotation_map(map_data("world"),fill=NA,colour="gray20",size=0.3) + ylab ("latitude") + xlab ("longitude"))
t6 <- (ggplot() + annotation_map(map_data("world"),fill="gray90") + theme_minimal() + geom_raster(tavgsum[[3]],mapping=aes(x=x,y=y,fill=wc2.1_2.5m_tavg_06)) + ggtitle("June") + theme(plot.title=element_text(hjust=0.5)) + scale_fill_viridis(limits=c(-15,30),option="inferno",alpha=1,direction=1,na.value=NA) + coord_fixed() + theme(legend.title=element_blank()) + annotation_map(map_data("world"),fill=NA,colour="gray20",size=0.3) + ylab ("latitude") + xlab ("longitude"))
t7 <- (ggplot() + annotation_map(map_data("world"),fill="gray90") + theme_minimal() + geom_raster(tavgsum[[4]],mapping=aes(x=x,y=y,fill=wc2.1_2.5m_tavg_07)) + ggtitle("July") + theme(plot.title=element_text(hjust=0.5)) + scale_fill_viridis(limits=c(-15,30),option="inferno",alpha=1,direction=1,na.value=NA) + coord_fixed() + theme(legend.title=element_blank()) + annotation_map(map_data("world"),fill=NA,colour="gray20",size=0.3) + ylab ("latitude") + xlab ("longitude"))
t8 <- (ggplot() + annotation_map(map_data("world"),fill="gray90") + theme_minimal() + geom_raster(tavgsum[[5]],mapping=aes(x=x,y=y,fill=wc2.1_2.5m_tavg_08)) + ggtitle("August") + theme(plot.title=element_text(hjust=0.5)) + scale_fill_viridis(limits=c(-15,30),option="inferno",alpha=1,direction=1,na.value=NA) + coord_fixed() + theme(legend.title=element_blank()) + annotation_map(map_data("world"),fill=NA,colour="gray20",size=0.3) + ylab ("latitude") + xlab ("longitude"))
t9 <- (ggplot() + annotation_map(map_data("world"),fill="gray90") + theme_minimal() + geom_raster(tavgsum[[6]],mapping=aes(x=x,y=y,fill=wc2.1_2.5m_tavg_09)) + ggtitle("September") + theme(plot.title=element_text(hjust=0.5)) + scale_fill_viridis(limits=c(-15,30),option="inferno",alpha=1,direction=1,na.value=NA) + coord_fixed() + theme(legend.title=element_blank()) + annotation_map(map_data("world"),fill=NA,colour="gray20",size=0.3) + ylab ("latitude") + xlab ("longitude"))
t10 <- (ggplot() + annotation_map(map_data("world"),fill="gray90") + theme_minimal() + geom_raster(tavgsum[[7]],mapping=aes(x=x,y=y,fill=wc2.1_2.5m_tavg_10)) + ggtitle("October") + theme(plot.title=element_text(hjust=0.5)) + scale_fill_viridis(limits=c(-15,30),option="inferno",alpha=1,direction=1,na.value=NA) + coord_fixed() + theme(legend.title=element_blank()) + annotation_map(map_data("world"),fill=NA,colour="gray20",size=0.3) + ylab ("latitude") + xlab ("longitude"))

#Visualization of summer monthly mean temperatures (without May for aesthetic reasons) using ggplots
tcomb <- ((t4+t6+t7)/(t8+t9+t10) 
          + plot_annotation(title="Monthly Mean Temperatures",subtitle="1970-2000",theme=theme(plot.title=element_text(hjust=0.5),plot.subtitle=element_text(hjust=0.5)))
          + plot_layout(guides="collect")) #combining the legends into one combined one
tcomb

#They were merged into a single raster using the following function
tsum <- stackApply(tavgsum,indices=c(1),fun=mean)  #since overall mean temperature is required: fun=mean
tsum
#Visualization using the ggplot package
tsumgg <- (ggplot() 
           + annotation_map(map_data("world"),fill="gray90")
           + theme_minimal()
           + geom_raster(tsum,mapping=aes(x=x,y=y,fill=index_1)) 
           + ggtitle("Growing Season Temperature",subtitle="1970-2000")
           + scale_fill_viridis(limits=c(-10,30),option="inferno",alpha=1,direction=1,na.value=NA) 
           + coord_fixed() 
           + theme(plot.title=element_text(hjust=0.5),plot.subtitle=element_text(hjust=0.5)) 
           + theme(legend.position="bottom") 
           + theme(legend.title=element_blank())
           + annotation_map(map_data("world"),fill=NA,colour="gray20",size=0.3)
           + ylab ("latitude") + xlab ("longitude"))
tsumgg

#Because of technical reasons, the mean temperature data has to be rounded for the next step
rangesum <- round(tsum,digits=1)
#With the following function, all values that are not within the defined temperature ranged will be deleted
rangesum[!(rangesum %in% rangetsum)] <- NA
rangesum
#With another ggplot we can see the areas in which the summer temperatures will probably allow viticulture
rangesumgg <- (ggplot() 
               + annotation_map(map_data("world"),fill="gray90",colour=NA)
               + theme_minimal()
               + geom_raster(rangesum,mapping=aes(x=x,y=y,fill=layer)) 
               + ggtitle("Suitability for Viticulture",subtitle="Based on Growing Season Temperatures 1970-2000")
               + scale_fill_viridis(limits=c(13,21),option="inferno",alpha=1,direction=1,na.value=NA) 
               + coord_fixed() 
               + theme(plot.title=element_text(hjust=0.5),plot.subtitle=element_text(hjust=0.5)) 
               + theme(legend.position="bottom") 
               + theme(legend.title=element_blank()) 
               + annotation_map(map_data("world"),fill=NA,colour="gray5",size=0.3)
               + ylab ("latitude") + xlab ("longitude"))
rangesumgg
#For later, the actual temperature will not be considered but only a binary approach of suitable/non-suitable
#Therefore, using a subset, the suitable values will be simplified into 1 and then visualized
ranges00 <- rangesum
ranges00[(ranges00 %in% rangetsum)] <- 1
ranges00
ranges00gg <- (ggplot() 
               + annotation_map(map_data("world"),fill="gray90")
               + theme_minimal()
               + geom_raster(ranges00,mapping=aes(x=x,y=y,fill=layer)) 
               + ggtitle("Suitability for Viticulture",subtitle="Based on Growing Season Temperatures\n1970-2000")
               + scale_fill_gradient(low="dodgerblue",na.value=NA) 
               + coord_fixed() 
               + theme(legend.position="none") 
               + theme(plot.title=element_text(hjust=0.5),plot.subtitle=element_text(hjust=0.5)) 
               + annotation_map(map_data("world"),fill=NA,colour="gray20",size=0.3)
               + ylab ("latitude") + xlab ("longitude"))
ranges00gg

#A similar approach will be used for the condition of minimum monthly mean temperature being above -15°C
#However, since the minimum monthly mean temperatue is relevant and not just the overall mean, they first have to be computed separately
tavgwin <- tavgmonthly[[c(1,2,3,11,12)]]
rangewin5 <- round(tavgwin,digits=0.1)
#To allow later subtraction of areas with each other, they will be separated into suitable/non-suitable (considering the winter conditions)
rangewin5[(rangewin5 %in% rangetwin)] <- 1
rangewin5[!(rangewin5 %in% rangetwin)] <- NA
rangewin5
range01gg <- (ggplot() 
              + annotation_map(map_data("world"),fill="gray90")
              + theme_minimal()
              + geom_raster(rangewin5[[1]],mapping=aes(x=x,y=y,fill=wc2.1_2.5m_tavg_01)) 
              + ggtitle("Viticulture Suitability",subtitle="Based on January Mean Temperature")
              + scale_fill_gradient(low="orchid",na.value=NA) 
              + coord_fixed() 
              + theme(plot.title=element_text(hjust=0.5),plot.subtitle=element_text(hjust=0.5)) 
              + theme(legend.position="none") 
              + annotation_map(map_data("world"),fill=NA,colour="gray20",size=0.3)
              + ylab ("latitude") + xlab ("longitude"))
range01gg
#These 5 different layers will be merged as done before
#To guarantee that only areas where the temperature falls within the predefined range are marked, only the pixels with a value 5 will be considered
#Since they have shown to be above -15°C in all 5 months
rangewin <- stackApply(rangewin5,indices=c(1),fun=sum)
rangewin[(rangewin <= 4)] <- NA 
rangewin[(rangewin == 5)] <- 1
rangewin
rangewingg <- (ggplot() 
               + annotation_map(map_data("world"),fill="gray90")
               + theme_minimal()
               + geom_raster(rangewin,mapping=aes(x=x,y=y,fill=index_1)) 
               + labs(title="Suitability for Viticulture",subtitle="Based on Winter Temperatures\n1970-2000")
               + scale_fill_gradient(low="orchid",na.value=NA) 
               + coord_fixed() 
               + theme(plot.title=element_text(hjust=0.5),plot.subtitle=element_text(hjust=0.5)) 
               + theme(legend.position="none") 
               + annotation_map(map_data("world"),fill=NA,colour="gray20",size=0.3)
               + ylab ("latitude") + xlab ("longitude"))
rangewingg
range01gg+rangewingg     #Comparison of suitability based on just January and the combined raster to verify the results/calculations

#Lastly, the precipitation limitations will be investigated
#First, the monthly precipitation data will be uploaded
preclist <- intersect(list.files(pattern="prec"),list.files(pattern="tif"))
preclist
importprec <- lapply(preclist,raster)
precmonthly <- stack(importprec)
precmonthly
#Since only overall annual precipitation will be considered, the stack will be merged (as a sum this time)
preca <- stackApply(precmonthly,indices=c(1),fun=sum)
preca <- crop(preca,Europe) #cropping to Europe
preca
precagg <- (ggplot() 
            + annotation_map(map_data("world"),fill="gray90")
            + theme_minimal()
            + geom_raster(preca,mapping=aes(x=x,y=y,fill=index_1)) 
            + ggtitle("Annual Precipitation",subtitle="1970-2000")
            + scale_fill_viridis(limits=c(1,4000),option="viridis",alpha=1,direction=1,na.value=NA) 
            + coord_fixed() 
            + theme(plot.title=element_text(hjust=0.5),plot.subtitle=element_text(hjust=0.5)) 
            + theme(legend.position="bottom") 
            + theme(legend.title=element_blank()) 
            + annotation_map(map_data("world"),fill=NA,colour="gray20",size=0.3)
            + ylab ("latitude") + xlab ("longitude"))
precagg   #Visualization of annual precipitation as ggplot

rangep <- preca #creating a copy for further editing
rangep[!(rangep %in% rangeprec)] <- NA  #changing the value of all areas not suitable to NA
rangep[(rangep %in% rangeprec)] <- 1    #changing the value of all areas suitable to 1
rangep
rangepgg <- (ggplot() 
             + annotation_map(map_data("world"),fill="gray90")
             + theme_minimal()
             + geom_raster(rangep,mapping=aes(x=x,y=y,fill=index_1)) 
             + ggtitle("Suitability for Viticulture",subtitle="Based on Precipitation\n1970-2000")
             + scale_fill_gradient(low="green",na.value=NA) 
             + coord_fixed() 
             + theme(plot.title=element_text(hjust=0.5),plot.subtitle=element_text(hjust=0.5)) 
             + theme(legend.position="none") 
             + annotation_map(map_data("world"),fill=NA,colour="gray20",size=0.3)
             + ylab ("latitude") + xlab ("longitude"))
rangepgg  #Visualization of range based on precipitation as ggplot


#Now the three parameters can be combined to create a "better" fit of the actual suitable area
ranges00gg+rangewingg+rangepgg
#First the three range maps are stacked together
srb <- stack(rangep,rangewin,ranges00) #stacked as stack range baseline

#Merging the three, adding them on top of each other
rb <- stackApply(srb,indices=c(1),fun=sum) #merged as range baseline
rbgg <- (ggplot() 
         + annotation_map(map_data("world"),fill="gray90")
         + theme_minimal()
         + geom_raster(rb,mapping=aes(x=x,y=y,fill=index_1)) 
         + ggtitle("Suitability for Viticulture",subtitle="1970-2000")
         + scale_fill_gradient(limits=c(1,3),low="chartreuse",na.value=NA)
         + coord_fixed() 
         + theme(plot.title=element_text(hjust=0.5),plot.subtitle=element_text(hjust=0.5)) 
         + theme(legend.position="none") 
         + annotation_map(map_data("world"),fill=NA,colour="gray20",size=0.3)
         + ylab ("latitude") + xlab ("longitude"))
rbgg  #Visualization of combined range parameter data as ggplot

#Since in all three parameters 1 indicates suitable and 0 not suitable, in the merged RasterLayer, only the areas with a value of 3 (as the sum) should be suitable based on all three parameters
#Accordingly, all values except 3 can be deleted to show this
rb2 <- rb
rb2[(rb2 != 3)] <- NA
rb2[(rb2 == 3)] <- 1
rb2
rb2gg <- (ggplot() 
          + annotation_map(map_data("world"),fill="gray90")
          + theme_minimal()
          + geom_raster(rb2,mapping=aes(x=x,y=y,fill=index_1)) 
          + ggtitle("Suitability for Viticulture",subtitle="1970-2000")
          + scale_fill_gradient(limits=c(1,3),low="chartreuse",na.value=NA)
          + coord_fixed() 
          + theme(plot.title=element_text(hjust=0.5),plot.subtitle=element_text(hjust=0.5)) 
          + theme(legend.position="none") 
          + annotation_map(map_data("world"),fill=NA,colour="gray20",size=0.3)
          + ylab ("latitude") + xlab ("longitude"))
rb2gg    #Creating a "final" ggplot of the range of areas suitable for viticulture based on summer and winter mean temperatures and precipitation

#Now, using files based MODIS Land Surface Temperature/Emissivity data (Monthly L3 Global 0.05Deg CMG V006) from 2022 we analyze the suitable areas in the present
#Of course it is important to note that the weather data of one year is not as valid since viticulture depens on many climate cariables and depends on long-term climate and not just the weather in one year
#So this map of suitable area should only be seen as a proxy for a hypothetical climate that can be represented by the year 2022
#Considering the latest IPCC reports this seems to be an adequate hypothesis. 2022 was a year with very high temperatures, even compared to the last few years
#Because winter temperature and precipitation only had minor effects on the area limitation (except for Spain, even though that might be different soon) and a lack of data from 2022 only mean monthly temperature of the growing season will be considered in the next steps
#Again this implies a less reliable prediction, this model should only be viewed as an indicator rather than the actual suitability
#Since the procedure is the same as in the data processing for the baseline climate, the functions can be used accordingly
tavglist22 <- intersect(list.files(pattern="2022"),list.files(pattern="hdf"))
tavglist22 #shows the list
importtavg22 <- lapply(tavglist22,raster)
tavgmonthly22 <- stack(importtavg22)
tavgmonthly22 <- crop(tavgmonthly22,Europe)

#Because the MODIS data is not displayed in Celsius, first they have to be calibrated
#According to the User Guide, the values have to be multiplied with the factor 0.02
tavgmonthly22 <- tavgmonthly22*0.02
#Then the following calculation converts the data from Kelvin into Celsius
tavgmonthly22 <- tavgmonthly22-273.15

#From this a subset of April until October was assigned as tavg summer 22
tavgsum22 <- tavgmonthly22[[4:10]]
tavgsum22
tavgsum
#Merging into a single Raster Layer
tsum22 <- stackApply(tavgsum22,indices=c(1),fun=mean)
tsum22

#Visualization
tsum22gg <- (ggplot() 
             + annotation_map(map_data("world"),fill="gray90")
             + theme_minimal()
             + geom_raster(tsum22,mapping=aes(x=x,y=y,fill=index_1)) 
             + ggtitle("Growing Season Temperature",subtitle="2022")
             + scale_fill_viridis(limits=c(-10,30),option="inferno",alpha=1,direction=1,na.value=NA) 
             + coord_fixed() 
             + theme(plot.title=element_text(hjust=0.5),plot.subtitle=element_text(hjust=0.5)) 
             + theme(legend.position="bottom") 
             + theme(legend.title=element_blank()) 
             + annotation_map(map_data("world"),fill=NA,colour="gray20",size=0.3)
             + ylab ("latitude") + xlab ("longitude"))
tsum22gg
tsumgg+tsum22gg + plot_layout(guides = "collect") & theme(legend.position="bottom") 

#Rounding of values to one digit
rangesum22 <- round(tsum22,digits=1)
#Deletion of values for area no suitable (based on summer mean temperature)
rangesum22[!(rangesum22 %in% rangetsum)] <- NA
rangesum22
#With another ggplot we can see the areas in which the summer temperatures will probably allow viticulture
rangesum22gg <- (ggplot() 
                 + annotation_map(map_data("world"),fill="gray90")
                 + theme_minimal()
                 + geom_raster(rangesum22,mapping=aes(x=x,y=y,fill=layer)) 
                 + ggtitle("Suitability for Viticulture",subtitle="2022")
                 + scale_fill_viridis(limits=c(13,21),option="inferno",alpha=1,direction=1,na.value=NA) 
                 + coord_fixed() 
                 + theme(plot.title=element_text(hjust=0.5),plot.subtitle=element_text(hjust=0.5)) 
                 + theme(legend.position="bottom") 
                 + theme(legend.title=element_blank()) 
                 + annotation_map(map_data("world"),fill=NA,colour="gray20",size=0.3)
                 + ylab ("latitude") + xlab ("longitude"))
rangesum22gg
rangesumgg+rangesum22gg + plot_layout(guides = "collect") & theme(legend.position="bottom") 
#Simplifying data to categorize suitable/non-suitable as done before
ranges22 <- rangesum22
ranges22[(ranges22 %in% rangetsum)] <- 1
ranges22
ranges22gg <- (ggplot() 
               + annotation_map(map_data("world"),fill="gray90")
               + theme_minimal()
               + geom_raster(ranges22,mapping=aes(x=x,y=y,fill=layer)) 
               + ggtitle("Suitability for Viticulture",subtitle="2022")
               + scale_fill_gradient(low="dodgerblue",na.value=NA) 
               + coord_fixed() 
               + theme(legend.position="none") 
               + theme(plot.title=element_text(hjust=0.5),plot.subtitle=element_text(hjust=0.5)) 
               + annotation_map(map_data("world"),fill=NA,colour="gray20",size=0.3)
               + ylab ("latitude") + xlab ("longitude"))
ranges22gg

#Now it is possible to compare the areas suitable for viticulture (based on summer mean temperatures) between the baseline climate (1970-2000) and the hypothetical 2022 climate
ranges22gg+ranges00gg #Already a very extreme difference can be observed


#Because the two RasterLayers have different resolutions they have to be aligned
#This can be done as follows
res(ranges00)
res(ranges22)
#The resolution of both RasterLayers will be increased (to avoid loss of information as much as possible)
#This is achieved by creating a dummy template raster with a resolution of 0.01
rtemplate00 <- raster(extent(ranges00),resolution=0.01,crs=crs(ranges00))
rtemplate22 <- raster(extent(ranges22),resolution=0.01,crs=crs(ranges22))
#The two RasterLayers with the different resolutions can then be resampled with the paramters of the templates that only differ in the resolution
range00 <- resample(ranges00,rtemplate00)
range22 <- resample(ranges22,rtemplate22)
#To confirm that the change of resolution did not significantly affect the output, ggplots were created and compared with the "original" ones
range00gg <- (ggplot() 
              + annotation_map(map_data("world"),fill="gray90")
              + theme_minimal()
              + geom_raster(range00,mapping=aes(x=x,y=y,fill=layer))  
              + ggtitle("Suitability for Viticulture",subtitle="1970-2022 0.01")
              + scale_fill_gradient(low="dodgerblue",na.value=NA) 
              + coord_fixed() 
              + theme(legend.position="none") 
              + theme(plot.title=element_text(hjust=0.5),plot.subtitle=element_text(hjust=0.5)) 
              + annotation_map(map_data("world"),fill=NA,colour="gray20",size=0.3)
              + ylab ("latitude") + xlab ("longitude"))
range22gg <- (ggplot() 
              + annotation_map(map_data("world"),fill="gray90")
              + theme_minimal()
              + geom_raster(range22,mapping=aes(x=x,y=y,fill=layer))  
              + ggtitle("Suitability for Viticulture",subtitle="2022 0.01")
              + scale_fill_gradient(low="dodgerblue",na.value=NA) 
              + coord_fixed() + theme(legend.position="none") 
              + theme(plot.title=element_text(hjust=0.5),plot.subtitle=element_text(hjust=0.5)) 
              + annotation_map(map_data("world"),fill=NA,colour="gray20",size=0.3)
              + ylab ("latitude") + xlab ("longitude"))
(ranges00gg+ranges22gg)/(range00gg+range22gg)
#There are only very minor changes that considering the uncertainties regarding the parameters and data availability are not significant

#To allow a differentiation between the different values in the next step, all values of the 1977-2000 model will be changed from 1 to -1
#That way, it is possible to highlight areas that have become suitable and those that have lost their suitability separately
range00f <- range00
range00f[(range00f <= 2)] <- 2

#Now the two time points 1970-2000 and 2022 can be compared
sr <- stack(range22,range00f) #stacked as stack range
r <- stackApply(sr,indices=c(1),fun=sum) #merged as range
r[r == 0] <- NA     #In this sum, the ocean was assignes the value 0, which before plotting should be changed
r[r == 2] <- 4        #This and the next few steps are a fairly complicated (it was just the first way I could think of) to change the order from area gain, loss and retained to the more logical area gain, retained, loss
r[r == 3] <- 2
r[r == 4] <- 3
rgg <- (ggplot() 
        + annotation_map(map_data("world"),fill="gray90")
        + theme_minimal()
        + geom_raster(r,mapping=aes(x=x,y=y,fill=index_1)) 
        + ggtitle("Suitability for Viticulture",subtitle="Changes")
        + scale_fill_gradient(low="palegreen",high="red4",na.value=NA)
        + coord_fixed() 
        + theme(plot.title=element_text(hjust=0.5),plot.subtitle=element_text(hjust=0.5)) 
        + theme(legend.position="none") 
        + annotation_map(map_data("world"),fill=NA,colour="gray20",size=0.3)
        + ylab ("latitude") + xlab ("longitude"))
rgg  #Visualization of change of area suitability as ggplot

#To compare the area lost, gained and retained it is now an option to create a barplot visualizing the changes
#First the frequency of each value is taken from the Raster and assigned to d
d <- (freq(r))
#Now, using this data and the corresponding categories, a data frame can be created
Area <- factor(c("Area Retained","Area Retained","Area Lost","Area Gained"))
Time <- factor(c("1970-2000","2022","1970-2000","2022"),levels=c("1970-2000","2022"))
Frequency <- c(d[2,2],d[2,2],d[3,2],d[1,2])
d3 <- data.frame(x=Time,y=Frequency,Group=Area)
d3

#Lastly, the ggplot function allows to create a graph showing the areas that were categorized as suitable
t <- (ggplot(d3,aes(x=Time,y=Frequency))
      + theme_minimal()
      + geom_col(aes(fill=Group))
      + ggtitle("Change of Suitability for Viticulture")
      + scale_fill_manual(values=c("palegreen","red4","sienna1"))
      + theme(plot.title=element_text(hjust=0.5)))
t
#In Conclusion, it is apparent that according to this simplified model much of the area that was suitable for growing wine in the recent past may very soon (or already today) not be ideal any more
#The overall suitable area in Europe may also be decreasing and due to a high population density and unsuitable additional factors (Northern Germany being very flat for example), the potential for the emergence of new wine regions is limited
#While this model shows quite drastic differences between 1970-2000 and 2022, this has to be viewed with caution
#One year (2022) doesn't necessarily represent the current or future climate adequately
#Further, this model relies on very few parameters, the suitability for growing wine depends on a lot of additional factors, for example:
#Mean growing season temperatures may be a proxy but strong fluctuations within this time also have a strong effect
#In general this project seems to highlight the high sensitivity of viticulture in Europe
#Viticulture is a significant contributor to economic wealth and employment in some countries and the decrease might have relatively strong effects on tourism as well
#However, since wine is still a "luxury" product its relevance may also stem from its warning power. Wine may be one of the most sensitive agricultural products but with increasing temperatures all types of crops will be severely affected.
