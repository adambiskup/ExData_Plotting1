## Author : Adam Biskup
## Declaration of imports
library(dplyr)

# Link to data file  : https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# Downloading dataset
zipUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipFile <- "household_power_consumption.zip"

if (!file.exists(zipFile)) {
    download.file(zipUrl, zipFile, mode = "wb") }

# unzipping zip file containing data if data directory doesn't already exist
dataPath <- "household_power_consumption.txt"
if (!file.exists(dataPath)) {
    unzip(zipFile)   }

datasetraw <- read.table( file.path( dataPath ) , sep=';' , header = TRUE ,  
                          na.strings = "?", skipNul = TRUE ,
                          stringsAsFactors=FALSE )

dataset <- datasetraw %>%  filter( Date == "1/2/2007" | Date == "2/2/2007" )  
dataset <- dataset[complete.cases(dataset), ]
dataset$DaTim <- strptime(paste(dataset$Date , dataset$Time),"%d/%m/%Y %H:%M:%S")


# Initialization of target device with size requirements
png(file="plot3.png", width = 480 , height = 480 )
# Plotting the plot
plot(dataset$DaTim , dataset$Sub_metering_1 ,type = "l" , col= "black" , 
     ylab = "Energy sub metering" , xlab=NA ) 
lines(dataset$DaTim , dataset$Sub_metering_2 ,type = "l" , col= "red"  ) 
lines(dataset$DaTim , dataset$Sub_metering_3 ,type = "l" , col= "blue" )
legend("topright", lty=1,
       col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
       )
# Saving file
dev.off()

