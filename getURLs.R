getURLs <- function(tweets=character(0), IDs=character(0), users=character(0)){
    urls<-character(0)
    if(length(IDs)>=1 && length(users)>=1 ){
        if(length(IDs)!=length(users)){
            warning("User and IDs are of different lengths")
            return(character())
        }
        for (i in 1:length(users)){
            urls<-c(urls, paste("https://twitter.com/",
                                users[i],
                                "/status/",
                                IDs[i],
                                sep="")
                    )
        }
    }else if(length(tweets)>=1){
        for (i in 1:length(tweets)){
            urls<-c(urls , paste("https://twitter.com/", 
                            screenName(tweets[[i]]), 
                            "/status/", 
                            twitteR::id(tweets[[i]]),
                            sep="")
                )
        }
    }else{
        warning("Insufficient input.")
        return(character())
    }
    return(urls)
}


