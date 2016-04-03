#Download Data
if (!file.exists("data.zip")) {
  download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
                destfile="data.zip",)
  unzip("data.zip")  
}

#Read all the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Aggegate data by year
TotalByYear <- aggregate(Emissions ~ year, NEI, sum)

#Generate plot
png("plot1.png", width=480, height=480)
barplot(height=TotalByYear$Emissions, names.arg=TotalByYear$year, xlab="Year", ylab="PM2.5 in tones",main="Total Emission of PM2.5")
dev.off()
