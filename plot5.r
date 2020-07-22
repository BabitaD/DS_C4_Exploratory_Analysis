library(ggplot2)
library(dplyr)
NEI <- readRDS("../data/summarySCC_PM25.rds")
SCC <- readRDS("../data/Source_Classification_Code.rds")

SCC_Vehicle <- SCC[grep("[Vv]eh", SCC$Short.Name),]$SCC
NEI_Vehicle <- subset(NEI, (fips == "24510" & NEI$SCC %in% SCC_Vehicle))

nrow(NEI_Vehicle)

NEI_Vehicle_tot<- NEI_Vehicle %>%
  group_by(year) %>%
  summarise(Ems_tot = sum(Emissions, na.rm = T))

plot<- ggplot(data = NEI_Vehicle_tot, aes(year, Ems_tot))
plot + geom_point(color = "green", size = 5) +
  xlab("Year") + ylab("Total Emission") + 
  ggtitle("Total Emmision from Motor Vehicle Sources for Baltimore City") +
  theme(plot.title = element_text(hjust = 0.5))


dev.copy(png, file = "plot5.png", width = 480, height = 480, units = "px") 
dev.off()

