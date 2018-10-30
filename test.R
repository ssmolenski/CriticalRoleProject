library("XML")
library(httr)
url <- "https://twitter.com/afeliciaking/status/1053815638618226693"
doc <- htmlParse(rawToChar(GET(url)$content))

retweets<-xpathSApply(doc,"//li[@class='js-stat-count js-stat-retweets stat-count']",xmlValue)

likes<-xpathSApply(doc,"//li[@class='js-stat-count js-stat-favorites stat-count']",xmlValue)

<li class="js-stat-count js-stat-favorites stat-count" aria-hidden="true">
      <a tabindex="0" role="button" data-tweet-stat-count="790" data-compact-localized-count="790" class="request-favorited-popup" data-activity-popup-title="790 likes">
          
          <strong>790</strong> Likes
      </a>
    </li>