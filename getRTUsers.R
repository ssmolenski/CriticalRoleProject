getRTUsers <- function(htmlCode, names){
castlikes<-logical(0)
for (i in 1:length(names)){
    if (any(!is.na(str_extract(htmlCode,names[i])))){
        castlikes[i]<-TRUE
    }else{
        castlikes[i]<-FALSE
    }
}

return(castlikes)
}