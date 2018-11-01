#Takes post id and username and returns number of retweets

getRTs <- function(i,u){
    source("getURLs.R")
    library(XML)
    library(stringr)
    library(RCurl)
    library(httr)
    url<-getURL(ID=i,user=u)
    if(!url.exists(url)){return(NA)}

    doc <- htmlParse(rawToChar(GET(url)$content))
    xpathSApply(doc,"//li[@class='js-stat-count js-stat-retweets stat-count']",xmlValue) %>% 
    str_extract("[[:digit:]]+") %>%
    as.numeric() ->RTs

    if(length(RTs)==0){
        RTs=0;
    }

    return(RTs)
}