###################################################################
# Title : plot3.R
# Description : Of the four types of sources indicated by the 
# type (point, nonpoint, onroad, nonroad) variable, which of 
# these four sources have seen decreases in emissions from 1999-2008 
# for Baltimore City? Which have seen increases in emissions from 1999-2008? 
# Use the ggplot2 plotting system to make a plot answer this question. 
# 
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

# Aggregate data by type and year
NEI_agg <- aggregate(Emissions ~ year+type, data=NEI_sub, sum)

# Calculate the PM25 Emissions in KTons
NEI_agg2 <- NEI_agg
NEI_agg2$Emissions <- NEI_agg2$Emissions/1000

#
# Generate Plot 3
#

# Open png device
png(file = "plot3.png", bg="transparent")

# Create a ramp color red to green order by the value of PM25
# col_red2green <- green2red(4)[order(as.vector(p2))]

# Plot 3
gplot1 <- ggplot(data=NEI_agg2, aes(as.factor(year),Emissions, fill=type)) + 
facet_grid(. ~ type) + 
geom_bar(stat="identity") + 
guides(fill=FALSE) +
ggtitle('Total Emissions per Type in Baltimore City, Maryland') +
xlab('Years') +
ylab('PM2.5 in KTons')

# Explicit print display in file
print(gplot1)

# Turn off dev device
dev.off()
