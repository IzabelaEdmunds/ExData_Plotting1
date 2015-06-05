## ---- RUNNING ENVIRONMENT ---- 

## Windows 7 (64-bit), R version 3.1.3, RStudio version 0.98.1103, 


## ---- WORKING SPACE ----

## Check if directory exists
if (!file.exists("data")) { 
    ## if directory does not exist create a directory "data" in the working directory
    dir.create("data") 
}


## ---- FILE DOWNLOAD ----

## Set URL target as variable "fileUrl"
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

## Download to "data" directory as "download.zip"
download.file(fileUrl, destfile = "./data/download.zip") 
## no "curl" as I am running this script on Windows 7



## ---- AUDIT TRAIL ----

## Record date and time of the download as an object "dateDownloaded"
dateDownloaded <- date()
## Print date and time of the download
print(dateDownloaded) 



## ---- FILE READ ----

## Unzip files
unzip("./data/download.zip", exdir = "./data")

## Read table into one variable from "data" specifying the separator character
power <- read.table("./data/household_power_consumption.txt", header = TRUE, sep = ";")



## ---- DATA CLEANING ----

## Subset into a new variable "power1" the data we will need for the plots 
## i.e. 1st and 2nd February 2007
power1 <- subset(power, Date %in% c("1/2/2007", "2/2/2007"))

## if we run str(power1) we can see all variables are factors
## so we need to convert variable "Date" to date and variable "Time" to time
## easier it so have it in one column so update the column "Date" to have it all in one column
power1$Date <- strptime(paste(power1$Date, power1$Time), format = "%d/%m/%Y %H:%M:%S")

## and change the column name to have the correct description
colnames(power1)[1] <- "Date_Time"

## Variable 3 to 8 we need to convert to numeric and convert "?" to NAs 
## (Variable 9 is already numeric class)
## I do not want to type long column names so substetting them by column number
power1[, 3] <- as.numeric((as.character(power1[, 3])))
power1[, 4] <- as.numeric((as.character(power1[, 4])))
power1[, 5] <- as.numeric((as.character(power1[, 5])))
power1[, 6] <- as.numeric((as.character(power1[, 6])))
power1[, 7] <- as.numeric((as.character(power1[, 7])))
power1[, 8] <- as.numeric((as.character(power1[, 8])))
## if we get "Warning message: NAs introduced by coercion" no problem as this is what we wanted.


## ---- PNG 2 ----

## save the file in your working directory
png("plot2.png", width = 480, height = 480, units = "px")


## ---- PLOT 2 ----

## plot for Global Active Power
plot(power1$Date_Time, power1$Global_active_power, 
     ylab = "Global Active Power (kilowatts)",  ## y label name
     xlab = "", ## no x label name
     type = "l" ## linear type
     )

## enable the default graphic device in R as it was changed by png() function
## i.e. close graphics device used to save the plot to png file
dev.off()