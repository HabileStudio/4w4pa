## This first line will likely take a few seconds. Be patient!
data <- readRDS("data/summarySCC_PM25.rds")
# We remove the pollutant column:
# a call to unique() shows always the same value "PM25-PRI"
data <- data[,-c(3)]

SCC <- readRDS("data/Source_Classification_Code.rds")

# Plot the total PM2.5 emissions from all sources
# for each of the years 1999, 2002, 2005, and 2008

# subset the years we want
years <- c(1999,2002,2005,2008)
data <- subset(data, year %in% years)
# aggregate per year
yearly <- with(data, tapply(Emissions, year, FUN=sum))
# we divide values by one million to make it more readable
# we'll label the axis to say the units are in million tons
yearly <- yearly / 1000000

# Prepare for png output
png(filename = "plot1.png",
    width = 480, height = 480,
    units = "px")

# Plot
barplot(yearly,
     main="Yearly pm2.5 emissions in the USA",
     col="red",
     ylim=c(0,8),
     xlab="Years",
     ylab="Total emissions (million tons)")

dev.off()