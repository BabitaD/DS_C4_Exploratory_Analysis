library(ggplot2)
library(dplyr)
NEI <- readRDS("../data/summarySCC_PM25.rds")
SCC <- readRDS("../data/Source_Classification_Code.rds")

head(SCC)
SCC_Coal <- SCC[grep("[Cc]oal",SCC$EI.Sector),]$SCC
NEI_Coal <- subset(NEI, NEI$SCC %in% SCC_Coal)

nrow(NEI_Coal)
NEI_Coal_tot<- NEI_Coal %>%
  group_by(year) %>%
  summarise(Ems_tot = sum(Emissions, na.rm = T))

plot<- ggplot(data = NEI_Coal_tot, aes(year, Ems_tot))
plot + geom_point(color = "blue", size = 5) +
  xlab("Year") + ylab("Total Emission") + 
  ggtitle("Total Emmision from Coal Combustion-related Sources") +
  theme(plot.title = element_text(hjust = 0.5))

dev.copy(png, file = "plot4.png", width = 480, height = 480, units = "px") 
dev.off()

