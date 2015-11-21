source("downloadDataArchive.R")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
library(dplyr)
library(ggplot2)

#SCC_coal <- SCC[grepl("Coal", SCC$EI.Sector, ignore.case = TRUE), 1]
SCC_coal <- SCC[grepl("Coal", SCC$SCC.Level.Four, ignore.case = TRUE) & grepl("comb", SCC$SCC.Level.One, ignore.case = TRUE), 1]
SCC_coal <- as.character(SCC_coal)

## Point Graph
NEI_coal <- NEI %>% group_by(year) %>% filter(SCC %in% SCC_coal) %>% summarize(TotalEmissionsPerYear= sum(Emissions))
png(filename = 'plot4.png')
g <- ggplot(NEI_coal, aes((year), TotalEmissionsPerYear))
g + geom_point() + geom_smooth(method = "lm", se = FALSE) +
    labs(x="Year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
    labs(title=expression("PM"[2.5]*" Coal Combustion Source Emissions Across US from 1999-2008"))
dev.off()


## Bar Plot
# NEI_coal <- NEI[NEI$SCC %in% SCC_coal,]
# png(filename = 'plot4.png')
# g <- ggplot(NEI_coal,aes(factor(year),Emissions/10^5)) +
#   geom_bar(stat="identity",fill="grey",width=0.75) +
#   theme_bw() +  guides(fill=FALSE) +
#   labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
#   labs(title=expression("PM"[2.5]*" Coal Combustion Source Emissions Across US from 1999-2008"))
# print(g)
# dev.off()

