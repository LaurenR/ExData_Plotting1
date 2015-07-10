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

##Subset data to only columns for the graph##

dataplot3 <- hhPower[,c(1,8:10)]

##Open windows graphical device and plot initial data in black, setting up labels##

windows()
plot(dataplot3$DateTime, dataplot3$Sub_metering_1, type="l", xlab = " ", ylab="Energy Sub Metering", col = "black")

#Add additional lines to plot, in red and black respectively##

lines(dataplot3$DateTime, dataplot3$Sub_metering_2, col = "red")
lines(dataplot3$DateTime, dataplot3$Sub_metering_3, col = "blue")
legend("topright", legend = names(dataplot3[2:4]), lwd = 1, col = c("black", "red", "blue"))

savePlot("plot3.png", type = "png")
dev.off()
message("plot3.png is now saved in your working directory!")
