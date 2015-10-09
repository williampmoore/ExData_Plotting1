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

png("./plot2.png")
plot(y = splitData$Global_active_power, x = splitData$timestamp, type = "l", ylab = "Global Active Power (kilowatts)", main = "")
dev.off()