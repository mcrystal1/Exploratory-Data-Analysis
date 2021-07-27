library(dplyr)
library(tidyr)

directory <- "./Graph"
file_name <- "exdata_data_household_power_consumption.zip"
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
dir <- paste(directory,"/",file_name,sep = '')

if(!file.exists(directory)){
        dir.create(directory)
        download.file(url, destfile = dir)
}

unzip(zipfile = dir)

df<-read.table("household_power_consumption.txt",header = TRUE, sep = ";")
df<-as.tbl(df)
head(df)

df<-df[df$Date %in% c("1/2/2007","2/2/2007"),]
time <-strptime(paste(df$Date, df$Time, sep=" "),"%d/%m/%Y %H:%M:%S")
df<-cbind(df,time)

df$Global_active_power<-as.numeric(df$Global_active_power)

png(file = "Plot4.png", width = 480,height = 480,units = "px")

par(mfrow = c(2,2))
plot(df$time,df$Global_active_power,type = "l",col = "black",xlab = "",ylab = "Global Active Power")
plot(df$time,df$Voltage,type = "l",col = "black",xlab = "",ylab = "Voltage")
plot(df$time,df$Sub_metering_1,type = "l",ylab = "Energy sub metering", col='black',xlab = "")
lines(df$time,df$Sub_metering_2,col='red')
lines(df$time,df$Sub_metering_3,col='blue')
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col = c('black','red','blue'),lty = "solid",
       cex = 0.5)
plot(df$time,df$Global_reactive_power,xlab = "datetime",ylab = 'Global_reactive_power',type = "l",col = "black")
