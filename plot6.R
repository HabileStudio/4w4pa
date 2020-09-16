## This first line will likely take a few seconds. Be patient!
rawdata <- readRDS("data/summarySCC_PM25.rds")
# Reference
SCC <- readRDS("data/Source_Classification_Code.rds")

# We remove the pollutant column:
# a call to unique() shows always the same value "PM25-PRI"
data <- rawdata[,-c(3)]

# Get the Motor vehicle related SCC codes 
motor <- grep("Motor|Vehicle", SCC$Short.Name)
motorcodes <- as.character(SCC[motor,"SCC"])

data <- data[data$SCC %in% motorcodes,]

# Compare emissions from motor vehicle sources in Baltimore City
# with emissions from motor vehicle sources in Los Angeles County ("06037")
# Which city has seen greater changes over time in motor vehicle emissions?

# Get only the Baltimore and LA data
# and rename the codes with proper names
data <- subset(data, fips %in% c("24510", "06037"))
data[data$fips=="24510","fips"] <- "Baltimore City"
data[data$fips=="06037","fips"] <- "Los Angeles County"

# Prepare for png output
png(filename = "plot6.png",
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
  facet_grid(cols = vars(fips)) +
  labs(x = "", y="Emissions (tons)", title = "Comparison of motor vehicles PM2.5 emissions")

dev.off()