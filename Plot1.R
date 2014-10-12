library(sqldf)

## download the file 
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipfile <- "exdata-data-household_power_consumption.zip"
download.file(fileUrl, zipfile, method="curl")

## unzip the zip file
unzip(zipfile)

## read only subset of the data based on date
dat <- read.csv.sql("household_power_consumption.txt", sql = "SELECT * from file 
                    WHERE Date IN ('1/2/2007', '2/2/2007') ", 
                    sep = ";", 
                    header = TRUE)

## convert any ? to NA
dat[dat=="?"] = NA

## open png device
png(filename="plot1.png")
## draw the histogram
hist(dat$Global_active_power, main=paste("Global Active Power"),
     xlab=paste("Global Active Power (kilowatts)"), col="red")
## close the device
dev.off()
