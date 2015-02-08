#CODE FOR PLOT1

#Understanding the classes of columns in the text file
data <- read.table("household_power_consumption.txt",nrows = 1000,sep=";")
classes <- sapply(data,class)

#Open File handler
fileH <- file("household_power_consumption.txt","r")

#Read the subset of the data for the dates 2007-02-01 and 2007-02-02
subData <- read.table(text = grep("^[1,2]/2/2007",readLines(fileH),value=TRUE),sep=";",colClasses = classes, na.strings="?")

#Convert the Date and Time variables to Date/Time classes in R
DateTime <- paste(subData$V1, subData$V2)
#Add a new column with combined datetime values
subData$DateTime <- strptime(DateTime,"%d/%m/%Y %H:%M:%S")

# Write to a PNG File
#Open PNG file device
png(file="plot1.png",width=480, height=480)

#Draw Graph
hist(as.numeric(levels(subData$V3))[subData$V3], col="red", xlab = "Global Active Power (kilowatts)",ylab="Frequency", main="Global Active Power")

#Close the gr Device
dev.off()