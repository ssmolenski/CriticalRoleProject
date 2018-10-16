library(twitteR)
library(RCurl)
library(DataCombine)

TwitConnect()

CR_tweets<-searchTwitter("#criticalrole",n=20,resultType="mixed",lang="en")

dictionary<-read.csv("C:\\Users\\Sarah\\Documents\\DataScience\\emojidictionary\\emoji_dictionary.csv")

CRdf<-twListToDF(CR_tweets)
CRdf$text <- iconv(CRdf$text, from = "latin1", to = "ascii", sub = "byte")
emojitextdf<-FindReplace(data=CRdf,Var="text", replaceData=dictionary,from="R_Encoding",to="Name",exact=FALSE)
fts<-sapply(as.list(emojitextdf[1]),function(x) x$getText())


URLRegEx<-"https?://(www\\.)?\\S+\\.\\S+" #urls
ControlRegEx<-"[[:cntrl:]]" #control characters
ReTweetsRegEx<-"RT"
HeartEmojiRegEx<-"&lt;3"
MiscEmojiRegEx<-"<U\\+[[:alnum:]]+>"

replacedf<-data.frame(symbol=c(URLRegEx,ControlRegEx,ReTweetsRegEx,HeartEmojiRegEx,MiscEmojiRegEx),text=c("","","","HEART","UNKNOWNEMOJI"))


# vectext<-gsub(URLRegEx,"",vectext)
# vectext<-gsub(ControlRegEx,"",vectext)
# vectext<-gsub(ReTweetsRegEx,"",vectext)

# codepattern<-"<U\\+[[:alnum:]]+>"
# test<-gsub(codepattern,"UNKNOWNEMOJI",vectext)

# gsub(codepattern,"RAWR",string)
