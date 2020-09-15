## This first line will likely take a few seconds. Be patient!
data <- readRDS("data/summarySCC_PM25.rds")
# We remove the pollutant column:
# a call to unique() shows always the same value "PM25-PRI"
data <- data[,-c(3)]

SCC <- readRDS("data/Source_Classification_Code.rds")

# Have total emissions from PM2.5 decreased
# in the Baltimore City, Maryland (fips: 24510) from 1999 to 2008?
data <- subset(data, fips == "24510" & year %in% c(1999,2008))

# aggregate per year
yearly <- with(data, tapply(Emissions, year, FUN=sum))
# we divide values by 1000 to make it more readable
# we'll label the y axis to say the units are in K tons
yearly <- yearly / 1000

# Prepare for png output
png(filename = "plot2.png",
    width = 480, height = 480,
    units = "px")

# Plot
barplot(yearly,
     main="Yearly pm2.5 emissions in the Baltimore City",
     col="red",
     ylim=c(0,4),
     xlab="Years",
     ylab="Total emissions (K tons)")

dev.off()