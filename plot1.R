#This script creates the histogram of Global Active Power between 2007-02-01 and 2007-02-02


#read data
data <- read.csv2("household_power_consumption.txt", sep=";",header=TRUE)

# convert the time to the "time" class in R
dates=paste(data$Date, data$Time)
data$Time <- strptime(dates, "%d/%m/%Y %H:%M:%S")

# convert the date the the "Date" class in R
data$Date <- as.Date(data$Date, "%d/%m/%Y" )

#Eliminate rows with missing data
good <- (!(data$Global_active_power=="?"))
data <- data[good,]

#Subset to date from dates 2007-02-01 and 2007-02-02

date1 <- as.Date("2007-02-01")
date2 <- as.Date("2007-02-02")

new_data=subset(data, data$Date>= date1 & data$Date <= date2 )

#Create Plot 1

new_data$Global_active_power <- as.numeric(as.character(new_data$Global_active_power))
par(mar=c(5,5,4,2))

png(filename="plot1.png", width = 480, height = 480, units = "px")
hist(new_data$Global_active_power, xlab="Global Active Power (killowats)", col="red", main ="Global Active Power")
dev.off()

