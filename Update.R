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
source("readhtml.R")

###############################################################################

load("likesandrts.Rda")
date<-today()

updated<-data.frame(ID=sapply(tweets,twitteR::id), 
                    User=sapply(tweets, screenName))
updated<-unique(updated)
updated<-cbind(updated, Date=rep(date,times=(dim(updated)[1])))

urls<-getURLs(IDs=updated$ID, users=updated$User)

#Get HTML Code
htmlCode<-list(0)
for (i in 1:length(urls)){
    con=url(urls[i])
    htmlCode[[i]]=readLines(con)
    close(con)
}

rbind(likesandrts, updated) %>%
arrange(ID, Date) -> likesandrts
save(file="likesandrts.Rda", likesandrts)