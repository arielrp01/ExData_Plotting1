# Load required dependencies and initial file prep

library(dplyr)
filename <- "exdata_data_household_power_consumption.zip"

# Checking for downloaded archive

if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, filename, method="curl")
}  

# Checking for unzipped folder

if (!file.exists("household_power_consumption.txt")) { 
  unzip(filename) 
}

# Create data frames

household_power_consumption <- read.table("household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")
data <- household_power_consumption

# Filter selected dates

new_data <- household_power_consumption %>% filter(Date %in% c("1/2/2007","2/2/2007"))

# Convert Data and Time

new_data$DateTime <- strptime(paste(new_data$Date, new_data$Time), "%d/%m/%Y %H:%M:%S")

# Convert Global_active_power to numeric

globalActivePower <- as.numeric(new_data$Global_active_power)

# Convert Sub_metering values to numeric

sm1 <- as.numeric(new_data$Sub_metering_1)
sm2 <- as.numeric(new_data$Sub_metering_2)
sm3 <- as.numeric(new_data$Sub_metering_3)

# Set image format and sizing

png("plot3.png", width=480, height=480)

# Create graph

plot(new_data$DateTime, sm1, type="l", ylab="Energy sub metering", xlab="")
lines(new_data$DateTime, sm2, type="l", col="red")
lines(new_data$DateTime, sm3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))

# Close graphics device

dev.off()