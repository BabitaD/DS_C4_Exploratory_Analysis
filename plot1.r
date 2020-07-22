
NEI <- readRDS("../data/summarySCC_PM25.rds")

head(NEI)
str(NEI)

year <- unique(NEI$year)
totEmm <- tapply(NEI$Emissions, NEI$year, sum)
plot(year,totEmm,"l", ylim = range(totEmm), ylab = "Total Emission", xlab = "Year"
     , main = "Total Emission", lwd= 3, col="green")

dev.copy(png, file = "plot1.png", width = 480, height = 480, units = "px") 
dev.off()
