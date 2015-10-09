## Set file Address and name
fileAddress <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
fileName <- "household_power_consumption.txt"

## Download, Unzip and open the data
tempFile <- tempfile()
download.file(fileAddress, tempFile)
data <- read.csv(unz(tempFile, "household_power_consumption.txt"), sep = ';', header = TRUE,
                 colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), na.strings=c("?"))

## Remove tempory file
unlink(tempFile)

## Select data for 2007/02/01 -> 2007/02/02
splitData <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007",]

## Convert time and date
splitData <- within(splitData, { timestamp=strptime(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S") })

#######

png("./plot4.png")
par(mfrow=c(2,2))
plot(y = splitData$Global_Active_Power, x = splitData$timestamp, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "", main = "")
plot(y = splitData$Voltage, x = splitData$timestamp, type = "l", ylab = "Volatege", xlab = "DateTime", main = "")
plot(y = splitData$Sub_metering_1, x = splitData$timestamp, type = "l", ylab = "Energy Sub Metering", main = "")
lines(y = splitData$Sub_metering_2, type = "l", col = "red")
lines(y = splitData$Sub_metering_3, type = "l", col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1, 1), lwd = c(2.5, 2.5), col = c("black", "red", "blue"))
plot(y = splitData$Global_reactive_power, x = splitData$timestamp, type = "l", ylab = "Global_reactive_power", xlab = "", main = "")
dev.off()