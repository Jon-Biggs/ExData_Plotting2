#Download Data
if (!file.exists("data.zip")) {
  download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
                destfile="data.zip",)
  unzip("data.zip")  
}

#Read all the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subset for Coal
subSCC <- SCC[grepl("Coal" , SCC$Short.Name), ]
sub1 <- NEI[NEI$SCC %in% subSCC$SCC, ]

#Aggegate data by year
TotalByYear <- aggregate(Emissions ~ year, sub1, sum)

#Generate plot
library(ggplot2)
png("plot4.png", width=640, height=480)
g <- ggplot(TotalByYear, aes(factor(year), Emissions/1000))
g <- g + geom_line((aes(group=1, col=Emissions)), stat="identity") +
  xlab("Year") +
  ylab("PM2.5 in Kilotones") +
  ggtitle("Total Emission of PM2.5 from all Coal sources") +
  theme(legend.position='none') 
print(g)

dev.off()
