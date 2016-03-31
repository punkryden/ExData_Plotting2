###################################################################
# Title : plot4.R
# Description : Across the United States, how have emissions 
# from coal combustion-related sources changed from 1999-2008?  
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


# Filter on coal combustion-related
comb <- grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE)
coal <- grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE) 
SCC_sub <- SCC[comb & coal,]
NEI_sub <- NEI[NEI$SCC %in% SCC_sub$SCC,]

# Calculate the PM25 Emissions in KTons
NEI_sub$Emissions <- NEI_sub$Emissions / 1000

#
# Generate Plot 4
#

# Open png device
png(file = "plot4.png", bg="transparent")

# Plot 4
gplot1 <- ggplot(data=NEI_sub, aes(as.factor(year),Emissions, fill=type)) + 
  geom_bar(stat="identity", fill="brown") + 
  guides(fill=FALSE) +
  ggtitle('Total Emissions from coal combustion-related sources') +
  xlab('Years') +
  ylab('PM2.5 in KTons')

# Explicit print display in file
print(gplot1)

# Turn off dev device
dev.off()
