getRTs <- function(htmlCode){
    rtRegEx<- "[[:digit:]]*,*[[:digit:]]{1,3}[[:space:]]retweets"
    ind<-which(!is.na(str_extract(htmlCode,rtRegEx)),arr.ind=TRUE)
    rts<-str_extract(htmlCode[ind[1]],"[[:digit:]]*,*[[:digit:]]{1,3}")

    rts<-as.numeric(gsub(",","",rts))

    return(rts)
}


