library(twitteR)
library(RCurl)
library(tm) #textmining package
library(wordcloud) #To make a beautifuuul wordcloud
library(png)
library(stringr)

############### Word Cloud Generation #################

TwitConnect()

#Search twitter for the criticalrole tag. This will get n tweets and store them as a list.
CR_tweets<-searchTwitter("#criticalrole",n=10,resultType="mixed",lang="en")
CR_text<-sapply(CR_tweets,function(x) x$getText())
Date<-as.character(Sys.time())

# find indices of words with non-ASCII characters
to_cut <- grep("CR_text", iconv(CR_text, "latin1", "ASCII", sub="CR_text"))
CR_text <- CR_text[-to_cut] #removes words with non-ASCII characters

#Striping unwanted stuff
URLRegEx<-"https?://(www\\.)?\\S+\\.\\S+" #urls
tinyRegEx<-"://t\\.co/\\S+" #tinypic links
ControlRegEx<-"[[:cntrl:]]" #control characters
ReTweetsRegEx<-"RT"

CR_text<-gsub(URLRegEx,"",CR_text)
CR_text<-gsub(tinyRegEx,"",CR_text)
CR_text<-gsub(ControlRegEx,"",CR_text)
CR_text<-gsub(ReTweetsRegEx,"",CR_text)

#Replace actor handles with their names
LBhandle<-"@laurabaileyVO"
TJhandle<-"@executivegoth"
SRhandle<-"@samriegel"
MMhandle<-"@matthewmercer"
LOhandle<-"@VoiceOfOBrian"
TWhandle<-"@WillingBlam"
MRhandle<-"@Marish_Ray"
AJhandle<-"@TheVulcanSalute"

CR_text<-gsub(LBhandle,"Laura",CR_text)
CR_text<-gsub(TJhandle,"Taliesin",CR_text)
CR_text<-gsub(SRhandle,"Sam",CR_text)
CR_text<-gsub(MMhandle,"M",CR_text)
CR_text<-gsub(LOhandle,"Liam",CR_text)
CR_text<-gsub(TWhandle,"Travis",CR_text)
CR_text<-gsub(AJhandle,"Ashley",CR_text)

#Remove all other handles
CR_text<-gsub("@\\S+","",CR_text) 



#Creates a Corpus of tweets as 500 separate "documents". This object is 
#especially convenient for text mining, with various functions built in to 
#clean up text data.
CR_corpus<-Corpus(VectorSource(CR_text))
inspect(CR_corpus[1]) #a corpus can be subset like a vector


#Cleaning the text data to make a wordcloud
suppressWarnings(CR_clean<-tm_map(CR_corpus,removePunctuation))#tm_map applies a function to a corput (like apply et al)
suppressWarnings(CR_clean<-tm_map(CR_clean,content_transformer(tolower)))
suppressWarnings(CR_clean<-tm_map(CR_clean,removeWords,stopwords("english"))) #stop words are unintetesting words, ie "and", "a" etc
suppressWarnings(CR_clean<-tm_map(CR_clean,removeNumbers))
suppressWarnings(CR_clean<-tm_map(CR_clean,stripWhitespace)) #remove whitespace left by the above functions
suppressWarnings(CR_clean<-tm_map(CR_clean,removeWords,c("criticalrole","criticalrolefanart","coursecriticalrole"))) #since this was our search term, it will be in every single tweet, which is uninteresting for the wordcloud.

#colorpalette
pal <- brewer.pal(9, "BuGn")
pal <- pal[-(1:2)]

#Generate WordCloud
Date<-gsub(":","-",Date)
# filename<-paste("C:\\Users\\Sarah\\Documents\\DataScience\\Twitter","\\",Date,".png",sep="")
# png(filename=filename)
# wordcloud(CR_clean,random.order=FALSE,colors=pal)
# dev.off()


############### Sentiment Analysis #################