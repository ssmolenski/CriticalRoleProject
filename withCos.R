withCos <- function(tweet){
    text<-sapply(tweet,function(x) x$getText())
    tag<-"#(C|c)ritical(R|r)ole(C|c)osplay"
    grepl(tag, text)
}