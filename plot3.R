#Download Data
if (!file.exists("data.zip")) {
  download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
                destfile="data.zip",)
  unzip("data.zip")  
}

#Read all the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subset for Baltimore
sub1 <- subset(NEI, fips == "24510")

#Aggegate data by year and type
TotalByYearAndType <- aggregate(Emissions ~ year + type, sub1, sum)

#Generate plot
library(ggplot2)
png("plot3.png", width=640, height=480)
g <- ggplot(TotalByYearAndType, aes(year, Emissions, color = type))
g <- g + geom_line() +
  xlab("Year") +
  ylab("PM2.5 in tones") +
  ggtitle("Total Emission of PM2.5 in Baltimore City, Maryland")
print(g)

dev.off()
