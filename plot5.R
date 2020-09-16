## This first line will likely take a few seconds. Be patient!
rawdata <- readRDS("data/summarySCC_PM25.rds")
# Reference
SCC <- readRDS("data/Source_Classification_Code.rds")

# We remove the pollutant column:
# a call to unique() shows always the same value "PM25-PRI"
data <- rawdata[,-c(3)]

# How have emissions from motor vehicle sources changed
# from 1999–2008 in Baltimore City?

data <- subset(data, fips == "24510") # Baltimore City code

# Get the Motor vehicle related SCC codes 
motor <- grep("Motor|Vehicle", SCC$Short.Name)
motorcodes <- as.character(SCC[motor,"SCC"])

data <- data[data$SCC %in% motorcodes,]
# Prepare for png output
png(filename = "plot5.png",
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
  labs(x = "", y="Emissions (tons)", title = "PM2.5 emissions from motor vehicles in Baltimore City")

dev.off()