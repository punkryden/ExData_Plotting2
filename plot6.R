###################################################################
# Title : plot6.R
# Description : Compare emissions from motor vehicle sources 
# in Baltimore City with emissions from motor vehicle sources 
# in Los Angeles County, California (fips == "06037"). Which city 
# has seen greater changes over time in motor vehicle emissions?
###################################################################

#
# Load colorRamps and ggplot2 library
#

require(colorRamps)
require(ggplot2)

#
# Import data files
#

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#
# Extract data
#

# Filter on motor vehicle sources
vehicl <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
SCC_sub <- SCC[vehicl,]
NEI_sub <- NEI[NEI$SCC %in% SCC_sub$SCC,]

# Calculate the PM25 Emissions in KTons
NEI_sub$Emissions <- NEI_sub$Emissions / 1000

# Subset the Baltimore City, Maryland data
NEI_subBA <- subset(NEI_sub[NEI_sub$fips=="24510",])
NEI_subBA$city <- "Baltimore City"

# Subset the Baltimore City, Maryland data
NEI_subLA <- subset(NEI_sub[NEI_sub$fips=="06037",])
NEI_subLA$city <- "Los Angeles County"

# Rbind LA and BA
NEI_bind <- rbind(NEI_subLA,NEI_subBA)

#
# Generate Plot 6
#

# Open png device
png(file = "plot6.png", bg="transparent")

# Plot 6
gplot1 <- ggplot(data=NEI_bind, aes(as.factor(year),Emissions, fill=city)) + 
  geom_bar(stat="identity") + 
  facet_grid( .~city) +
  guides(fill=FALSE) +
  ggtitle('Total Emissions in Baltimore and LA from motor vehicle sources') +
  xlab('Years') +
  ylab('PM2.5 in KTons')

# Explicit print display in file
print(gplot1)

# Turn off dev device
dev.off()
