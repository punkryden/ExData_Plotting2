###################################################################
# Title : plot1.R
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

# Sum the PM25 Emissions by years
p1 <- sapply(split(NEI$Emissions, NEI$year), sum)

# Calculate the PM25 Emissions in KTons
p2 <- p1/1000 

#
# Generate Plot 1
#

# Open png device
png(file = "plot1.png", bg="transparent")

# Create a ramp color red to green order by the value of PM25
col_red2green <- green2red(4)[order(as.vector(p2))]

# Plot 1
barplot(p2, main="Total Emissions of PM2.5", xlab="Years", ylab="PM2.5 in KTons", col=col_red2green)

# Turn off dev device
dev.off()
