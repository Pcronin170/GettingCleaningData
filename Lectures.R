##Getting and Cleaning Data Notes

#Data are values of a qualitative or quantitaive variables belonging 
#to a set of items


##############################
#Downloading files
##############################

#Relative setwd("./data"), setwd("../")
#move up and down

#file.exists("directoryName")
#dir.create("directoryName")

setwd("h:/coursera/GettingCleaningData")
getwd()

#Create data directory if it doesn't already exist
if(!file.exists("data")){
    dir.create("data")
}

#download.file() to download files from the internet
#url, destfile (desination), method

fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl,destfile = "./data/cameras.csv")
list.files("./data")

#Record download
dateDownLoaded <- date()

#######################################
#Reading local flat files
#######################################

#read.table()
cameraData <- read.table("./data/cameras.csv",sep=",",header = TRUE)
head(cameraData)


#######################################
#Read Excel files
#######################################

#download baltimore camera data with excel
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.xls?accessType=DOWNLOAD"
download.file(fileUrl,destfile = "./data/cameras.xls")
list.files("./data")
library(xlsx)
cameraData <- read.xlsx("./data/cameras.xls",sheetIndex=1,header=TRUE)
dateDownLoaded <- date()

#Read specific rows and columns
colIndex <- 2:3
rowIndex <- 1:4

#write.xlsx can write out excel files
#XLConnect to write and manipulate excel files


#######################################
#Reading XML
#######################################
library(XML)
fileUrl <- "http://www.w3school.com/xml/simple.xml"
doc <- xmlTreeParse(fileUrl,useInternal = TRUE)
rootNote <- xmlRoot(doc)
xmlName(rootNote)

#######################################
#Reading JSON
#######################################
library(jsonlite)
jsonData <- fromJSON("https://api.github.com/users/jtleek/repos")
names(jsonData)
names(jsonData$owner)

#Make json file
myjson <- toJSON(iris,pretty=TRUE)
cat(myjson)

iris2 <- fromJSON(myjson)
head(iris2)

#######################################
#data.table
#######################################

#
library(data.table)

#Make Data Frame
df <- data.frame(x=rnorm(9),y=rep(c("a","b","c"),each=3),z=rnorm(9))
head(df)

#Make Data table
dt <- data.table(x=rnorm(9),y=rep(c("a","b","c"),each=3),z=rnorm(9))
head(df)

#See all tables in memory
tables()

#subset rows
dt[2,]

#All rows where column y = "a"
dt[dt$y == "a",]

#Subset rows
dt[c(2,3),]

#One index subsets on row
dt[c(2,3)]

#Subsetting columns don't work the same

#Pas names of funcitons to do stuff to variables
dt[,list(mean(x),sum(z))]

dt[,table(y)]

#Add new columns (doesn't create new copies of data)
dt[,w:=z^2]

#Be careful setting data table will change for assignments
#Need to make a copy with copy function to add new to memore

#Perform multiple step functions make new vvariables
dt[,m:={tmp<-(x+z);log2(tmp +5)}]
dt

#Plyr like operations
dt[,a:=x>0]

dt[,b:=mean(x+w),by=a]
dt

#Group by counts
set.seed(123);
DT <- data.table(x=sample(letters[1:3],1E5,TRUE))
DT[,.N,by=x]

#Keys
DT <- data.table(x=rep(c("a","b","c"),each=100),rnorm(300))
setkey(DT,x)
DT['a'] #a quoted thing is the key

#Joins
dt1 <- data.table(x=c('a','a','b','dt1'),y=1:4)
dt2 <- data.table(x=c('a','b','dt2'),z=5:7)
setkey(dt1,x);setkey(dt2,x)
dt1
dt2
dt3<-merge(dt1,dt2)
dt3
dt2

#Fast reading from disk
big_df <- data.frame(x = rnorm(1E6),y = rnorm(1E6))
file <- tempfile()
write.table(big_df,file=file,row.names=FALSE,col.names = TRUE,sep="\t",quote=FALSE)
system.time(fread(file))

system.time(read.table(file,header=TRUE,sep="\t"))


