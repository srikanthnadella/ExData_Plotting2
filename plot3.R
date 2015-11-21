source("downloadDataArchive.R")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
library(dplyr)
library(ggplot2)

## Point Graph
NEI_Maryland <- NEI %>% filter(fips == "24510") %>% group_by(year, type) %>% summarize(TotalEmissionsPerYear= sum(Emissions))

png(filename = 'plot3.png')
g <- ggplot(NEI_Maryland, aes(year, TotalEmissionsPerYear))
g + geom_point() + geom_smooth(method = "lm", se = FALSE) + facet_grid(type~.) + 
  labs(x = "Year", y = expression("Total PM"[2.5]*" Emission (Tons)")) + 
  labs(title=expression("PM"[2.5]*" Emissions, Baltimore City from 1999-2008 by Source Type"))
dev.off()

## Bar Plot
# NEI_Maryland <- NEI %>% filter(fips == "24510") %>% group_by(year, type) %>% summarize(TotalEmissionsPerYear= sum(Emissions))
# 
# png(filename = 'plot3.png')
# g <- ggplot(NEI_Maryland, aes(factor(year), TotalEmissionsPerYear, fill = type))
# g + geom_bar(stat = "identity") + facet_grid(.~ type, scales = "free",space="free") + guides(fill=FALSE)+ 
#   labs(x = "Year", y = expression("Total PM"[2.5]*" Emission (Tons)")) + 
#   labs(title=expression("PM"[2.5]*" Emissions, Baltimore City from 1999-2008 by Source Type"))
# dev.off()

