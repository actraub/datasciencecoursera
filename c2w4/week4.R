# Returns the best hospital in a state (e.g. NY, SC, etc) for "Heart Attack", "Heart Failure", "Pneumonia"
# By Aaron Traub march 12 2016

# best("TX", "heart failure")
# best("MD", "Heart Attack"

best <- function(state, outcome) {
    ## Read outcome data
    df <- read.csv("outcome-of-care-measures.csv", colClasses = "character")

    ## Check that state and outcome are valid
    if ((state %in% df$State ) & (outcome %in% c("Heart Attack", "heart failure", "Pneumonia"))) {
        
        re_from <- "\\b([[:lower:]])([[:lower:]]+)"
        outcome <- gsub(re_from, "\\U\\1\\L\\2", outcome , perl=TRUE)
        
        # add a '.' if there is a ' '
        outcome <- sub ("[ ]", ".", outcome) 
        
        #get column name to look at
        outcome <- paste ("Hospital.30.Day.Death..Mortality..Rates.from.", outcome, sep = "")
        
        # get the proper columns
        df.state <- subset(df, df$State == state)
        
        #return hospital with the mex value for the column
        df.state.hospital <- df.state[which.min(df.state[[outcome]]), "Hospital.Name"]
        df.state.hospital
    } else {
        stop("Invalid type" )
    }
}


###########################################
#The function reads the outcome-of-care-measures.csv file and returns a character vector with the name
#of the hospital that has the ranking specified by the num argument. For example, the call


# > rankhospital("TX", "heart failure", 4)
# [1] "DETAR HOSPITAL NAVARRO"

# > rankhospital("MD", "heart attack", "worst")
# [1] "HARFORD MEMORIAL HOSPITAL"

# > rankhospital("MN", "heart attack", 5000)
# [1] NA



rankhospital <- function(state, outcome, num = "best") {
    ## Read outcome data
    df <- read.csv("outcome-of-care-measures.csv", colClasses = "character", na.strings="Not Available")
    ## Check that state and outcome are valid

    #Capitalizes first letter of each word
    re_from <- "\\b([[:lower:]])([[:lower:]]+)"
    outcome <- gsub(re_from, "\\U\\1\\L\\2", outcome , perl=TRUE)
    
    # add a '.' if there is a ' '
    outcome <- sub ("[ ]", ".", outcome) 
    
    #get column name to look at
    outcome <- paste ("Hospital.30.Day.Death..Mortality..Rates.from.", outcome, sep = "")
    
    # get the proper ROWS
    df.state <- subset(df, df$State == state)
    df.state <- na.omit(df.state)
    df.state <- df.state[ order( as.numeric(df.state[[outcome]]), df.state[["Hospital.Name"]], decreasing=FALSE), ]
    if (num == "best") {
        print("best")
        num <- 1
    } else if (num == "worst") {
        print("worst")
        num <- nrow(df.state)
    } else if ( num <= nrow(df.state)) {
        print(num)
    } else {
        print("1")
        stop("problemo****")
    }
    df.state[num, "Hospital.Name"]
}
  




# The function reads the outcome-of-care-measures.csv file and returns a 2-column data frame
# containing the hospital in each state that has the ranking specified in num.

# head(rankall("heart attack", 20), 10)
# tail(rankall("pneumonia", "worst"), 3)
# tail(rankall("heart failure"), 10)

rankall <- function(outcome, num = "best") {
    df <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    ## Check that state and outcome are valid
    
    #Capitalizes first letter of each word
    re_from <- "\\b([[:lower:]])([[:lower:]]+)"
    outcome <- gsub(re_from, "\\U\\1\\L\\2", outcome , perl=TRUE)
    # add a '.' if there is a ' '
    outcome <- sub ("[ ]", ".", outcome) 
    #get column name to look at
    outcome <- paste ("Hospital.30.Day.Death..Mortality..Rates.from.", outcome, sep = "")
    resultsDF <- data.frame(stringsAsFactors = FALSE)
    states <- unique(df$State)
    print(class(states))
    for (state in states) {
        df.state <- data.frame( stringsAsFactors = FALSE)
        df.state <- subset(df, df$State == state)
        df.state <- df.state[ order( as.numeric(df.state[[outcome]]), df.state[["Hospital.Name"]], decreasing=FALSE), ]
        temp.vector <- data.frame( stringsAsFactors = FALSE)
        if (num == "best") {
            num <- 1
        } else if (num == "worst") {
            num <- nrow(df.state)
        }
        temp.vector <- c(df.state[num, "Hospital.Name"], state)
   
        
        # as.vector(temp.vector)
        # print(dim(temp.vector))
        # print (temp.vector)
        resultsDF <- rbind(resultsDF, temp.vector ) 
        resultsDF[] <- lapply(resultsDF, as.character)
        
        # resultsDF[,c(df.state[num, "Hospital.Name"], state)] <- sapply(resultsDF[,c(df.state[num, "Hospital.Name"], state)],as.character) 
        # print (resultsDF)
        #http://stackoverflow.com/questions/24447877/invalid-factor-level-na-generated-when-pasting-in-a-dataframe-in-r
    }
    colnames(resultsDF) <- c("Hospital", "state")
    
    resultsDF
}

#Helper function to return the rank of a single state

    