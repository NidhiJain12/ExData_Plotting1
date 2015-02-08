#CODE FOR PLOT4

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
png(file="plot4.png", width=480, height=480)

#Draw Graph
#Set up the graph parameters, set up a table of 2 by 2 to draw 4 graphs
par(mfrow=c(2,2))

#Start Plotting all the graphs together

with(subData, {
                plot(DateTime,as.numeric(levels(V3))[V3],type = "l",ylab="Global Active Power",xlab=" ");
                plot(DateTime, as.numeric(levels(V5))[V5], type="l", xlab="datetime", ylab="Voltage");
                plot(DateTime, as.numeric(levels(V7))[V7], type="l",col="black", xlab="", ylab="Energy sub metering");
                  lines(DateTime, as.numeric(levels(V8))[V8],col="red");
                  lines(DateTime, as.numeric(levels(V9))[V9],col="blue");
                  legend("topright",lty=1,col=c("black","red","blue"),bty="n",cex=0.8, legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"));
                plot(DateTime, as.numeric(levels(V4))[V4],type="l", xlab="datetime", ylab="Global_reactive_power")
               })

#Close the gr Device
dev.off()