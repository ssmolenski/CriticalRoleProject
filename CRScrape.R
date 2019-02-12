CRScrape <- function(){
    library(twitteR)
    library(RCurl)
    library(stringr)
    library(XML)
    library(lubridate)
    library(dplyr)
    library(tidyr)

    setwd("C:\\Users\\Sarah\\Documents\\DataScience\\Twitter")
    source("NewTweets.R")
    source("Update.R")
    source("FanArt.R")
    source("C:\\Users\\Sarah\\Documents\\DataScience\\TwitConnect.R")

    ###############################################################################
    date <- today()

    if(file.exists("data.Rda")){
        cat("Loading existing data file...\n")
        load("data.Rda")
        lastid <- as.character(data$ID[[nrow(data)]])
        lastdate <- as.Date(data$Date[nrow(data)])
        if(lastdate!= date){
            cat("Updating tweet data...\n")
            data <- Update(data)
        }
    }else{
        cat("Creating new dataframe...\n")
        lastid <- 0
        data<-data.frame(   "ID"=character(),
                            "User"=character(),              
                            "Date"=as.Date(character()),   
                            "Likes"=numeric(),
                            "RTs"=numeric(),  
                            "Ashley.Johnson"=numeric(),    
                            "Brian.W..Foster"=numeric(),
                            "Critical.Role"=numeric(),
                            "Laura.Bailey"=numeric(),
                            "Liam.O.Brien"=numeric(),
                            "Marisha.Ray"=numeric(),
                            "Matthew.Mercer"=numeric(),
                            "Sam.Riegel"=numeric(),
                            "Talisen.Jaffe"=numeric(),
                            "Talks.Machina" =numeric(),
                            "Travis.Willingham"=numeric(),
                            FAotW=logical())

    }

    cat("Retrieving new tweets...\n")
    new <- NewTweets(lastid)
    data <- rbind(data,new)

    if(weekdays(date)=="Wednesday"){
        cat("Getting FAotW... \n")
        ID<-FAotW()
        data$FAotW[which(data$ID==ID)]=TRUE
    }

    cat("Saving files. \n")
    save(file="data.Rda", data)
    write.csv(data, file="data.csv")
}
