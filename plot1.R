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

##Opens png device named plot1##

png("C:/Users/Lauren/Dropbox/prog/ExploreGraphs/plot1.png") 

##Construct histogram inside png device and close device##

hist(hhPower$Global_active_power, main = "Global Active Power",
     xlab = "Global Active Power(kilowatts)", col = "red")  ##creates plot within device
dev.off()  

message("Plot now saved as plot1.png")
