library(ggplot2)
library(dplyr)
NEI <- readRDS("../data/summarySCC_PM25.rds")

BaltimoreEmm <- NEI %>%
  subset(fips == "24510") %>%
  group_by(year, type) %>%
  summarise(EmmByType = sum(Emissions, na.rm = T))

head(BaltimoreEmm)

plot <- ggplot(data = BaltimoreEmm, aes(year, EmmByType))
plot + geom_point(color = "green", size = 5) +
  facet_grid(.~type) +
  xlab("Year") + ylab("Total Emission") + 
  ggtitle("Total Emmision for Baltimore City by Type") +
  theme(axis.text.x = element_text(angle = 45)
        , plot.title = element_text(hjust = 0.5))

dev.copy(png, file = "plot3.png", width = 480, height = 480, units = "px") 
dev.off()
