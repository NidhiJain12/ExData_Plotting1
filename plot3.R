#CODE FOR PLOT3

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
png(file="plot3.png", width=480, height=480)

#Draw Graph
#Plotting sub metering 1 and then adding sub metering 2 and 3 as lines (annotaion)

with(subData, {plot(DateTime,as.numeric(levels(V7))[V7],type = "l",ylab="Energy sub metering",xlab=" ");
               lines(DateTime, as.numeric(levels(V8))[V8],col="red");
               lines(DateTime, as.numeric(levels(V9))[V9],col="blue")
               })

#Adding Legend
legend("topright",lty=1,col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#Close the gr Device
dev.off()