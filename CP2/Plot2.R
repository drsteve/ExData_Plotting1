#2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510")
# from 1999 to 2008? Use the base plotting system to make a plot answering this question.

pm25 <- readRDS('summarySCC_PM25.rds')
Baltimore = 24510

# The total emissions from all sources in the sum of all measurements
# in each year. Use aggregate to summarize these data and report the sum
# by year. First split by fips and select baltimore
pm25_fips <- split(pm25, pm25$fips)
idx <- which(names(pm25_fips)==Baltimore)

baltData <- pm25_fips[[idx]]
totEmissions <- aggregate(baltData$Emissions, list(year = baltData$year), sum)

png('Plot2.png')
# Now plot the total emissions by year
plot(totEmissions$year, totEmissions$x/1e3, type='l',
     xlab='Year', ylab='Total PM2.5 Emission [1000s tons]') #line plot
points(totEmissions$year, totEmissions$x/1e3) #add markers so we can see where the data are
# add title
title(main='PM-2.5 Emission\nBaltimore City, MD')
dev.off()
