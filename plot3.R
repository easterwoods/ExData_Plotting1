## Plot3: Create Plot of Sub Metering 1, 2, and 3 over Time 

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

## Create plot of Sub metering 1 over dateTime
plot(subsetdata$dateTime, subsetdata$Sub_metering_1, pch = ".", type = "o", ann = FALSE)

## Add sub metering 2, sub metering 3, and y axis label 
lines(subsetdata$dateTime, subsetdata$Sub_metering_2, pch = ".", type = "o", col = "red")
lines(subsetdata$dateTime, subsetdata$Sub_metering_3, pch = ".", type = "o", col = "blue")
title(ylab = "Energy sub metering")

## Create legend
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty = c(1,1,1), lwd = c(2,2,2), cex = 0.5)

## Create PNG file      
dev.copy(png,"plot3.png")
dev.off()