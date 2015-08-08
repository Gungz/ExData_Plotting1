require(data.table)
household_power_consumption <- fread("household_power_consumption.txt", header = TRUE, sep = ";", data.table = TRUE, na.strings = "?", stringsAsFactors = FALSE)
household_power_consumption <- household_power_consumption[,DateTime:=paste(Date, Time)]
household_power_consumption$Date <- as.Date(x = household_power_consumption$Date, format = "%d/%m/%Y")
household_power_consumption_filtered <- household_power_consumption[Date %between% c(as.Date("2007-02-01"), as.Date("2007-02-02")),]
household_power_consumption_filtered <- household_power_consumption_filtered[, Global_active_power:=as.numeric(Global_active_power)]
household_power_consumption_filtered <- as.data.frame(household_power_consumption_filtered) 
household_power_consumption_filtered$Real_DateTime <- strptime(household_power_consumption_filtered$DateTime, format = "%d/%m/%Y %H:%M:%S")
with(household_power_consumption_filtered, plot(Real_DateTime, Sub_metering_1, type = "s", xlab = "", main = "", ylab = "Energy sub metering"))
with(household_power_consumption_filtered, points(Real_DateTime, Sub_metering_2, type = "s", col="Red"))
with(household_power_consumption_filtered, points(Real_DateTime, Sub_metering_3, type = "s", col="Blue"))
legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd=1)
dev.copy(png, file="plot3.png")
dev.off()