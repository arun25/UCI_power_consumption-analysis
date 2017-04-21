#electric power consumption
#https://github.com/TomLous/coursera-exploratory-data-analysis-course-project-1/blob/master/README.md

#mydata = read.table("household_power_consumption.txt") -- very slow
library(data.table)
system.time(fread(file = "household_power_consumption.txt"))
mydata <- fread(file = "household_power_consumption.txt")
head(mydata)
class(mydata$Global_active_power)
nrow(mydata)
colnames(mydata)
library(dplyr)
mydata_subset <- filter(mydata,Date == "1/2/2007" | Date == "2/2/2007")
summary(mydata)
data <- tbl_df(mydata_subset)
head(data)
?strptime
?as.Date
mydata_subset$Date <- as.Date(mydata_subset$Date,"%m/%d/%Y") 

data[1]
head(data$Date)

#Global Active Power VS frequency
png(filename = 'plot1.png',width = 480,height = 480)
hist(as.numeric(mydata_subset$Global_active_power),
     col = "red",
     xlab = "Global Active POwer (Kilowatts)",
     ylab = "Frequncy",
     main = "Global Active Power")
dev.off()

par(mfrow = c(1,1))

#Date Vs Global Active Power

png(filename = 'plot2.png',width = 480,height = 480)
?plot
datetime <- strptime(paste(mydata_subset$Date, mydata_subset$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
plot(datetime,mydata_subset$Global_active_power,type = 'l',xlab = '',ylab = "Global Active POwer (Kilowatts)")
dev.off()
plot(datetime,mydata_subset$Global_active_power)
head(datetime,n=11)


#Date Vs Energy submetering 

datetime <- strptime(paste(mydata_subset$Date, mydata_subset$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
mydata_subset$Sub_metering_1 <- as.numeric(mydata_subset$Sub_metering_1) 
mydata_subset$Sub_metering_2 <- as.numeric(mydata_subset$Sub_metering_2)
mydata_subset$Sub_metering_3 <- as.numeric(mydata_subset$Sub_metering_3)
png(filename = 'plot3.png',width = 480,height = 480)
plot(datetime,mydata_subset$Sub_metering_1,type = 'l', ylab="Energy Submetering", xlab="")
lines(datetime,mydata_subset$Sub_metering_2,col = 'red')
lines(datetime,mydata_subset$Sub_metering_3,col = 'blue')
legend("topright",c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))
dev.off()


#multiple plots

png(filename = 'plot4.png',width = 480,height = 480)
par(mfrow = c(2,2))
datetime <- strptime(paste(mydata_subset$Date, mydata_subset$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
plot(datetime,mydata_subset$Global_active_power,type = 'l',xlab = '',ylab = "Global Active POwer (Kilowatts)")


plot(datetime,as.numeric(mydata_subset$Voltage),type = 'l',xlab = "datetime",ylab = "Voltage")


mydata_subset$Sub_metering_1 <- as.numeric(mydata_subset$Sub_metering_1) 
mydata_subset$Sub_metering_2 <- as.numeric(mydata_subset$Sub_metering_2)
mydata_subset$Sub_metering_3 <- as.numeric(mydata_subset$Sub_metering_3)
plot(datetime,mydata_subset$Sub_metering_1,type = 'l', ylab="Energy Submetering", xlab="")
lines(datetime,mydata_subset$Sub_metering_2,col = 'red')
lines(datetime,mydata_subset$Sub_metering_3,col = 'blue')
legend("topright",c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))


plot(datetime,as.numeric(mydata_subset$Global_reactive_power),type = 'l',xlab = "datetime",ylab = "Global_reactive_power")

dev.off()
