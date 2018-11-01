NewTweets <- function(date){
    #Dependencies
    source("C:\\Users\\Sarah\\Documents\\DataScience\\TwitConnect.R")
    source("getLikes.R")
    source("getRTs.R")
    library(twitteR)
    library(tidyr)

    #Get new tweets
    TwitConnect()

    # cat("Getting tweets #criticalroleart \n")
    CR_art <- searchTwitter("#criticalroleart",
                                n=10000,
                                resultType="recent",
                                lang="en", 
                                since=as.character(date-1))
    # cat("Getting tweets #criticalrolefanart")
    CR_fanart <- searchTwitter("#criticalrolefanart",
                                n=10000,
                                resultType="recent",
                                lang="en", 
                                since=as.character(date-1))

    # cat("Stripping retweets \n")
    tweets<-c(strip_retweets(CR_art), strip_retweets(CR_fanart))
    # cat("making Tweetdata \n")
    artstats<-data.frame(
                    ID=sapply(tweets,twitteR::id), 
                    User=sapply(tweets, screenName))
    artstats<-unique(artstats)
    artstats<-cbind(artstats, Date=rep(date,times=(dim(artstats)[1])))


    # cat("Getting Likes and Retweets \n")
    castlikes<-0
    Tweetdata<-data.frame()
    castnames <- c(
    "Ashley.Johnson",
    "Brian.W..Foster",
    "Critical.Role",
    "Laura.Bailey",
    "Liam.O.Brien",
    "Marisha.Ray",
    "Matthew.Mercer",
    "Sam.Riegel",
    "Talisen.Jaffe",
    "Talks.Machina",
    "Travis.Willingham")

    for (i in 1:nrow(artstats)){
        # cat("For loop iteration ", i, "\n")
        Likes<-getLikes(artstats$ID[[i]], artstats$User[[i]])
        RTs<-getRTs(artstats$ID[[i]], artstats$User[[i]])
        #castlikes<-getActors(artstats$ID[[i]], artstats$User[[i]])

        # cat("Likes: ", Likes, "\n RTs: ", RTs, "\n")
        temp <- data.frame(Likes, RTs, castlikes, castnames)
        temp <- spread(temp, key=castnames, value=castlikes)
        temp<- cbind(temp, FAotW=FALSE)

        if(length(Tweetdata)==0){Tweetdata=temp}
        else{Tweetdata<-rbind(Tweetdata,temp)}
    }


    # cat("combining")
    artstats <- cbind(artstats, Tweetdata)
    # cat("returning \n")
    return(artstats)
}