source("downloadDataArchive.R")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
library(dplyr)
NEI_totalEmissionsPerYear <- NEI %>% group_by(year) %>% summarize(totalEmissionsPerYear= sum(Emissions))


png(filename = 'plot1.png', width = 480, height = 480)

## Scatter Plot
with(NEI_totalEmissionsPerYear, plot(year, totalEmissionsPerYear, xlab = "", ylab = ""))
with(NEI_totalEmissionsPerYear, lines(year, totalEmissionsPerYear, xlab = "", ylab = ""))
title(xlab = "Year", ylab = "PM2.5 Emissions (Tons)", main = "Total PM2.5 Emissions From All US Sources")

## Bar Plot
# with(NEI_totalEmissionsPerYear, barplot(totalEmissionsPerYear, names.arg = year,
#                                         xlab="Year", ylab="PM2.5 Emissions (Tons)",
#                                         main="Total PM2.5 Emissions From All US Sources"))
dev.off()
