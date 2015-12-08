epc <- read.table("household_power_consumption.txt", header = T, sep = ";", stringsAsFactors = F)

##change to numeric

epc$Global_active_power <- as.numeric(epc$Global_active_power)    
epc$Global_reactive_power <- as.numeric(epc$Global_reactive_power)
epc$Voltage <- as.numeric(epc$Voltage)
epc$Global_intensity <- as.numeric(epc$Global_intensity)
epc$Sub_metering_1 <- as.numeric(epc$Sub_metering_1)
epc$Sub_metering_2 <- as.numeric(epc$Sub_metering_2)
epc$Sub_metering_3 <- as.numeric(epc$Sub_metering_3)

##dates and times

epc$Date <- as.Date(epc$Date, "%d/%m/%Y") ## probably needed only for the subsetting    
library(chron)
epc$time2 <- chron(times = epc$Time)
epc$Time <- epc$time2

##subset

small_epc <- subset(epc, (Date == "2007-02-01" | Date == "2007-02-02" ))

small_epc$Date_Time <- paste(small_epc$Date, small_epc$Time)
small_epc$Date_Time <- strptime(small_epc$Date_Time, format = "%Y-%m-%d %H:%M:%S")


##The Second:
Sys.setlocale("LC_TIME", "English")
with(small_epc, plot(Date_Time, Global_active_power, type = "l", ylab = "Global Active Power (Kilowatts)"))

dev.copy(png, "plot2.png")
dev.off()