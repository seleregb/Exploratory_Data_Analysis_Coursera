## Load full dataset 

data <- read.csv("./data/household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                 nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')

## Convert the date column
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

## Subset the data from the specified dates
data.sub <- subset(data, data[[1]] >= "2007-02-01" & data[[1]] <= "2007-02-02") 

## Converting dates and the time to acceptable format for analysis
datetime <- paste(as.Date(data.sub$Date), data.sub$Time)
data.sub$Datetime <- as.POSIXct(datetime)


## Plot 1
hist(data.sub$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

## Saving plot to file
dev.copy(png, file="./data/plot1.png", height=480, width=480)
dev.off()
