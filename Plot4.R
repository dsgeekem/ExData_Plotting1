rm(list=ls())
#data_path <- file.path("C:/Users/emiu/Documents/Data Science/Exploratory Data Analysis")
dat_path <-file.path("./data")

## import power data
pwr_data<- read.csv(file.path(data_path,"household_power_consumption.txt"), header = T, sep = ';', na.strings = "?", nrows = 2075259)

pwr_data$Date <- as.Date(pwr_data$Date, format = "%d/%m/%Y")

## Get the first 2 months of 2007 data
Feb_data <- subset(pwr_data, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(pwr_data)

## Convert dates 
datetime <- paste(as.Date(Feb_data$Date), Feb_data$Time)
Feb_data$Datetime <- as.POSIXct(datetime)

## Plot 4 - 4 different plots
par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))
with(Feb_data, {
  #type l = line, otherwise it's scatter plot
  plot(Global_active_power ~ Datetime, type = "l", xlab = "",
       ylab = "Global Active Power" )
  
  plot(Voltage ~ Datetime, type = "l", xlab = "datetime", ylab = "Voltage")
  
  plot(Sub_metering_1 ~ Datetime, type = "l", xlab = "", ylab = "Energy sub metering",)
  lines(Sub_metering_2 ~ Datetime, col = 'Red')
  lines(Sub_metering_3 ~ Datetime, col = 'Blue')
  legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, 
         bty = "n",
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  plot(Global_reactive_power ~ Datetime, type = "l", 
       xlab = "datetime", ylab = "Global_reactive_power")
  
})

## Copy plot to a PNG file
dev.copy(png, file = "Plot4.png")

## Don't forget to close the PNG device! Otherwise the file will not appear.
dev.off()
