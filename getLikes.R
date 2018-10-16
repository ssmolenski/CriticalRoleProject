getLikes <- function(htmlCode){
    likesRegEx<- "[[:digit:]]*,*[[:digit:]]{1,3}[[:space:]]likes"
    ind<-which(!is.na(str_extract(htmlCode,likesRegEx)),arr.ind=TRUE)
    likes<-str_extract(htmlCode[ind[1]],"[[:digit:]]*,*[[:digit:]]{1,3}")

    likes<-as.numeric(gsub(",","",likes))

    return(likes)
}