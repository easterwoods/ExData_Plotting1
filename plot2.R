## Plot2: Create Plot of Global Active Power over Time  

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

## Create plot of Global Active Power over dateTime
plot(subsetdata$dateTime, subsetdata$Global_active_power, pch = ".", type = "o", ann = FALSE)
title(ylab = "Global Active Power (kilowatts)")
      
## Create PNG file      
dev.copy(png,"plot2.png")
dev.off()