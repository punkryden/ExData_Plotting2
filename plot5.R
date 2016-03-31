###################################################################
# Title : plot5.R
# Description : How have emissions from motor vehicle sources 
# changed from 1999-2008 in Baltimore City?
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

# Subset the Baltimore City, Maryland data
NEI_sub <- subset(NEI[NEI$fips=="24510",])

# Filter on motor vehicle sources
vehicl <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
SCC_sub <- SCC[vehicl,]
NEI_sub2 <- NEI_sub[NEI_sub$SCC %in% SCC_sub$SCC,]

# Calculate the PM25 Emissions in KTons
NEI_sub2$Emissions <- NEI_sub2$Emissions / 1000

#
# Generate Plot 5
#

# Open png device
png(file = "plot5.png", bg="transparent")

# Plot 5
gplot1 <- ggplot(data=NEI_sub2, aes(as.factor(year),Emissions, fill=year)) + 
  geom_bar(stat="identity") + 
  guides(fill=FALSE) +
  ggtitle('Total Emissions in Baltimore City, Maryland from motor vehicle sources') +
  xlab('Years') +
  ylab('PM2.5 in KTons')

# Explicit print display in file
print(gplot1)

# Turn off dev device
dev.off()
