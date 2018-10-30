getURL <- function(ID, user){
    url<-character(0)

    if(length(ID)!=length(user)){
        warning("User and IDs are of different lengths")
        return(character())
    }
    for (i in 1:length(user)){
        url<-c(url, paste("https://twitter.com/",
                            user[i],
                            "/status/",
                            ID[i],
                            sep="")
                    )
    }

    return(url)
}


