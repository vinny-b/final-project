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

inputHandle <- "lucaspuente"

favs <- favorites(inputHandle, n = 100)

fav <- unlist(favs)


#length(fav)

## for loop to build list of locations
locationlist <- c()
for (i in 1:length(fav))
  locationlist <- append(locationlist, (getUser(fav[[i]]$screenName)$location))

###

# remove everything before comma 

cleanlist <- gsub(".*,", "", locationlist)


#convert list to dataframe 
dflist <- as.data.frame(cleanlist)

#fix column name
colnames(dflist) <- "stateabbrev"

#dflist <- as.data.frame(dflist, stringsAsFactors = FALSE)
# dflist <- droplevels(dflist)
View(dflist)


#for loop to keep only state abbrev

#states <- c("AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY")
#states <- as.data.frame(states, stringsAsFactors = FALSE)

# for (i in 1:length(dflist)) {
#   for (j in 1:length(states)) {
#     if (!identical(dflist$stateabbrev[i], states[j])) {
#       dflist <- dflist[, -c(i)]
#     }
#   }
# }


flatlist <- flatten(dflist)

liststateab <- grep('AL|AK|AZ|AR|CA|CO|CT|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY', flatlist$stateabbrev, value = TRUE)
df1 <- data.frame(liststateab)

colnames(df1) <- "states1"

View(df1)



## practice with state codes DATA


#df of states

flatstate <- c("MA", "OR", "CA", "CA", "TX", "MD", "MD", "MD", "IL", "IL", "IL", "IL", "IL")
datastate <- as.data.frame(flatstate)
View(datastate)

###


#count frequency 
exstate <- df1 %>% 
  group_by(states1) %>%
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


plot_geo(exstate, locationmode = 'USA-states') %>%
  add_trace(
    z = ~count, locations = ~states1,
    color = ~count, colors = 'Purples'
  ) %>%
  colorbar(title = "Users") %>%
  layout(
    title = paste("Location of users that", inputHandle, "most recently favorited"),
    geo = g
  )

