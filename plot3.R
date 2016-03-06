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

png("plot3.png")
plot(d$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="", xaxt='n', col="black")
lines(d$Sub_metering_2, col="red")
lines(d$Sub_metering_3, col="blue")
axis(side=1, at=c(0,nrow(d)/2,nrow(d)), labels=c("Thu","Fri","Sat"),tick=TRUE, xlim=nrow(d))
par("ps"=10)
legend(col=c("black","red","blue"),c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), x="topright", seg.len=4, lty = c(1, 1, 1), pch = c(NA, NA, NA))
dev.off();