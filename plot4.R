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

# prepare data
# 
coalMatches  <- grepl("coal", SCC$Short.Name, ignore.case=TRUE) 
subsetSCC <- SCC[coalMatches, ]
NEISCC <- merge(NEI, subsetSCC, by="SCC")
aggregatedTotalByYear <- aggregate(Emissions ~ year, NEISCC, sum)

#start Plotting
png("plot4.png",width=600,height=600)

print(ggplot(NEISCC,aes(factor(year),Emissions/10^5)) +
        geom_bar(stat="identity",fill="grey",width=0.5) +
        theme_bw() +  guides(fill=FALSE) +
        labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
        labs(title=expression("PM"[2.5]*" Coal Combustion Source Emissions Across US from 1999-2008"))
)
dev.off()
