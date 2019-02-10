## Peer-graded Assignment: Peer-graded Assignment: Course Project 1 - 
## Coursera Exploratory Data Analysis Course by Johns Hopkins University
## Date: 2/10/2019

## 1. Download and unzip the household power consumption data
##    
## Retrieve the dataset from this URL
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

## Name the downloaded file household_power_consumption.zip and the 
## unzipped file household_power_consumption.txt
filename1 <- "household_power_consumption.zip"
filename ="household_power_consumption.txt"

## Verify that the dataset has not already been downloaded before downlaoding
if (!file.exists(filename1)){
    download.file(fileURL, filename1, method="curl")
} 

## Verify that the dataset has not been extracted already 
## from the zipped file before unzipping the file 
if (!file.exists(filename)) { 
    unzip(filename1) 
}

## 2. Load the data into a dataframe
df<-read.table(filename, header = TRUE, sep = ";")

## 3. Convert Time and Date to time date format. Must load chron package
df$Date<-as.Date(df$Date,"%d/%m/%Y")
library(chron)
df$Time<-times(df$Time)

## 4. Convert factors to numeric
df$Global_active_power<-as.numeric(levels(df$Global_active_power))[df$Global_active_power]
df$Global_reactive_power<-as.numeric(levels(df$Global_reactive_power))[df$Global_reactive_power]
df$Voltage<-as.numeric(levels(df$Voltage))[df$Voltage]
df$Global_intensity<-as.numeric(levels(df$Global_intensity))[df$Global_intensity]
df$Sub_metering_1<-as.numeric(levels(df$Sub_metering_1))[df$Sub_metering_1]
df$Sub_metering_2<-as.numeric(levels(df$Sub_metering_2))[df$Sub_metering_2]

## 5. Create a datatime column
df$DateTime <- with(df, as.POSIXct(paste(Date, Time), format="%Y-%m-%d %H:%M:%S"))

## 6. Filter the dataframe to extract appropriate range of 
##    dates 2007-02-01 and 2007-02-02
df_filt<-subset(df, (Date >= "2007-02-01" & Date <= "2007-02-02"))

## 7. Second Plot
with(df_filt,plot(DateTime,Global_active_power, type = "l",xlab="",ylab = "Global Active Power (kilowatts)"))

## Create a png file 480 by 480 pixels
png(filename="plot2.png",width = 480, height = 480, units = "px")
## Create plot
with(df_filt,plot(DateTime,Global_active_power, type = "l",xlab="",ylab = "Global Active Power (kilowatts)"))
##Write plot
dev.off()


