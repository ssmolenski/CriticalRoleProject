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
source("C:\\Users\\Sarah\\Documents\\DataScience\\TwitConnect.R")

###############################################################################

#Date
date<-today()


#Load previous data
if(file.exists("likesandrts.Rda")){
    load("likesandrts.Rda")
}else{
    likesandrts<-data.frame("ID"=character(),
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


#Get new tweets
TwitConnect()
CR_art<-searchTwitter("#criticalroleart",n=2000,resultType="recent",lang="en", since=as.character(date-1))
CR_fanart<-searchTwitter("#criticalrolefanart",n=5000,resultType="recent",lang="en", since=as.character(date-1))
tweets<-c(strip_retweets(CR_art), strip_retweets(CR_fanart))

#Initialize the dataframe
artstats<-data.frame(ID=sapply(tweets,twitteR::id), User=sapply(tweets, screenName))
artstats<-unique(artstats)
artstats<-cbind(artstats, Date=rep(date,times=(dim(artstats)[1])))

#Get URLs
urls<-getURLs(tweets=tweets)

#Eliminate Duplicates
urls<-unique(urls)

#Get HTML Code
htmlCode<-list(0)
for (i in 1:length(urls)){
    con=url(urls[i])
    htmlCode[[i]]=readLines(con)
    close(con)
}

#Get likes, retweets, and castlikes
castnames<-names(likesandrts)[6:16]
likes<-numeric(0)
rts<-numeric(0)
castlikes<-numeric(0)
data<-data.frame(0)

for (i in 1:length(htmlCode)){
    Likes<-getLikes(htmlCode[[i]])
    RTs<-getRTs(htmlCode[[i]])
    castlikes<-getActors(htmlCode[[i]])
  
    data.frame(Likes, RTs, castlikes, castnames) %>%
    spread(key=castnames, value=castlikes) %>%
    rbind(FAotW=FALSE) -> df


    if(data==0){data=df}
    else{data<-rbind(data,df)}
    
}

artstats<-cbind(artstats,data)

# Filter out the chain-posts because I have no acurate way of collecting that data
artstats<-filter(artstats,
        Ashley.Johnson<=1,
        Brian.W..Foster<=1,
        Critical.Role<=1,
        Laura.Bailey<=1,
        Liam.O.Brien<=1,
        Marisha.Ray<=1,
        Matthew.Mercer<=1,
        Sam.Riegel<=1,
        Talisen.Jaffe<=1,
        Talks.Machina<=1,
        Travis.Willingham<=1)



rbind(likesandrts, artstats) %>%
arrange(ID, Date) -> likesandrts
save(file="likesandrts.Rda", likesandrts)