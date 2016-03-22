# cleaning data week 1 homework 
library("data.table")
library("xlsx")
library("XML")

getData <- function (){
    url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
    download.file(url, "housing_data.csv", method = "curl")
    DT <- data.table()
    DT <-  read.table ("housing_data.csv", sep=",", header=TRUE)
    x <- DT$VAL[DT$VAL == 24]
    Y <- complete.cases( x )
    z <-  as.numeric(Y)
    print( sum(z) )  #53
    f <- DT$FES
    f
}

#q2 Each tidy data table contains information about only one type of observation.


getXLSX <- function() {
    #18-23 and columns 7-15
    rowIndex <- 18:23
    colIndex <- 7:15
    url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
    download.file(url, "NGAP.XLS", method = "curl")
    dateDownloaded <- date()
    DT <- data.table()
    dat <- read.xlsx ("NGAP.XLS", sheetIndex = 1, header=TRUE, colIndex = colIndex, rowIndex = rowIndex)
    sum(dat$Zip*dat$Ext,na.rm=T) # 36534720
}


getBalt <- function() {
    #How many restaurants have zipcode 21231
    url <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
    # download.file(url, "restaurants.xml", method = "curl")
    # dateDownloaded <- date()
    
    doc <- xmlTreeParse(url, useInternal=TRUE)
    rootNode <- (xmlRoot(doc))
    # xmlName (rootNode)
   # xmlSApply(rootNode, xmlValue)
    y <- xpathSApply(rootNode, "//row[zipcode='21231']", xmlValue) #127
    y
}


timerFunc <- function () {
    url <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
    download.file(url, "fss_pid.csv", method = "curl")
    DT <-  fread ("fss_pid.csv", sep=",", header=TRUE)
    
    print("1")
    system.time(DT[,mean(pwgtp15),by=SEX])
    #user  system elapsed 
    #0.002   0.000   0.002 
    
    print("2")
    system.time({
        rowMeans(DT)[DT$SEX==1]
        rowMeans(DT)[DT$SEX==2]
    })
    # 
    # print("3")
    # print( { mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)})
    #  system.time({
    #     mean(DT[DT$SEX==1,]$pwgtp15)
    #     mean(DT[DT$SEX==2,]$pwgtp15)
    # })
    # 
    # print("4")    
    # print (tapply(DT$pwgtp15,DT$SEX,mean))
    # system.time(tapply(DT$pwgtp15,DT$SEX,mean))
    # #user  system elapsed
    # #0.002   0.000   0.002
    # 
    # print("5")
    # print(mean(DT$pwgtp15,by=DT$SEX))
    # system.time(mean(DT$pwgtp15,by=DT$SEX))
    # # user  system elapsed
    # # 0.000   0.000   0.001
    # 
    # print("6")
    # print(sapply(split(DT$pwgtp15,DT$SEX),mean))
    # system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
    # #user  system elapsed
    # #0.001   0.000   0.001
}


qfun <- function () { # second question
    rowMeans(DT)[DT$SEX==1] 
    rowMeans(DT)[DT$SEX==2]
}

mfun <- function (){
    mean(DT[DT$SEX==1,]$pwgtp15)
    mean(DT[DT$SEX==2,]$pwgtp15)
    
}
