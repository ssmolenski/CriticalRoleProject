CheckURLs <- function(urls){
    bool<-logical()
    for (i in 1:length(urls)){
        bool<-c(bool,url.exists(urls[[i]]))
    }
    return(bool)
}