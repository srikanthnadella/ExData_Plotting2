source("downloadDataArchive.R")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
library(dplyr)
library(ggplot2)

# SCC_vehicle1 <- SCC[grep("Vehicle", SCC$EI.Sector), 1]
SCC_vehicle <- SCC[grep("Vehicle", SCC$SCC.Level.Two), 1]
SCC_vehicle <- as.character(SCC_vehicle)

## Point Graph
NEI_vehicle_baltimore <- NEI %>% filter(fips == "24510") %>% group_by(year) %>% filter(SCC %in% SCC_vehicle) %>% summarize(TotalEmissionsPerYear= sum(Emissions))
NEI_vehicle_baltimore$city <- "Baltimore City"
NEI_vehicle_la <- NEI %>% filter(fips == "06037") %>% group_by(year) %>% filter(SCC %in% SCC_vehicle) %>% summarize(TotalEmissionsPerYear= sum(Emissions))
NEI_vehicle_la$city <- "Los Angeles County"

NEI_vehicle_join <- rbind(NEI_vehicle_baltimore, NEI_vehicle_la)

png(filename = 'plot6.png')
g <- ggplot(NEI_vehicle_join, aes((year), TotalEmissionsPerYear))
g + geom_point() + geom_smooth(method = "lm")  + facet_grid(.~city) +
  labs(x="Year", y=expression("Total PM"[2.5]*" Emission (Tons)")) +
  labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore & LA County, 1999-2008"))
dev.off()


## Box Plot
# NEI_vehicle_baltimore <- NEI %>% filter(fips == "24510") %>% group_by(year) %>% filter(SCC %in% SCC_vehicle) 
# NEI_vehicle_baltimore$city <- "Baltimore City"
# NEI_vehicle_la <- NEI %>% filter(fips == "06037") %>% group_by(year) %>% filter(SCC %in% SCC_vehicle)
# NEI_vehicle_la$city <- "Los Angeles County"
# 
# NEI_vehicle_join <- rbind(NEI_vehicle_baltimore, NEI_vehicle_la)
# 
# png(filename = 'plot6.png')
# g <- ggplot(NEI_vehicle_join, aes((year), Emissions, fill = city))
# g + geom_bar(stat = "identity", aes(fill = year))  + facet_grid(.~city) + guides(fill = FALSE) +
#   labs(x="Year", y=expression("Total PM"[2.5]*" Emission (Tons)")) +
#   labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore & LA County, 1999-2008"))
# dev.off()

