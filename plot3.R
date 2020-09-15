## This first line will likely take a few seconds. Be patient!
rawdata <- readRDS("data/summarySCC_PM25.rds")
# Reference
SCC <- readRDS("data/Source_Classification_Code.rds")

# We remove the pollutant column:
# a call to unique() shows always the same value "PM25-PRI"
data <- rawdata[,-c(3)]

# Of the four types of sources indicated by the type:
# 1. Which have seen decreases in emissions from 1999–2008 for Baltimore City?
# 2. Which have seen increases in emissions from 1999–2008?
data <- subset(data, fips == "24510")

# Prepare for png output
png(filename = "plot3.png",
    width = 480, height = 480,
    units = "px")

# Load the plotting library
if(! "ggplot2" %in% rownames(installed.packages())){
  install.packages("ggplot2")
}
library("ggplot2")

# Plot
ggplot(data = data) +
  geom_col(aes(x = as.character(year), y = Emissions)) +
  facet_grid(type~.) +
  labs(x = "", y="Emissions (tons)", title = "PM2.5 emissions for Baltimore City by source type")

dev.off()