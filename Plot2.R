#Data downloaded from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
#Unzip to local folder

#read data and
#convert date field to date datatype
require(data.table)
getData <- function() {
    powerdata <- data.table::fread('household_power_consumption.txt', na.strings='?')
    #Plot 2 is a time series of the power on 2 days: 2007-02-01 and 2007-02-02
    #so select just these days and then convert to dates/times
    d1 <- "1/2/2007"
    d2 <- "2/2/2007"
    #cut down to only required indices
    subdata <- subset(powerdata, powerdata$Date==d1 | powerdata$Date==d2)
    #add POSIXct times to data.table 
    subdata[, "DateTime":=as.POSIXct(strptime(paste(subdata$Date, subdata$Time), '%d/%m/%Y %H:%M:%S'))]
    return(subdata)
}

##Now the data prep is done, make the plot (callable so the file can be sourced
##and the function can be used separately...
makePlot <- function(xquan, yquan, ...) {
    plot(xquan, yquan, ...)
}

##Now run everything...
usedata <- getData()
##Make labels
ylabel <- "Global Active Power (kilowatts)"
##Draw figure
png('Plot2.png', bg='transparent') #open new PNG output graphics device
makePlot(usedata$DateTime, usedata$Global_active_power, type='l', xlab='',ylab=ylabel)
dev.off() #close current output graphics device
