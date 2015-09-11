#Getting and Cleaning Data
#Quiz 1

setwd("h:/coursera/GettingCleaningData")


##############################
#Question1
##############################

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl,destfile = "./data/IdahoHousing.csv")
list.files("./data")

#read.table()
housing <- read.table("./data/IdahoHousing.csv",sep=",",header = TRUE)
head(housing)


#Idaho property valued over 1,000,000
library(data.table)
houseTable <- data.table(housing)
idahoMil <- houseTable[VAL == 24 & ST == 16]

houseTable[,table(FES)]

#############################
#Question 3
#############################
library(xlsx)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileUrl,destfile = "./data/gas.xlsx",method="curl")
list.files("./data")

gasData <- read.xlsx("./data/gasdata.xlsx",sheetIndex="NGAP Sample Data",header=TRUE,rowIndex = 18:23,colIndex = 7:15)

sum(gasData$Zip*gasData$Ext,na.rm=T)


#######################################
#Question 4
#######################################
library(XML)
url<- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
restaurant <- xmlTreeParse("./data/restaurants.xml",useInternal = TRUE)
rootNote <- xmlRoot(restaurant)
xmlName(rootNote)
names(rootNote)


xmlSApply(rootNote,xmlValue)

x <-xpathSApply(rootNote,"//zipcode",xmlValue)

x[x==21231]


xmlValue
