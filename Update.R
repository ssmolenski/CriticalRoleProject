Update <- function(filename){
    load(filename)
    date<-today()

    updated <- data.frame(ID=data$ID, 
                            User=data$User)
    updated <- unique(updated)
    updated <- cbind(updated, 
                    Date=rep(date,times=(dim(updated)[1])),
                    FAotW=rep(FALSE,times=(dim(updated)[1])))

    urls <- getURLs(IDs=updated$ID, users=updated$User)
    htmlCode<-list(0)
    for (i in 1:length(urls)){
        con=url(urls[i])
        htmlCode[[i]]=readLines(con)
        close(con)
    }

    suppressWarnings(updated <- cbind(updated, getTweetData(htmlCode)))

    return(updated)
}
