## This first line will likely take a few seconds. Be patient!
rawdata <- readRDS("data/summarySCC_PM25.rds")
# Reference
SCC <- readRDS("data/Source_Classification_Code.rds")

# We remove the pollutant column:
# a call to unique() shows always the same value "PM25-PRI"
data <- rawdata[,-c(3)]

# Across the United States, how have emissions
# from coal combustion-related sources changed from 1999–2008?

# Get the coal combustion related SCC codes 
coal <- grep("Coal.*Combustion", SCC$Short.Name)
coalcodes <- SCC[coal,"SCC"]

data <- data[data$SCC %in% coalcodes,]
# Prepare for png output
png(filename = "plot4.png",
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
  labs(x = "", y="Emissions (tons)", title = "PM2.5 emissions from coal combustion")

dev.off()