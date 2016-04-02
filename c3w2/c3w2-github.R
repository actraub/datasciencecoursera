#httr package
library("httr")

#Client ID: 33e5ee6d50f0cc285f54
#Client Secret: 585e93ccbced07697d2abe76dfdd249d841ba213
#Personal Access Token: f0d42278dff8da6c1aa91e3803e2f0e6d45b2142


#https://github.com/login/oauth/authorize?client_id=33e5ee6d50f0cc285f54&scope=&redirect_uri=urn%3Aietf%3Awg%3Aoauth%3A2.0%3Aoob&response_type=code 
gAccess <- function() {
    oauth_endpoints("github")
    redirect_uri <- "http://localhost:1410"
    options(httr_oauth_cache=FALSE)
        myapp <- oauth_app("github",
                key = "33e5ee6d50f0cc285f54",
                secret = "51b8e4dfd2a0607187b8f3e12ccedcccf3922f3a")
    github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)
    
    gtoken <- config(token = github_token)
    req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
    stop_for_status(req)
    json1 <- content(req)
    json2 <- jsonlite::fromJSON(jsonlite::toJSON(json1))
    json2[ json2$name == "datasharing", ]
    #2013-11-07T13:25:07Z
 
        # content(req)
    # print(req)
}


# require(httr)
# ## Loading required package: httr
# github.app <- oauth_app("github","33e5ee6d50f0cc285f54", "585e93ccbced07697d2abe76dfdd249d841ba213")
# github.urls <- oauth_endpoint(NULL, "authorize", "access_token",base_url = "https://github.com/login/oauth")
# github.token <- oauth2.0_token(github.urls,github.app)


q2 <- function() {
    acs <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
    download.file(acs, "American-community-survey.csv", method = "curl")
    # DT <- data.table()
    DT <-  read.table ("American-community-survey.csv", sep=",", header=TRUE)
    # dbSendQuery()
    sqldf("select pwgtp1 from acs where AGEP < 50")
    
}
library(XML)
library(httr)

q4 <- function() {
    lines <- c(10,20,30,100)
    loc <- "http://biostat.jhsph.edu/~jleek/contact.html"
    myurl <- GET(loc)
    doc.html <- content(myurl, as="text")
    parsedHTML <- htmlParse(doc.html, asText=T, ignoreBlanks=FALSE)
    # print(parsedHTML)
    results <- sapply(parsedHTML[lines], nchar)
    # nchar(capture.output(parsedHTML)[10])
            
}
    # con <- url("http://biostat.jhsph.edu/~jleek/contact.html")
    # tempLine <- readLines(con)
    # templine
    # other approach
    # doc.html = htmlTreeParse('http://biostat.jhsph.edu/~jleek/contact.html', 
                             # useInternal = TRUE, ignoreBlanks=FALSE)
    # capture.output(doc.html)
    # nchar(capture.output(doc.html)[10])
    # capture.output(doc.html)[1:15]
        

    # con = url("http://biostat.jhsph.edu/~jleek/contact.html")
    # htmlCode = readLines(con)
    # htmlCode[10]

q5 <- function() {
    loc <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
    x <- read.fwf(loc, skip=5,
            widths=c(12, 7, 4, 9, 4, 9, 4, 9, 4))
    x
    sum(x[,4])
    # close(x)
     # myurl <- url(loc)
    # htmlCode <- readLines(myurl)
    # close(myurl) 
    # 
    # htmlCode[1:20]
  
    
}


