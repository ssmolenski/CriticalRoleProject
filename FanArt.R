library(twitteR)
library(RCurl)
library(stringr)
library(XML)

TwitConnect()

Talks<-getUser("TalksMachina")
tweets<-userTimeline(Talks, n=550, excludeReplies=TRUE)
tweets<-sapply(tweets,function(x) x$getText())
index<-grep("Congratulations on winning FanArt of the Week!", tweets)
tweets<-tweets[index]

URLRegEx<-"https?://(www\\.)?\\S+\\.\\S+"
urls<-str_extract(tweets, URLRegEx)
htmlCode<-list(0)
for (i in 1:length(urls)){
    con=url(urls[i])
    htmlCode[[i]]=readLines(con)
    close(con)
}

names <- c(
    ">Ashley Johnson<",
    ">Brian W. Foster<",
    ">Critical Role<",
    ">Laura Bailey<",
    ">Liam O'Brien<",
    ">Marisha Ray<",
    ">Matthew Mercer<",
    ">Sam Riegel<",
    ">Talisen Jaffe<",
    ">Talks Machina<",
    ">Travis Willingham<" 
)

data<-data.frame(0)

for (i in 1:length(htmlCode)){
    likes<-getLikes(htmlCode[[i]])
    rts<-getRTs(htmlCode[[i]])

    names %>%
        gsub(">", "", .) %>%
        gsub("<","", .) -> castnames
    
    data.frame(likes, rts, castlikes, castnames) %>%
    spread(key=castnames, value=castlikes) -> df

    data<-rbind(data,df)
}




