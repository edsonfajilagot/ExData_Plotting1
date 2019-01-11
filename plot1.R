
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
with(data, hist(Global_active_power, 
                 main="Global Active Power", 
                 col="red",
                 xlab="Global Active Power (kilowatts)"))

# export plot1 to file
dev.copy(png, file="plot1.png", width=480, height=480)
dev.off()

