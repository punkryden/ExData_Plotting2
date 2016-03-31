###################################################################
# Title : plot2.R
# Description :  
# 
###################################################################

#
# Load colorRamps library
#

require(colorRamps)

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

# Sum the PM25 Emissions by years
p1 <- sapply(split(NEI_sub$Emissions, NEI_sub$year), sum)

# Calculate the PM25 Emissions in KTons
p2 <- p1/1000 

#
# Generate Plot 2
#

# Open png device
png(file = "plot2.png", bg="transparent")

# Create a ramp color red to green order by the value of PM25
col_red2green <- green2red(4)[order(as.vector(p2))]

# Plot 2
barplot(p2, main="Total Emissions of PM2.5 in Baltimore City, Maryland", xlab="Years", ylab="PM2.5 in KTons", col=col_red2green)

# Turn off dev device
dev.off()
