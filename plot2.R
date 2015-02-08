#CODE FOR PLOT2

#Understanding the classes of the columns in the file
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
png(file="plot2.png",width=480, height=480)

#Draw Graph
with(subData, plot(DateTime,as.numeric(levels(V3))[V3],type = "l",ylab="Global Active Power (kilowatts)",xlab=" "))

#Close the gr Device
dev.off()