#Download Data
if (!file.exists("data.zip")) {
  download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
                destfile="data.zip",)
  unzip("data.zip")  
}

#Read all the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subset for Baltimore and Motor Vehicle
sub1 <- subset(NEI, fips == "24510" & type=="ON-ROAD")

#Aggegate data by year
TotalByYear <- aggregate(Emissions ~ year, sub1, sum)

#Generate plot
library(ggplot2)
png("plot5.png", width=640, height=480)
g <- ggplot(TotalByYear, aes(factor(year), Emissions))
g <- g + geom_line((aes(group=1, col=Emissions)), stat="identity", colour="Red") +
  xlab("Year") +
  ylab("PM2.5 in tones") +
  ggtitle("Total Emission of PM2.5 from Motor Vehicles in Baltimore City, Maryland") +
  theme(legend.position='none') 
print(g)

dev.off()
