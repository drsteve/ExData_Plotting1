# 3. Of the four types of sources indicated by the type 
# (point, nonpoint, onroad, nonroad) variable, which of 
# these four sources have seen decreases in emissions 
# from 1999–2008 for Baltimore City?
# Which have seen increases in emissions from 1999–2008? 
# Use the ggplot2 plotting system to make a plot answer this question.

library(ggplot2)

pm25 <- readRDS('summarySCC_PM25.rds')
Baltimore = 24510

# The total emissions from all sources in the sum of all measurements
# in each year. Use aggregate to summarize these data and report the sum
# by year. First split by fips and select baltimore
pm25_fips <- split(pm25, pm25$fips)
idx <- which(names(pm25_fips)==Baltimore)

baltData <- pm25_fips[[idx]]
totEmitByType <- aggregate(baltData$Emissions, list(Year = baltData$year, SourceType=baltData$type), sum)
repl_x <- which(names(totEmitByType)=='x')
names(totEmitByType)[repl_x] <- 'Emissions'

#now make line plots showing time variation for each source
fig <- ggplot(data=totEmitByType, aes(x=Year, y=Emissions, group = SourceType, colour = SourceType)) +
       geom_line() +
       geom_point( size=4, shape=21, fill="white") +
       ggtitle('PM-2.5 By Source Type\nBaltimore City, MD') +
       ylab('PM-2.5 Emissions [tons]')
ggsave(filename='Plot3.png', plot=fig) #write to PNG
