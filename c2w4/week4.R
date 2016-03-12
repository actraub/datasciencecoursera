best <- function(state, outcome) {
    
    outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
        subset(outcome, outcome$State == state & head)
    outcome$Hospital.Name
    ## Read outcome data
    ## Check that state and outcome are valid
    ## Return hospital name in that state with lowest 30-day death
    ## rate
}
