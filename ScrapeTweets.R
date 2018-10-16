library(twitteR)
library(RCurl)
library(stringr)
library(XML)
library(lubridate)
library(dplyr)

#Date
date<-today()
setwd("C:\\Users\\Sarah\\Documents\\DataScience\\Twitter")

#Load previous data
if(file.exists("likesandrts.Rda")){
    load("likesandrts.Rda")
}

#Get new tweets
TwitConnect()
CR_art<-searchTwitter("#criticalroleart",n=1000,resultType="recent",lang="en", since=as.character(date-1))
CR_fanart<-searchTwitter("#criticalrolefanart",n=5000,resultType="recent",lang="en", since=as.character(date-1))
tweets<-c(strip_retweets(CR_art), strip_retweets(CR_fanart))

#Initialize the dataframe
artstats<-data.frame(ID=unique(sapply(tweets,twitteR::id)))
artstats<-cbind(artstats, Date=rep(date,times=(dim(artstats)[1])))

#Get URLs
urls<-character(0)
for (i in 1:length(tweets)){
    urls<-c(urls , paste("https://twitter.com/", 
                        screenName(tweets[[i]]), 
                        "/status/", 
                        id(tweets[[i]]),
                        sep=""
                        )
            )
}

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

names %>%
        gsub(">", "", .) %>%
        gsub("<","", .) %>% 
        make.names() %>%
        gsub("X.","", . ) -> castnames

likes<-numeric(0)
rts<-numeric(0)
castlikes<-numeric(0)
data<-data.frame(0)

for (i in 1:length(htmlCode)){
    Likes<-getLikes(htmlCode[[i]])
    RTs<-getRTs(htmlCode[[i]])
    castlikes<-getActors(htmlCode[[i]], names)
  
    data.frame(Likes, RTs, castlikes, castnames) %>%
    spread(key=castnames, value=castlikes) -> df

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
arrange(ID, Date)
save(file="likesandrts.Rda", likesandrts)