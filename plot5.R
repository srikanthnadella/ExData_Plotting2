source("downloadDataArchive.R")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
library(dplyr)
library(ggplot2)

# SCC_vehicle1 <- SCC[grep("Vehicle", SCC$EI.Sector), 1]
SCC_vehicle <- SCC[grep("Vehicle", SCC$SCC.Level.Two), 1]
SCC_vehicle <- as.character(SCC_vehicle)

# Point Graph
NEI_vehicle <- NEI %>% filter(fips == "24510") %>% group_by(year) %>% filter(SCC %in% SCC_vehicle) %>% summarize(TotalEmissionsPerYear= sum(Emissions))
png(filename = 'plot5.png')
g <- ggplot(NEI_vehicle, aes((year), TotalEmissionsPerYear))
g + geom_point() + geom_smooth(method = "lm")  +
labs(x="Year", y=expression("Total PM"[2.5]*" Emission (Tons)")) +
labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore from 1999-2008"))
dev.off()

## Bar Plot
# NEI_vehicle <- NEI %>% filter(fips == "24510") %>% filter(SCC %in% SCC_vehicle)
# png(filename = 'plot5.png')
# g <- ggplot(NEI_vehicle,aes(factor(year),Emissions)) +
#   geom_bar(stat="identity",fill="grey",width=0.75) +
#   theme_bw() +  guides(fill=FALSE) +
#   labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
#   labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore from 1999-2008"))
# print(g)
# dev.off()

