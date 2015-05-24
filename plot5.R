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
vehicalMatches  <- grepl("vehicle", SCC$Short.Name, ignore.case=TRUE) 
subsetSCC <- SCC[vehicalMatches, ]
# extract baltimore data 
NEI_baltimore <- NEI[NEI$fips=="24510",]

NEISCC_baltimore <- merge(NEI_baltimore, subsetSCC, by="SCC")

aggregatedTotalByYear <- aggregate(Emissions ~ year, NEISCC_baltimore, sum)

#start Plotting
png("plot5.png",width=600,height=600)

print(ggplot(NEISCC_baltimore,aes(factor(year),Emissions)) +
        geom_bar(stat="identity",fill="grey",width=0.5) +
        theme_bw() +  guides(fill=FALSE) +
        labs(x="year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
        labs(title=expression("PM"[2.5]*" vehicle Source Emissions Across US from 1999-2008"))
)
dev.off()
