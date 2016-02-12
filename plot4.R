## Plot4: Create 4 Different Plots 

## Read in data from working directory
## Data is separated by semicolon, the first row is the column names, and values of "?" are NA. 
dataset <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, na.strings=c("?","NA"))
library(lubridate)
library(dplyr)

## Convert date and times to POSIXct using lubridate and mutate.
dataset <- mutate(dataset, Date = dmy(dataset$Date))
dataset <- mutate(dataset, Time = hms(dataset$Time))

## Create variables for dates that we want to subset by.
date1 <- as.Date("2007-02-01")
date2 <- as.Date("2007-02-02")

## Subset data for just the days we want.
subsetdata <- subset(dataset, as.Date(Date) == date1 | as.Date(Date) == date2)

## Create new column for combined date and time
subsetdata <- mutate(subsetdata, dateTime = Date + Time)

## Create structure for multiple plots
par(mfcol = c(2,2), mar = c(4, 4, 1, 1), oma = c(0,0,0,0))

## Plot 1 - Global Active power over Time
plot(subsetdata$dateTime, subsetdata$Global_active_power, pch = ".", type = "o", ann = FALSE, cex.axis = 0.5)
title(ylab = "Global Active Power (kilowatts)", cex.lab = 0.5)

## Plot 2 - Submetering 1, 2, and 3 over Time (with legend)
plot(subsetdata$dateTime, subsetdata$Sub_metering_1, pch = ".", type = "o", ann = FALSE, cex.axis = 0.5)
lines(subsetdata$dateTime, subsetdata$Sub_metering_2, pch = ".", type = "o", col = "red")
lines(subsetdata$dateTime, subsetdata$Sub_metering_3, pch = ".", type = "o", col = "blue")
title(ylab = "Energy sub metering", cex.lab = 0.5)
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty = c(1,1,1), lwd = c(2,2,2), cex = 0.5)

## Plot 3 - Voltage over Time
plot(subsetdata$dateTime, subsetdata$Voltage, pch = ".", type = "o", ann = FALSE, cex.axis = 0.5)
title(ylab = "Voltage", xlab = "datetime", cex.lab = 0.5)

## Plot 4 - Global Reactive Power over Time
plot(subsetdata$dateTime, subsetdata$Global_reactive_power, pch = ".", type = "o", ann = FALSE, cex.axis = 0.5)
title(ylab = "Global Reactive Power", xlab = "datetime", cex.lab = 0.5)

## Create PNG file
dev.copy(png,"plot4.png")
dev.off()
