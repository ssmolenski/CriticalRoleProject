getTweetData <- function(htmlCode){  
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

    dataframe<-data.frame()
    Likes<-0
    RTs<-0
    castlikes<-0

    for (i in 1:length(htmlCode)){
        Likes<-getLikes(htmlCode[[i]])
        RTs<-getRTs(htmlCode[[i]])
        #castlikes<-getActors(htmlCode[[i]])
  
        temp <- data.frame(Likes, RTs, castlikes, castnames)
        temp <- spread(temp, key=castnames, value=castlikes)
        temp<- cbind(temp, FAotW=FALSE)

        if(length(dataframe)==0){dataframe=temp}
        else{dataframe<-rbind(dataframe,temp)}
    }
    return(dataframe)
}


