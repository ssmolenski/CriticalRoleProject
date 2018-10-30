NewTweets <- function(date){
    #Get new tweets
    TwitConnect()

    # cat("Getting tweets #criticalroleart \n")
    suppressWarnings(
        CR_art <- searchTwitter("#criticalroleart",
                                n=10000,
                                resultType="recent",
                                lang="en", 
                                since=as.character(date-1))
    )
    # cat("Getting tweets #criticalrolefanart")
    suppressWarnings(
        CR_fanart <- searchTwitter("#criticalrolefanart",
                                n=10000,
                                resultType="recent",
                                lang="en", 
                                since=as.character(date-1))
    )

    # cat("Stripping retweets \n")
    tweets<-c(strip_retweets(CR_art), strip_retweets(CR_fanart))
    # cat("making dataframe \n")
    artstats<-data.frame(
                    ID=sapply(tweets,twitteR::id), 
                    User=sapply(tweets, screenName))
    artstats<-unique(artstats)
    artstats<-cbind(artstats, Date=rep(date,times=(dim(artstats)[1])))

    # cat("getting URLs \n")
    urls<-getURLs(IDs=artstats$ID, users=artstats$User)
    htmlCode<-list(0)
    for (i in 1:length(urls)){
        con=url(urls[i])
        htmlCode[[i]]=readLines(con)
        close(con)
    }

    # cat("getting tweet data \n")
    Tweetdata <- getTweetData(htmlCode)
    # cat("combining")
    artstats <- cbind(artstats, Tweetdata)
    # cat("Cutting out chains \n")
    #Cutting out tweet-chains
    artstats <- filter(artstats, RTs<100000)
    artstats <- filter(artstats, Likes<100000)
    # cat("returning \n")
    return(artstats)
}