rm(list=ls())
#read file and filter in only the relevant dates
d <- read.csv("household_power_consumption.txt", sep=";", stringsAsFactors=FALSE);
d <- d[grep("^1/2/2007|^2/2/2007",d$Date),]
d$Date <- as.factor(as.character(d$Date))
row.names(d) <- 1: nrow(d)
#write.table(d, file="slim2.txt",sep = ";", quote = FALSE, row.names = FALSE,)
#d0 <- read.csv("slim.txt", sep=";");

#replace ? with NA and filter out NA rows
d[d=="?"] <- NA
d <- na.omit(d)

#create a POSIX datetime column 
d$tmstap <- paste(d$Date,d$Time,sep=" ")
d$dtstamp <- strptime(d$tmstap, format="%d/%m/%Y %H:%M:%S")
d$tmstap <- c()
d$Date <- d$dtstamp
d$dtstamp <- c()
d$Time <- c()

png("plot1.png")
hist(as.numeric(d$Global_active_power), main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", col="red", breaks=13, ylim=c(0,1200), xlim=c(0,6), xaxt='n')
axis(side=1, at=c(0,2,4,6), labels=c(0,2,4,6),tick=TRUE, xaxs="i")
dev.off()



