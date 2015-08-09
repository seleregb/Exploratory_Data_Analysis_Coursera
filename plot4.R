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

## Plot 4

# Setting the plot canvas
par(mfrow = c(2,2), mar = c(5,4,1,4), oma= c(1,0,1,0))

# Drawing the first plot on the canvas
plot(data.sub$Global_active_power ~ data.sub$Datetime, 
     ylab = "Global Active Power (Kilowatts)", xlab = "", type = "l")

# Drawing the second plot on the canvas
plot(data.sub$Voltage~data.sub$Datetime, ylab = "Voltage", xlab= "datetime", type = "l")

# Drawing the third plot on the canvas
with(data.sub,{
  plot(data.sub$Sub_metering_1 ~ data.sub$Datetime, ylab = "Energy sub metering", 
       col = "black", xlab = "", type = "l")
  lines(data.sub$Sub_metering_2 ~ data.sub$Datetime, col = "red")
  lines(data.sub$Sub_metering_3 ~ data.sub$Datetime, col = "blue")
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty = "O",
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Drawing the fourth plot on the canvas
plot(data.sub$Global_reactive_power~data.sub$Datetime, ylab = "Global_reactive_power", xlab= "datetime", type = "l")

## Saving  plot to file
dev.copy(png, file="./data/plot4.png", height=480, width=480)
dev.off()
