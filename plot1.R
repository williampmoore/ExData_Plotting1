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

#######


png("./plot1.png")
hist(splitData$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()