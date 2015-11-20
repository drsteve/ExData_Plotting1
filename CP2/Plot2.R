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

em99 <- totEmissions$x[totEmissions$year==1999]
em08 <- totEmissions$x[totEmissions$year==2008]

png('Plot2.png')
# Now plot the total emissions by year
plot(totEmissions$year, totEmissions$x/1e3, type='l', lty=2, xaxt = 'n',
     xlab='Year', ylab='Total PM2.5 Emission [1000s tons]') #line plot
axis(1, at=seq(1999,2008,by=1))
points(c(1999, 2008), c(em99/1e3, em08/1e3), col='red', pch=19) #colour '99 and '08 red to higlight years
# add title
title(main='PM-2.5 Emission 1999-2008\nBaltimore City, MD')
dev.off()
