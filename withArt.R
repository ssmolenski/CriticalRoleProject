withArt <- function(tweet){
    text<-sapply(tweet,function(x) x$getText())
    URLRegEx<-"https?://t.co/.+"
    grepl(URLRegEx, text)
}