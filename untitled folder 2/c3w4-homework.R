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
    DT
    
}

