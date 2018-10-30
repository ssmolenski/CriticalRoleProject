Update <- function(filename){
    source("getLikes.R")
    source("getRTs.R")
    library(tidyr)

    load(filename)
    date<-today()

    newdata <- data.frame(ID=data$ID, User=data$User)
    newdata <- unique(newdata)
    newdata <- cbind(newdata, Date=rep(date,times=(dim(newdata)[1])))

# cat("Getting Likes and Retweets \n")
    castlikes<-0
    Tweetdata<-data.frame()
    castnames <- c(
    "Ashley.Johnson",
    "Brian.W..Foster",
    "Critical.Role",
    "Laura.Bailey",
    "Liam.O.Brien",
    "Marisha.Ray",
    "Matthew.Mercer",
    "Sam.Riegel",
    "Talisen.Jaffe",
    "Talks.Machina",
    "Travis.Willingham")

    for (i in 1:nrow(newdata)){
        # cat("For loop iteration ", i, "\n")
        Likes<-getLikes(newdata$ID[[i]], newdata$User[[i]])
        RTs<-getRTs(newdata$ID[[i]], newdata$User[[i]])
        #castlikes<-getActors(newdata$ID[[i]], newdata$User[[i]])
  
        temp <- data.frame(Likes, RTs, castlikes, castnames)
        temp <- spread(temp, key=castnames, value=castlikes)
        temp<- cbind(temp, FAotW=FALSE)

        if(length(Tweetdata)==0){Tweetdata=temp}
        else{Tweetdata<-rbind(Tweetdata,temp)}
    }

    newdata<-cbind(newdata,Tweetdata)
    
    updated<-rbind(data,newdata)

    return(updated)
}
