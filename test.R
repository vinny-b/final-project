install.packages('twitteR')
library(twitteR)
library(dplyr)

if (!require("twitteR")) {
  install.packages("twitteR", repos="http://cran.rstudio.com/") 
  library("twitteR")
}

consumer.key <- '974S5E5vr0pJ8VuOx2oIYf4Z0'
consumer.secret <- '8acGBD7TKoLhFVG5TSsfa0PMeUpwnQgQVDwL1BfoGy5XHowIMb'

access.token <- '804111108076228608-K6ml4zNsg2RZLb4ep3Dir4JJhuzb1AQ'
access.secret <- 'nwvP4yzA6mKNE2P0Ma0diEvHQNN24McUnLH80kbmD4uGx'

options(httr_oauth_cache=T) #This will enable the use of a local file to cache OAuth access credentials between R sessions.
setup_twitter_oauth(consumer.key, consumer.secret, access.token, access.secret)

lucaspuente <- getUser("lucaspuente")
location(lucaspuente)

lucaspuente_follower_IDs<-lucaspuente$getFollowers(retryOnRateLimit=180)
length(lucaspuente_follower_IDs)

favs <- favorites("lucaspuente", n = 21)
# strsplit(favs[[1]], ":")

unlist(favs)
View(favs)
View(favs[[1]])
location(getUser(favs[[2]]$screenName))
location(getUser(favs[[6]]$screenName))


trends.data.frame <- availableTrendLocations()
trends.data.frame <- trends.data.frame %>% filter(country %in% 'United States')
View(trends.data.frame)
getTrends('2357024')
