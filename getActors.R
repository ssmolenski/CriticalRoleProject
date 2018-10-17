getActors <- function(htmlCode) {
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
    ">Travis Willingham<")
    
    castlikes<-numeric(0)
    for (i in 1:length(names)){
        castlikes<-c(castlikes,sum(grepl(names[i], htmlCode)))
    }

    return(castlikes)
}