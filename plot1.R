## Plot1: Create Histogram  

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

## Create a histogram of the Global Active Power variable, colored red
hist(subsetdata$Global_active_power, main = "Global Active Power", col = "red", xlab = 
       "Global Active Power (kilowatts)")

## Create PNG file
dev.copy(png,"plot1.png")
dev.off()