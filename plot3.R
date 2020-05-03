# Script for plot 3
# Gabriel Espinosa

############################
# Begin of loading the data
############################

#Download the file, extract the file from zip and read into R.
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url,destfile = "data.zip",method = "curl")
fileName <- unzip("data.zip", list = TRUE)[1,1]
unzip("data.zip",fileName)

# My device doesn't have too much memory, so I only read the important dates.
dNames <- read.table(fileName, header = TRUE, sep = ";",
                     nrows=1)
data <- read.table(fileName, sep = ";", na.strings = '?',
                   col.names = names(dNames),
                   colClasses = c("character", "character", "numeric",
                                  "numeric", "numeric", "numeric",
                                  "numeric", "numeric", "numeric"),
                   skip = 66637, nrow = (69517-66637))
# str(data)
data$Date <- with(data,as.Date(Date,"%d/%m/%Y"))
data$Time <- paste(data$Date,data$Time)
data$Time <- with(data,strptime(Time,"%Y-%m-%d %H:%M:%S"))

############################
# End of loading the data
############################

############################
# Begin of plotting
############################

png("plot3.png", width = 480, height = 480)
plot(data$Time,data$Sub_metering_1,type = "l",
     ylab = "Energy sub metering", xlab = "")
lines(data$Time,data$Sub_metering_2, col = "red")
lines(data$Time,data$Sub_metering_3, col = "blue")
legend("topright",names(data)[7:9], lwd = 1, col= c("black","red","blue"))
dev.off()

############################
# End of plotting
############################