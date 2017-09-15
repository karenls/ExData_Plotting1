## Coursera: Exploratory Data Analysis
## Karen Saul
## Plot One
## Histogram of the frequency of power usage

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

################
## Make and write plot to png file

png(file = "plot1.png")

hist(powerUsage$Global_active_power,
     freq = TRUE,
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")

dev.off()
