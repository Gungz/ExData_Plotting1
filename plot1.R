require(data.table)
household_power_consumption <- fread("household_power_consumption.txt", header = TRUE, sep = ";", data.table = TRUE, na.strings = "?", stringsAsFactors = FALSE)
household_power_consumption$Date <- as.Date(x = household_power_consumption$Date, format = "%d/%m/%Y")
household_power_consumption_filtered <- household_power_consumption[Date %between% c(as.Date("2007-02-01"), as.Date("2007-02-02"))]
household_power_consumption_filtered <- household_power_consumption_filtered[, Global_active_power:=as.numeric(Global_active_power)]
hist(household_power_consumption_filtered$Global_active_power, xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "Red", main = "Global Active Power")
dev.copy(png, file="plot1.png")
dev.off()