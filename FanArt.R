FAotW <- function(){
    TwitConnect()
    Talks<-getUser("TalksMachina")
    tweets<-userTimeline(Talks, n=15, excludeReplies=TRUE)
    tweettext<-sapply(tweets,function(x) x$getText()) 
    index <- grep("Congratulations on winning FanArt of the Week!", tweettext)
    tweet <- tweets[index]
    id<-twitteR::id(tweet[[1]])
    return(id)
}








