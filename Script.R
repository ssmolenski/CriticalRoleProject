library(twitteR)
library(RCurl)
library(stringr)
library(XML)
library(lubridate)
library(dplyr)
library(tidyr)

setwd("C:\\Users\\Sarah\\Documents\\DataScience\\Twitter")
source("getLikes.R")
source("getRTs.R")
source("getActors.R")
source("getURLs.R")
source("getTweetData.R")
source("NewTweets.R")
source("Update.R")
source("C:\\Users\\Sarah\\Documents\\DataScience\\TwitConnect.R")

###############################################################################
if(file.exists("data.Rda")){
    load("data.Rda")
    print("updating data")
    updated <- Update("data.Rda")
    print("combining data")
    data <- rbind(data, updated)
    
}else{
    data<-data.frame("ID"=character(),
                        "User"=character(),              
                        "Date"=as.Date(character()),   
                        "Likes"=numeric(),
                        "RTs"=numeric(),  
                        "Ashley.Johnson"=numeric(),    
                        "Brian.W..Foster"=numeric(),
                        "Critical.Role"=numeric(),
                        "Laura.Bailey"=numeric(),
                        "Liam.O.Brien"=numeric(),                            "Marisha.Ray"=numeric(),
                        "Matthew.Mercer"=numeric(),
                        "Sam.Riegel"=numeric(),
                        "Talisen.Jaffe"=numeric(),
                        "Talks.Machina" =numeric(),
                        "Travis.Willingham"=numeric(),
                        FAotW=logical())

}

print("0")
date <- today()
print("1")
new <- NewTweets(date)
print("2")
suppressWarnings(data<-rbind(data,new))
print("3")

save(file="data.Rda", data)

