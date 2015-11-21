# 4. Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999–2008?
library(ggplot2)

pm25 <- readRDS('summarySCC_PM25.rds')
SCC <- readRDS('Source_Classification_Code.rds')

# Coal combustions sources
combSrc <- grep('.*[Cc]omb.*[Cc]oal', SCC$EI.Sector)
keepSCC <- as.character(SCC$SCC[combSrc])
pm25_coal <- pm25[pm25$SCC %in% keepSCC,]

totEmitCoal <- aggregate(pm25_coal$Emissions, list(Year=pm25_coal$year), sum)
totEmitByType <- aggregate(pm25_coal$Emissions, list(Year=pm25_coal$year, Type=pm25_coal$type), sum)
repl_x <- which(names(totEmitCoal)=='x')
names(totEmitCoal)[repl_x] <- 'TotalEmissions'
repl_x <- which(names(totEmitByType)=='x')
names(totEmitByType)[repl_x] <- 'Emissions'

#set plot theme
ptheme <- theme(panel.grid.minor = element_line(colour="white", size=0.3),
                axis.text = element_text(color="grey20", size=13),
                axis.title = element_text(color="grey20", size=13),
                axis.ticks = element_line(size = 1.0),
                panel.border = element_rect(fill=NA, size=0.75, colour = "grey20"))

#show trend and points on graph
fig <- ggplot(data=totEmitCoal, aes(x=Year, y=TotalEmissions)) +
       geom_line(linetype=2, aes(x=Year, y=TotalEmissions, colour='Total')) +
       geom_line(data=totEmitByType, aes(x=Year, y=Emissions, group = Type, colour = Type), linetype=2) +
       stat_smooth(method = 'lm', se=FALSE, size=1.75) +
       scale_colour_manual(name='', values=c('Total'='blue', 'NONPOINT'='green', 'POINT'='magenta')) +
       ggtitle('Coal Combustion Emissions, 1999-2008\nTotal (with trend) and by type') +
       ylab('PM-2.5 Emissions [tons]') +
       ptheme +
       #add minor grid lines to help see increase/decrease
       scale_y_continuous(minor_breaks = seq(0 , 3000, 125))
ggsave(filename='Plot4.png', plot=fig, dpi=72, height=6.67, width=6.67, units="in") #write to PNG ()
