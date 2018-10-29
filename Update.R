Update <- function(filename){
    load(filename)
    date<-today()

    urls <- getURLs(IDs=data$ID, users=data$User)
    urls <- unique(urls)
    ind <- CheckURLs(urls)
    urls <- urls[ind]

    new <- data.frame(ID=data$ID, User=data$User)
    new <- unique(new)
    new <- new[ind,]
    new <- cbind(new, Date=rep(date,times=(dim(new)[1])))

    htmlCode<-list(0)
    for (i in 1:length(urls)){
        con=url(urls[i])
        htmlCode[[i]]=readLines(con)
        close(con)
    }

    newdata <- getTweetData(htmlCode)
    new<-cbind(new,newdata)

    data<-select(data,1:3,5:17,4)
    
    updated<-rbind(data,new)

    return(updated)
}
