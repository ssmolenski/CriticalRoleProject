NewTweets <- function(date){
    #Get new tweets
    TwitConnect()
    suppressWarnings(
        CR_art <- searchTwitter("#criticalroleart",
                                n=2000,
                                resultType="recent",
                                lang="en", 
                                since=as.character(date-1))
    )
    suppressWarnings(
        CR_fanart <- searchTwitter("#criticalrolefanart",
                                n=5000,
                                resultType="recent",
                                lang="en", 
                                since=as.character(date-1))
    )

    tweets<-c(strip_retweets(CR_art), strip_retweets(CR_fanart))
    artstats<-data.frame(
                    ID=sapply(tweets,twitteR::id), 
                    User=sapply(tweets, screenName))
    artstats<-unique(artstats)
    artstats<-cbind(artstats, 
                    Date=rep(date,times=(dim(artstats)[1])), 
                    FAotW=rep(FALSE,times=(dim(artstats)[1])))

    urls<-getURLs(IDs=artstats$ID, users=artstats$User)
    htmlCode<-list(0)
    for (i in 1:length(urls)){
        con=url(urls[i])
        htmlCode[[i]]=readLines(con)
        close(con)
    }

    Tweetdata <- getTweetData(htmlCode)
    artstats <- cbind(artstats, Tweetdata)
    return(artstats)
}