##Create file for data and download zipfile from url##

setwd("C:/Users/Lauren/Dropbox/prog")
if(!file.exists("ExploreGraphs")){dir.create("ExploreGraphs")}
fileUrl <- ("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip")
zipFile <- download.file(fileUrl, destfile = "ExploreGraphs/hhPower.zip")

##Unzip data in working directory##

setwd("C:/Users/Lauren/Dropbox/prog/ExploreGraphs")
unzip("hhPower.zip")

##Read in data to R##

hhPower <- read.table("household_power_consumption.txt", header = TRUE, stringsAsFactors = FALSE, 
                      na.strings = "?", sep = ";")

##Subset data to Feb. 1 and Feb. 2 of 2007##
                      
hhPower <- hhPower[which(hhPower$Date == "1/2/2007" | hhPower$Date == "2/2/2007"),]

##Create column of date and time data, convert from character to Date class##

DateTime <- paste(hhPower$Date, hhPower$Time, sep = " ")
hhPower <- cbind(DateTime, hhPower)
hhPower$DateTime <- strptime(hhPower$DateTime, format = "%e/%m/%Y %H:%M:%S")

##Subset data to Datetime and Global_active_power columns for cleaner graphing##

dataplot2 <- hhPower[,c(1,4)]     

##Open window graphing device and create line plot##
windows()                   
plot(dataplot2$DateTime, dataplot2$Global_active_power, type = "l", 
     ylab = "Global Active Power(kilowatts)", xlab = " ")   

savePlot("plot2.png", type = "jpg")  #save graph
dev.off()

message("plot2.png is now saved in your working directory!")

