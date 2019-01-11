
# download data
if (!file.exists("hpc.zip")){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="hpc.zip")
  unzip("hpc.zip", exdir=".")
}

# read data
data_all <- read.table("household_power_consumption.txt", header=TRUE, na.strings = "?", sep=";")
data <- data_all[(data_all$Date=="1/2/2007" | data_all$Date=="2/2/2007"),]

# format date and time
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
dateTime <- paste(data$Date, data$Time)
data$DateTime <- as.POSIXct(dateTime)

# plot data
par(mfrow=c(2,2), mar=c(4,4,2,1))
with(data,{
  plot(Global_active_power~DateTime, type = "l", xlab="", ylab="Global Active Power (kilowatts)")
  plot(Voltage~DateTime, type="l", xlab="datetime", ylab = "Voltage")
  plot(Sub_metering_1~DateTime, type = "l", xlab="", ylab="Energy sub metering")
  lines(Sub_metering_2~DateTime, type = "l", col="red")
  lines(Sub_metering_3~DateTime, type = "l", col="blue")
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=1, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=0.4)
  plot(Global_reactive_power~DateTime, type = "l", xlab="datetime")
})


# export plot1 to file
dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()






