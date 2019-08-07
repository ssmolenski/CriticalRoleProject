#ActorRTs <- function(handle){
    library(twitteR)
    library(stringr)

    # TwitConnect()

    # handle="matthewmercer"
    # Actor<-getUser(handle)
    # tweets<-userTimeline(Actor, n=50, includeRts=TRUE, excludeReplies=TRUE)
    # tweettext<-sapply(tweets,function(x) x$getText())

    URLRegEx<-"https?://t.co/.+"
    # link_ind <- grep(URLRegEx, tweettext)
    # links<-tweets[RTs_ind]
    # linktext<-sapply(RTs,function(x) x$getText())

    links<-str_extract_all(tweettext,URLRegEx)
    links2<-character()
    for(i in 1:length(links)){
        if(length(links[[i]])!=0){
            links2<-c(links2,links[[i]])
        }
    }


    #Replies_ind <- grep("^@", tweettext)
    #Replies<-tweets[Replies_ind]
#}

