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

NEI_baltimore$city <- "Baltimore City"
# extract LA data 
NEI_LA <- NEI[NEI$fips=="06037",]

NEI_LA$city <- "Los Angeles County"

NEISCC_baltimore <- merge(NEI_baltimore, subsetSCC, by="SCC")
NEISCC_LA <- merge(NEI_LA, subsetSCC, by="SCC")

combineNEI <- rbind(NEISCC_baltimore,NEISCC_LA)



#start Plotting
png("plot6.png",width=600,height=600)

  print(ggplot(combineNEI, aes(x=factor(year), y=Emissions, fill=city)) +
  geom_bar(aes(fill=year),stat="identity") +
  facet_grid(scales="free", space="free", .~city) +
  guides(fill=FALSE) + theme_bw() +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (Kilo-Tons)")) + 
  labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore & LA, 1999-2008")))

dev.off()
