#Takes post id and username and returns number of likes

getLikes <- function(i,u){
    source("getURLs.R")
    library(XML)
    library(stringr)
    library(RCurl)
    url<-getURL(ID=i,user=u)
    if(!url.exists(url)){return(NA)}

    doc <- htmlParse(rawToChar(GET(url)$content))
    xpathSApply(doc,"//li[@class='js-stat-count js-stat-favorites stat-count']",xmlValue) %>% 
    str_extract("[[:digit:]]+") %>%
    as.numeric() ->Likes

    return(Likes)
}