library(dplyr)
library(tidyr)
library(ggplot2)

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

png(file = "Plot1.png", width = 480,height = 480,units = "px")

hist(df$Global_active_power,main = "Global Active Power",col = "red",xlab = "Global Active Power (kilowats)")
