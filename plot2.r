library(dplyr)
NEI <- readRDS("../data/summarySCC_PM25.rds")

year <- unique(NEI$year)

BlatimoreDf <- NEI[NEI$fips == "24510",]

BaltimoreEmm <- tapply(BlatimoreDf$Emissions, BlatimoreDf$year, sum)

plot(year,BaltimoreEmm,"l", ylim = range(BaltimoreEmm)
     , ylab = "Total Emission", xlab = "Year"
     , main = "Total Emission for Baltimore City", lwd= 3, col="red")

dev.copy(png, file = "plot2.png", width = 480, height = 480, units = "px") 
dev.off()
