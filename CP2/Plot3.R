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
totEmitByType <- aggregate(baltData$Emissions, list(Year = baltData$year, Type=baltData$type), sum)
repl_x <- which(names(totEmitByType)=='x')
names(totEmitByType)[repl_x] <- 'Emissions'

ptheme <- theme(panel.grid.minor = element_line(colour="white", size=0.3),
                axis.text = element_text(color="grey20", size=13),
                axis.title = element_text(color="grey20", size=13),
                axis.ticks = element_line(size = 1.0),
                panel.border = element_rect(fill=NA, size=0.75, colour = "grey20"))

#now make line plots showing time variation for each source
fig <- ggplot(data=totEmitByType, aes(x=Year, y=Emissions, group = Type, colour = Type)) +
       geom_line(linetype=2) +
       stat_smooth(method = 'lm', se=FALSE, size=1.75) +
       geom_point(size=2, shape=16) +
       ggtitle('Linear Trends in PM-2.5 By Source Type\n1999-2008, Baltimore City, MD') +
       ylab('PM-2.5 Emissions [tons]') +
       ptheme +
       #add minor grid lines to help see increase/decrease
       scale_y_continuous(minor_breaks = seq(0 , 3000, 125))
ggsave(filename='Plot3.png', plot=fig, dpi=72, height=6.67, width=6.67, units="in") #write to PNG ()
