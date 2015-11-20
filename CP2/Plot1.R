# Question
# 1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from 
# all sources for each of the years 1999, 2002, 2005, and 2008.

pm25 <- readRDS('summarySCC_PM25.rds')

# The total emissions from all sources in the sum of all measurements
# in each year. Use aggregate to summarize these data and report the sum
# by year.
totEmissions <- aggregate(pm25$Emissions, list(year = pm25$year), sum)

png('Plot1.png')
# Now plot the total emissions by year
plot(totEmissions$year, totEmissions$x/1e3, type='l',
     xlab='Year', ylab='Total PM2.5 Emission [1000s tons]') #line plot
points(totEmissions$year, totEmissions$x/1e3) #add markers so we can see where the data are
# add title
title(main='PM-2.5 Emission, All sources')
dev.off()
