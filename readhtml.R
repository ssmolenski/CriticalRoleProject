readhtml <- function(htmlCode){
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
        castlikes<-getActors(htmlCode[[i]])
  
        data.frame(Likes, RTs, castlikes, castnames) %>%
        spread(key=castnames, value=castlikes) %>%
        rbind(FAotW=FALSE) -> df

        if(data==0){data=df}
        else{data<-rbind(data,df)}
    }
    return(data)
}


