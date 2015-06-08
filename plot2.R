#This script creates the plot of Global Active Power between 2007-02-01 and 2007-02-02 as a function of day of the week


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


new_data$Global_active_power <- as.numeric(as.character(new_data$Global_active_power))

# Transform the time during the week in a numeric factor from 0 to 7
time=as.numeric(format(new_data$Time, "%u"))+(as.numeric(format(new_data$Time, "%H"))+as.numeric(format(new_data$Time, "%M"))/60.0)/24.0


#Create Plot 2

png(filename="plot2.png", width = 480, height = 480, units = "px")

par(mar=c(8,5,4,2))

plot(time, new_data$Global_active_power, ylab="Global Active Power (killowats)", type='n', xlab='', xaxt='n')
lines(time, new_data$Global_active_power)
axis(1,labels = c("Thu","Fri","Sat"), at=c(4,5,6))

dev.off()

