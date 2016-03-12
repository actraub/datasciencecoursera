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
   
        ## Return hospital name in that state with lowest 30-day death
    
    ## rate
}
