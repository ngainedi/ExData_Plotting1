## Code for creating Plot2
## Assumptions:
##  1. The input data set is available in the working directory

## Script contains two parts
##  1. Loading the dataset, naming variable, casting datatypes
##  2. Plotting the graph and saving to a device

## Function to load data
loadData <- function() {
  working_dir = getwd()
  file = paste0(working_dir, '/household_power_consumption.txt')
  
  df = read.delim2(file, header=TRUE, sep=';', 
                   stringsAsFactors=FALSE,
                   na.strings='?')
  
  names(df) <-  c('Date','Time', 'Global_active_power','Global_reactive_power', 
                  'Voltage', 'Global_intensity', 'Sub_metering_1', 
                  'Sub_metering_2', 'Sub_metering_3')
  df$Date <- as.Date(df$Date, '%d/%m/%Y') 
  
  # Filter the data set to retrive data for 2 days
  get.rows <- df$Date==as.Date('2007-02-01','%Y-%m-%d') | 
              df$Date==as.Date('2007-02-02','%Y-%m-%d')
  df <- df[get.rows,] 
  
  # Set datatypes for the variables used in the plots
  df$Time <- strptime(paste(df$Date, df$Time), '%Y-%m-%d %H:%M:%S')
  df$Global_active_power <- as.numeric(df$Global_active_power)
  df$Global_reactive_power <- as.numeric(df$Global_reactive_power)
  df$Voltage <- as.numeric(df$Voltage)
  df$Global_intensity <- as.numeric(df$Global_intensity)
  df$Sub_metering_1 <- as.numeric(df$Sub_metering_1)
  df$Sub_metering_2 <- as.numeric(df$Sub_metering_2)
  df$Sub_metering_3 <- as.numeric(df$Sub_metering_3)  
}


loadData() #Invoke function to load data
png('plot2.png', width=480, height=480) #Open a PNG device
with(df, plot(Time, Global_active_power, 
              type='l', 
              xlab='',
              ylab='Global Active Power (kilowatts)'))
dev.off() #Close the device
