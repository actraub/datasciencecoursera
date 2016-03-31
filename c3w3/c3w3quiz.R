#Aaron Traub
#C3w3 quiz

# Q1.
# The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:
#     https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv
# 
# and load the data into R. The code book, describing the variable names is here:
#     https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf
# 
# Create a logical vector that identifies the households on greater than 10 acres who sold more than $10,000 worth of agriculture products. 
# Assign that logical vector to the variable agricultureLogical. Apply the which() function like this to identify the rows of the data frame where the logical vector is TRUE.
# which(agricultureLogical)
# What are the first 3 values that result?

# Answer
# 125, 238,262


c3w3q1 <- function(){
    
    aturl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
    atfile <- "./data/USCommunities.csv"
    
    if (!file.exists("./data") ) {
        dir.create("./data")
    }
    
    if (!file.exists("./data/USCommunities.csv") ) {
        download.file(aturl, atfile, method="curl")
    }
    
    DT  <- read.csv(atfile)
  
    #ACR <- Lot size
        # 3 .House on ten or more acres
    #AGS <- Sales of Agriculture Products 
        # 6 .$10000+ 
    
   LV <- DT$ACR == 3 & DT$AGS == 6
    
    # LV <- DT[DT$ACR == 3 & DT$AGS == 6]
    DT <- which(LV)
    DT
}






# Q2.
# Using the jpeg package read in the following picture of your instructor into R
# https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg
# 
# Use the parameter native=TRUE. What are the 30th and 80th quantiles of the resulting data? (some Linux systems may produce an answer 638 different for the 30th quantile)
# 
# Answers:
# -15259150 -10575416


c3w3q2 <- function() {
    library(jpeg)
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg", "./data/jpeg.jpeg" )
    JP <- readJPEG("./data/jpeg.jpeg", native=T)
    quantile(JP, c(.30, .80))
}



# Q3:
# 
# Load the Gross Domestic Product data for the 190 ranked countries in this data set:
#     https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv
# 
# Load the educational data from this data set:
#     https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv
# 
# Match the data based on the country shortcode. How many of the IDs match? Sort the data frame in descending order by GDP rank (so United States is last). What is the 13th country in the resulting data frame?
# Original data sources:
#     http://data.worldbank.org/data-catalog/GDP-ranking-table
# 
# http://data.worldbank.org/data-catalog/ed-stats
# 
# 234 matches, 13th country is Spain
# 189 matches, 13th country is Spain
# 190 matches, 13th country is Spain
# 234 matches, 13th country is St. Kitts and Nevis
# 190 matches, 13th country is St. Kitts and Nevis
# 189 matches, 13th country is St. Kitts and Nevis


c3w3q3 <- function(){
    
    aturl1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
    aturl2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
    atfile1 <- "./data/FGDP.csv"
    atfile2 <- "./data/FEDSTATS_Country.csv"
    
    
    if (!file.exists("./data") ) {
        dir.create("./data")
    }
    
    if (!file.exists(aturl1) ) {
        download.file(aturl1, atfile1, method="curl")
    }
    if (!file.exists(aturl2) ) {
        download.file(aturl2, atfile2, method="curl")
    }
    
    DT1  <- read.csv(atfile1)
    DT2  <- read.csv(atfile2)
    
    mergedData <- merge(DT1, DT2, by.x="X", by.y="CountryCode")
    class(mergedData)

    class(mergedData)
    #library(dplyr)
    # mergedData %>% arrange(!is.na(Gross.domestic.product.2012), Gross.domestic.product.2012)
    # library(plyr)
    # mergedData <- arrange(mergedData,desc(mergedData$Gross.domestic.product.2012))
    # mergedData
    # 
    mergedData <- mergedData[, order(mergedData$Gross.domestic.product.2012)]
    
    # sort(mergedData,  mergedData$Gross.domestic.product.2012)
   print( mergedData )
}

