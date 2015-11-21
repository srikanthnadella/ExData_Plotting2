source("downloadDataArchive.R")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
library(dplyr)
NEI_totalEmissionsPerYear_Maryland <- NEI %>% filter(fips == "24510") %>% group_by(year) %>% summarize(totalEmissionsPerYear= sum(Emissions))

png(filename = 'plot2.png', width = 480, height = 480)

## Point and Line Graph
with(NEI_totalEmissionsPerYear_Maryland, plot(year, totalEmissionsPerYear, xlab = "", ylab = ""))
with(NEI_totalEmissionsPerYear_Maryland, lines(year, totalEmissionsPerYear, xlab = "", ylab = ""))
title(xlab = "Year", ylab = "PM2.5 Emissions (Tons)", main = "Total PM2.5 Emissions From all Baltimore City Sources")

## Bar Graph
# with(NEI_totalEmissionsPerYear_Maryland, barplot(totalEmissionsPerYear, names.arg = year, 
#                                                  xlab="Year", ylab="PM2.5 Emissions (Tons)",
#                                                  main="Total PM2.5 Emissions From all Baltimore City Sources"))
dev.off()
