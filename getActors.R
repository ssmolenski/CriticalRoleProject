getActors <- function(htmlCode, names) {
    castlikes<-numeric(0)
    for (i in 1:length(names)){
        castlikes<-c(castlikes,sum(grepl(names[i], htmlCode)))
    }

    return(castlikes)
}