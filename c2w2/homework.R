
## homework for Coursera Programming - R Programming Week 2

pollutantmean <- function (directory="specdata", pollutant="nitrate", id=1:333) {
  #calculates the mean of a pollutant (sulfate or nitrate) across a specified list of monitors

  dir_list <- list.files(full.names=TRUE)
  ldf <- lapply(dir_list, read.csv, header=TRUE)
  #ldf<-read.csv("001.csv")

  mean(ldf[[pollutant]], na.rm=TRUE)
}


