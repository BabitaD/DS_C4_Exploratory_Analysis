library(ggplot2)
library(dplyr)
NEI <- readRDS("../data/summarySCC_PM25.rds")
SCC <- readRDS("../data/Source_Classification_Code.rds")

SCC_Vehicle <- SCC[grep("[Vv]eh", SCC$Short.Name),]$SCC

BaltimoreDf <- subset(NEI, (fips == "24510" & NEI$SCC %in% SCC_Vehicle))
LaDf <- subset(NEI, (fips == "06037" & NEI$SCC %in% SCC_Vehicle))


BaltimoreDf<- BaltimoreDf %>%
  group_by(year) %>%
  summarise(Ems_tot = sum(Emissions, na.rm = T))

LaDf<- LaDf %>%
  group_by(year) %>%
  summarise(Ems_tot = sum(Emissions, na.rm = T))

BaltimoreDf <- cbind(BaltimoreDf, "City" = "Baltimore")
LaDf <- cbind(LaDf, "City" = "LA")

motorEms <- rbind(BaltimoreDf,LaDf)

motorEms

plot<- ggplot(data = motorEms, aes(year, Ems_tot, col = City))
plot + geom_point(size = 5) +
  xlab("Year") + ylab("Total Emission") + 
  ggtitle("Comparison of Emmision from Motor Vehicle Sources for Baltimore and LA") +
  theme(plot.title = element_text(hjust = 0.5))

dev.copy(png, file = "plot6.png", width = 480, height = 480, units = "px") 
dev.off()

