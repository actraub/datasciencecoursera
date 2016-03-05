
## homework for Coursera Programming - R Programming Week 2

pollutantmean <- function (directory="specdata", pollutant="nitrate", id=1:332) {
  #calculates the mean of a pollutant (sulfate or nitrate) across a specified list of monitors
  
    dir_list <- list.files(directory, full.names=TRUE) # save dir to variable
    dir_list <-dir_list[id] # filter out unwanted ones
  
    new_matrix <- data.frame()
    for (number in 1:length(dir_list)) {
        print (dir_list[number])
        new_matrix <- rbind ( new_matrix, read.csv (dir_list[number]))
    }
    #print(new_matrix)
    mean(new_matrix[,pollutant], na.rm =  TRUE)
}



complete <- function (directory, id=1:332) {
    dir_list <- list.files(directory, full.names=TRUE)
    result_matrix <- data.frame()
    for (number in id) {
        temp_file <- read.csv(dir_list[number])
        good_rows <-( NROW( temp_file[complete.cases(temp_file),]))
        temp <- data.frame(number, good_rows)
        result_matrix <- rbind (result_matrix, temp)
    }
    # print (result_matrix)
    result_matrix
}


corr <- function (directory, threshold=0) {
    dir_list <- list.files(directory, full.names=TRUE)
    results_vector = c()
    for (number in 1:length(dir_list)) {
        
        temp_file <- read.csv(dir_list[number])
        # print ("apple")
        # print (temp_file)
        # print ("2apple")
        good_rows <-( NROW( temp_file<-temp_file[complete.cases(temp_file),]))
       
        if (good_rows > threshold) {
            #str (temp_file)
            #print(good_rows)
            tempV <- cor(temp_file$sulfate, temp_file$nitrate)
            # print (tempV)
            # temp <- class(tempV)
            # print (temp)
            results_vector <- append(results_vector, tempV )

            
            
        }
        
        # temp <- data.frame(number, good_rows)
        # result_matrix <- rbind (result_matrix, temp)
    }
    
    results_vector
    # print (result_matrix)
    # length(dir_list)
}

