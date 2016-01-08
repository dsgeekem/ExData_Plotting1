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

## Plot 3 - Energy submetering
with(Feb_data, {
  plot(Sub_metering_1 ~ Datetime, type = "l", 
       ylab = "Global Active Power (kilowatts)", xlab = "")
  lines(Sub_metering_2 ~ Datetime, col = 'Red')
  lines(Sub_metering_3 ~ Datetime, col = 'Blue')
})
legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


## Copy plot to a PNG file
dev.copy(png, file = "Plot3.png")
## Don't forget to close the PNG device! Otherwise the file will not appear.
dev.off()
