require(data.table)
household_power_consumption <- fread("household_power_consumption.txt", header = TRUE, sep = ";", data.table = TRUE, na.strings = "?", stringsAsFactors = FALSE)
household_power_consumption <- household_power_consumption[,DateTime:=paste(Date, Time)]
household_power_consumption$Date <- as.Date(x = household_power_consumption$Date, format = "%d/%m/%Y")
household_power_consumption_filtered <- household_power_consumption[Date %between% c(as.Date("2007-02-01"), as.Date("2007-02-02")),]
household_power_consumption_filtered <- household_power_consumption_filtered[, Global_active_power:=as.numeric(Global_active_power)]
household_power_consumption_filtered <- as.data.frame(household_power_consumption_filtered) 
household_power_consumption_filtered$Real_DateTime <- strptime(household_power_consumption_filtered$DateTime, format = "%d/%m/%Y %H:%M:%S")

par(mfrow = c(2, 2))

with(household_power_consumption_filtered, {
     plot(Real_DateTime, Global_active_power, type = "l", xlab = "", main = "", ylab = "Global Active Power", cex.lab = 0.7, cex.axis = 0.7)
     plot(Real_DateTime, Voltage, type = "l", xlab = "datetime", main = "", ylab = "Voltage", cex.lab = 0.7, cex.axis = 0.7)
     plot(Real_DateTime, Sub_metering_1, type = "s", xlab = "", main = "", ylab = "Energy sub metering", cex.lab = 0.7, cex.axis = 0.7)
     points(Real_DateTime, Sub_metering_2, type = "s", col="Red")
     points(Real_DateTime, Sub_metering_3, type = "s", col="Blue")
     legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd=1, bty = "n", cex = 0.7, xjust = 0.5)
     plot(Real_DateTime, Global_reactive_power, type = "S", xlab = "datetime", main = "", ylab = "Global_reactive_power", ylim = c(0.0, 0.5), cex.lab = 0.7, cex.axis = 0.7 )
})

dev.copy(png, file="plot4.png")
dev.off()