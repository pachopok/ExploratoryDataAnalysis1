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

png("plot2.png")
plot(d$Global_active_power, type="l", ylab="Global Active Power(Killowatts)", xlab="", xaxt='n')
axis(side=1, at=c(0,nrow(d)/2,nrow(d)), labels=c("Thu","Fri","Sat"),tick=TRUE, xlim=nrow(d))
dev.off()
