# load required library
library(ggplot2)
library(plyr)
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
#aggTotals <- aggregate(Emissions ~ year,NEI_baltimore, sum)

#start Plotting
png("plot3.png",width=600,height=600)

print(ggplot(NEI_baltimore,aes(factor(year),Emissions,fill=type)) +
  geom_bar(stat="identity") +
  theme_bw() + guides(fill=FALSE) +
  facet_grid(.~type,scales = "free",space="free") +  
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (Tons)"))  +
  labs(title=expression("PM"[2.5]*" Emissions, Baltimore City 1999-2008 by Source Type")))
dev.off()
