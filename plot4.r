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

##Open window graphics device with a 2 x 2 window, graphs are added row-wise##
windows()
par(mfrow = c(2,2)) 

##Add each of 4 plots to device and save##

plot(hhPower$DateTime, hhPower$Global_active_power, type = "l", 
     ylab = "Global Active Power", xlab = " ")

plot(hhPower$DateTime, hhPower$Voltage, type = "l", ylab = "Voltage",
     xlab = "datetime")

plot(hhPower$DateTime, hhPower$Sub_metering_1, type="l", xlab = " ", ylab="Energy Sub Metering", col = "black")
#add lines
      lines(hhPower$DateTime, hhPower$Sub_metering_2, col = "red")
      lines(hhPower$DateTime, hhPower$Sub_metering_3, col = "blue")
      legend("topright", legend = names(hhPower[8:10]), lwd = 1, 
             col = c("black", "red", "blue"), bty = "n")
plot(hhPower$DateTime, hhPower$Global_reactive_power, type = "l",
     ylab = "Global_reactive_power", xlab = "datetime")

savePlot("plot4.png", type = "png")  #save graph
dev.off()
message("plot4.png is now saved to your working directory!")


