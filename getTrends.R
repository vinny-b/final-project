# install.packages('twitteR')
library(twitteR)
library(dplyr)
library(plotly)
library(maps)
library(jsonlite)


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



########### Below is the stuff for favorited tweets ##############

####

#get favorites
favs <- favorites("lucaspuente", n = 40)

fav <- unlist(favs)


#length(fav)

## for loop to build list of locations
locationlist <- c()
for (i in 1:length(fav))
  locationlist <- append(locationlist, (getUser(fav[[i]]$screenName)$location))

###

# remove everything before comma 

cleanlist <- gsub(".*,", "", locationlist)

View(cleanlist) 

#convert list to dataframe 
dflist <- as.data.frame(cleanlist)

#fix column name 
colnames(dflist) <- "stateabbrev"


vectorliste <- as.vector(cleanlist)
len2 <- length(vectorliste) == 2


flatlist <- flatten(dflist)



filter(liste, stateabbrev == "CA")

## practice with state codes

#df of states
flatstate <- c("MA", "OR", "CA", "CA", "TX", "MD", "MD", "MD", "IL", "IL", "IL", "IL", "IL")
datastate <- as.data.frame(flatstate)

#count frequency 
exstate <- datastate %>% 
  group_by(flatstate) %>%
  summarize(count = n())



#build frequency heat map

# give state boundaries a white border
l <- list(color = toRGB("white"), width = 2)
# specify some map projection/options
g <- list(
  scope = 'usa',
  projection = list(type = 'albers usa'),
  showlakes = TRUE,
  lakecolor = toRGB('white')
)

inputHandle <- "USER HANDLE"

plot_geo(exstate, locationmode = 'USA-states') %>%
  add_trace(
    z = ~count, locations = ~flatstate,
    color = ~count, colors = 'Purples'
  ) %>%
  colorbar(title = "Users") %>%
  layout(
    title = paste("Location of users that", inputHandle, "most recently favorited"),
    geo = g
  )

