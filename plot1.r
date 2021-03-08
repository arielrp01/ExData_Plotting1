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

# Convert Global_active_power to numeric

globalActivePower <- as.numeric(new_data$Global_active_power)

# Set image format and sizing

png("plot1.png", width=480, height=480)

# Create histogram

hist(globalActivePower, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency")

# Close graphics device

dev.off()
