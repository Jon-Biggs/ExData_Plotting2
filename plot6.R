#Download Data
if (!file.exists("data.zip")) {
  download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
                destfile="data.zip",)
  unzip("data.zip")  
}

#Read all the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subset for Baltimore and LA and Motor Vehicle
sub1 <- subset(NEI, fips == "24510" & type=="ON-ROAD")
sub2 <- subset(NEI, fips == "06037" & type=="ON-ROAD")

#Aggegate data by year and fips
TotalByYearandFips1 <- aggregate(Emissions ~ year + fips, sub1, sum)
TotalByYearandFips2 <- aggregate(Emissions ~ year + fips, sub2, sum)
TotalByYearandFips <- rbind(TotalByYearandFips1, TotalByYearandFips2)
TotalByYearandFips$fips[TotalByYearandFips$fips=="24510"] <- "Baltimore"
TotalByYearandFips$fips[TotalByYearandFips$fips=="06037"] <- "Los Angeles"
names(TotalByYearandFips)[names(TotalByYearandFips)=="fips"] <- "Location"

#Generate plot
library(ggplot2)
png("plot6.png", width=640, height=480)
g <- ggplot(TotalByYearandFips, aes(factor(year), Emissions, group=Location, colour=Location))
g <- g + geom_line() +
  geom_point() +
  xlab("Year") +
  ylab("PM2.5 in tones") +
  ggtitle("Total Emission of PM2.5 from Motor Vehicles in Baltimore City and Los Angeles County") +
  theme(legend.position="right") 
print(g)

dev.off()
