# set  working directory
setwd("D://Repos//ExData_Project2")
# Load NEI Data if not loaded
if(!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds")
}
# Load SSC Data if not loaded
if(!exists("SCC")){
  SCC <- readRDS("Source_Classification_Code.rds")
}

# extract baltimore data 
NEI_baltimore <- NEI[NEI$fips=="24510",]
# do  agregation over  data
aggTotals <- aggregate(Emissions ~ year,NEI_baltimore, sum)

#start Plotting
png("plot2.png",width=480,height=480)

barplot(
  (aggTotals$Emissions),
  names.arg=aggTotals$year,
  xlab="Year",
  ylab="PM2.5 Emissions (Tons)",
  main="Total PM2.5 Emissions From All US Sources"
)
dev.off()
