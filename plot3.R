#This script creates the plot of Global Active Power between 2007-02-01 and 2007-02-02 as a function of day of the week


#read data
data <- read.csv2("household_power_consumption.txt", sep=";",header=TRUE)

# convert the time to the "time" class in R
dates=paste(data$Date, data$Time)
data$Time <- strptime(dates, "%d/%m/%Y %H:%M:%S")

# convert the date the the "Date" class in R
data$Date <- as.Date(data$Date, "%d/%m/%Y" )

#Eliminate rows with missing data
good <- (!(data$Sub_metering_1=="?" | data$Sub_metering_2=="?" | data$Sub_metering_3=="?")   )
data <- data[good,]

#Subset to date from dates 2007-02-01 and 2007-02-02

date1 <- as.Date("2007-02-01")
date2 <- as.Date("2007-02-02")

new_data=subset(data, data$Date>= date1 & data$Date <= date2 )


new_data$Sub_metering_1<- as.numeric(as.character(new_data$Sub_metering_1))
new_data$Sub_metering_2<- as.numeric(as.character(new_data$Sub_metering_2))
new_data$Sub_metering_3<- as.numeric(as.character(new_data$Sub_metering_3))
new_data$Global_active_power <- as.numeric(as.character(new_data$Global_active_power))


# Transform the time during the week in a numeric factor from 0 to 7
time=as.numeric(format(new_data$Time, "%u"))+(as.numeric(format(new_data$Time, "%H"))+as.numeric(format(new_data$Time, "%M"))/60.0)/24.0


#Create Plot 3

png(filename="plot3.png", width = 480, height = 480, units = "px")

par(mar=c(8,5,4,2))

plot(time, new_data$Sub_metering_1, ylab="Energy sub metering", type='n', xlab='', xaxt='n')
lines(time, new_data$Sub_metering_1, col="black")
lines(time, new_data$Sub_metering_2, col="red")
lines(time, new_data$Sub_metering_3, col="blue")
axis(1,labels = c("Thu","Fri","Sat"), at=c(4,5,6))

legend("topright", legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), lty=c(1,1,1), col=c("black", "red","blue"))

dev.off()

