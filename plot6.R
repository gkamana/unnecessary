NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI_SCC <- merge(NEI, SCC, by = "SCC")

library(ggplot2)

subNEI <- NEI[(NEI$fips=="24510"|NEI$fips=="06037") & NEI$type=="ON-ROAD",  ]

aggregataByYearNFIPS <- aggregate(Emissions ~ year + fips, subNEI, sum)
aggregataByYearNFIPS$fips[aggregataByYearNFIPS$fips=="24510"] <- "Baltimore, MD"
aggregataByYearNFIPS$fips[aggregataByYearNFIPS$fips=="06037"] <- "Los Angeles, CA"

png("plot6.png", width=1040, height=480)
g <- ggplot(aggregataByYearNFIPS, aes(factor(year), Emissions))
g <- g + facet_grid(. ~ fips)
g <- g + geom_bar(stat="identity")  +
    xlab("year") +
    ylab(expression('Total PM'[2.5]*" Emissions")) +
    ggtitle('Total Emissions from motor vehicle (type=ON-ROAD) in Baltimore City, MD (fips = "24510") vs Los Angeles, CA (fips = "06037")  1999-2008')
print(g)
dev.off()
