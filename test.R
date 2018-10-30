library("XML")
library(httr)
url <- "https://twitter.com/afeliciaking/status/1053815638618226693"
doc <- htmlParse(rawToChar(GET(url)$content))

retweets<-xpathSApply(doc,"//li[@class='js-stat-count js-stat-retweets stat-count']",xmlValue)

likes<-xpathSApply(doc,"//li[@class='js-stat-count js-stat-favorites stat-count']",xmlValue)