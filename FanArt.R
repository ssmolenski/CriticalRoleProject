library(twitteR)
library(RCurl)
library(stringr)
library(XML)

TwitConnect()

Talks<-getUser("TalksMachina")

userTimeline(Talks, n=15, excludeReplies=TRUE) %>%
sapply(function(x) x$getText()) -> tweet
index<-grep("Congratulations on winning FanArt of the Week!", tweet)
tweet<-tweet[index]

if(length(tweet)>1){
    tweet=tweet[1]
}

id<-id(tweet)

load("likesandrts.Rda")






