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

# Multiple graphs in a single plot; set image format and sizing

png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2)) 

# Plot 1, top-left

plot(new_data$DateTime, new_data$Global_active_power, type="l", xlab="", ylab="Global Active Power", cex=0.1)

# Plot 2, top-right

plot(new_data$DateTime, new_data$Voltage, type="l", xlab="datetime", ylab="Voltage")

# Plot 3, bottom-left

plot(new_data$DateTime, sm1, type="l", xlab="", ylab="Energy sub metering")
lines(new_data$DateTime, sm2, type="l", col="red")
lines(new_data$DateTime, sm3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n", lty=, lwd=1.5, col=c("black", "red", "blue"))

# Plot 4, bottom-right

plot(new_data$DateTime, new_data$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

# Close graphics device

dev.off()