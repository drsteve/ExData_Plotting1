#Data downloaded from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
#Unzip to local folder

#read data
require(data.table)
getData <- function() {
    #the "::" on the line below denotes the namespace (i.e. package) of the fread command,
    #since it's not in base R. This isn't necessary, but I prefer seeing it explicitly.
    powerdata <- data.table::fread('household_power_consumption.txt', na.strings='?')
    #Plot 1 only uses 2007-02-01 and 2007-02-02 so select just these days
    d1 <- "1/2/2007"
    d2 <- "2/2/2007"
    #cut down to only required indices
    subdata <- subset(powerdata, powerdata$Date==d1 | powerdata$Date==d2)
    return(subdata)
}

##Now the data prep is done, make the plot (callable so the file can be sourced
##and the function can be used separately...)
makePlot <- function(indata, ...) {
    hist(indata, ...)
}

##Now run everything...
usedata <- getData()
##Make labels
title <- "Global Active Power"
xunits <- "(kilowatts)"
xlabel <- paste(title, xunits)
##Draw figure
png('Plot1.png', bg='transparent') #open new PNG output graphics device
makePlot(usedata$Global_active_power, col='red', xlab=xlabel, main=title)
dev.off() #close current output graphics device
