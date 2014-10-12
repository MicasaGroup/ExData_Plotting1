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

## create a new column concatenating date & time
dat$DateTimeCol <- paste(dat$Date, dat$Time, sep=" ")
## convert to datetime
dat$DateTimeCol <- as.POSIXct(dat$DateTimeCol, format = "%d/%m/%Y %H:%M:%S")

## open png device
png(filename="plot4.png")

par(mfcol=c(2,2))

## draw Graph 1
plot(dat$DateTimeCol, dat$Global_active_power, type="l",
     ylab=paste("Global Active Power (kilowatts)"), xlab=paste(" "))

## draw Graph 2
plot(dat$DateTimeCol, dat$Sub_metering_1, type = "l",
     ylab=paste("Energy sub metering"), xlab=paste(" "))
lines(dat$DateTimeCol, dat$Sub_metering_2, col="red")
lines(dat$DateTimeCol, dat$Sub_metering_3, col="blue")
legend("topright", lwd=c(2.5,2.5), 
       col=c("black","red","blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))

# draw Graph 3
plot(dat$DateTimeCol, dat$Voltage, type = "l",
     ylab=paste("Voltage"), xlab=paste("datetime"))

# draw Graph 4
plot(dat$DateTimeCol, dat$Global_reactive_power, type = "l",
     ylab=paste("Global_reactive_power"), xlab=paste("datetime"))

## close the device
dev.off()
