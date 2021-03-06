## Coursera: Exploratory Data Analysis
## Karen Saul
## Plot Three
## Line plot of energy sub metering over time

library(lubridate)

################
## Download file

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipName <- "household_power_consumption.zip"

## Get file; curl used for Mac if url is https://
## Unzip file
if (!file.exists("household_power_consumption.txt")) {

    download.file(fileUrl, zipName, method = "curl")
    fileName <- unzip(zipName)

} else {

    fileName <- "household_power_consumption.txt"

}

################
## Read only data for Feb 1 - Feb 2, 2007
##   Used grep/egrep in Bash Terminal to get 1st matching line:
##   `grep -w -n -m 1 "1/2/2007" household_power_consumption.txt`
##   Count rows that match both dates:
##   `egrep -w -c "1/2/2007|2/2/2007" household_power_consumption.txt`
powerUsage <- read.table(fileName,
                         sep = ";",
                         na.strings = "?",
                         stringsAsFactors = FALSE,
                         skip = 66637,
                         nrows = 2880)

## Assign column names from file
names(powerUsage) <- read.table(fileName,
                                sep = ";",
                                stringsAsFactors = FALSE,
                                nrows = 1)

## Add datetime column from Date & Time and convert to posixt
powerUsage$Date_time <-dmy_hms(paste(powerUsage$Date, powerUsage$Time))

################
## Make and write plot to png file

png(file = "plot3.png")

plot(powerUsage$Date_time,
     powerUsage$Sub_metering_1,
     type = "l",
     ylab = "Energy sub metering",
     xlab = "")
lines(powerUsage$Date_time,
      powerUsage$Sub_metering_2,
      type = "l",
      col = "red")
lines(powerUsage$Date_time,
      powerUsage$Sub_metering_3,
      type = "l",
      col = "blue")
legend("topright",
       legend = names(powerUsage[7:9]),
       lty = 1,
       col=c("black", "red", "blue"))

dev.off()
