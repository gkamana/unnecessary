NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI_SCC <- merge(NEI, SCC, by = "SCC")

library(ggplot2)

subNEI <- NEI[NEI$fips=="24510" & NEI$type=="ON-ROAD",  ]

aggregateByYear <- aggregate(Emissions ~ year, subNEI, sum)

png("plot5.png", width=840, height=480)
g <- ggplot(aggregateByYear, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity") +
    xlab("year") +
    ylab(expression('Total PM'[2.5]*" Emissions")) +
    ggtitle('Total Emissions from motor vehicle (type = ON-ROAD) in Baltimore City, Maryland (fips = "24510") from 1999 to 2008')
print(g)
dev.off()
