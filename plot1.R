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
 # do  agregation over full data
aggTotals <- aggregate(Emissions ~ year,NEI, sum)

#start Plotting
png("plot1.png",width=480,height=480)

barplot(
  (aggTotals$Emissions)/10^6,
  names.arg=aggTotals$year,
  xlab="Year",
  ylab="PM2.5 Emissions (10^6 Tons)",
  main="Total PM2.5 Emissions From All US Sources"
)
dev.off()
