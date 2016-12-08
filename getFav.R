#installing packages

#install.packages('twitteR')

#Loading packages

library(twitteR)
library(dplyr)
library(plotly)
library(maps)
library(jsonlite)




if (!require("twitteR")) {
  install.packages("twitteR", repos="http://cran.rstudio.com/") 
  library("twitteR")
}

#Storing the consumer key and variable
consumer.key <- '974S5E5vr0pJ8VuOx2oIYf4Z0'
consumer.secret <- '8acGBD7TKoLhFVG5TSsfa0PMeUpwnQgQVDwL1BfoGy5XHowIMb'

#Storing the access token and secret
access.token <- '804111108076228608-K6ml4zNsg2RZLb4ep3Dir4JJhuzb1AQ'
access.secret <- 'nwvP4yzA6mKNE2P0Ma0diEvHQNN24McUnLH80kbmD4uGx'

options(httr_oauth_cache=T) #This will enable the use of a local file to cache OAuth access credentials between R sessions.
setup_twitter_oauth(consumer.key, consumer.secret, access.token, access.secret)



########### The favorited tweets are extracted below ##############

#### 

#getting favorites of the user handle
getFav <- function(inputHandle){
favs <- favorites(inputHandle, n = 100)
fav <- unlist(favs)



## for loop to build list of locations
locationlist <- c()
for (i in 1:length(fav))
  locationlist <- append(locationlist, (getUser(fav[[i]]$screenName)$location))


# removing everything before comma in the lise
listaftercomma <- gsub(".*,", "", locationlist)

#converting list to dataframe 
dflist <- as.data.frame(listaftercomma)

#Changing column name
colnames(dflist) <- "stateabbrev"


#Removing all locations that aren't in state abbreviation format 
liststateab <- grep('AL|AK|AZ|AR|CA|CO|CT|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY', dflist$stateabbrev, value = TRUE)




# Building a clean list of the data
cleanlist <- c()
for (i in 1:length(liststateab))
  cleanlist <- append(cleanlist, as.character(liststateab[i]))

#Removing all spaces
statesDataFrame <- gsub('\\s+', '', cleanlist)

#Converting into dataframe 
clean_df <- as.data.frame(statesDataFrame)

#Changing column name 
colnames(clean_df) <- "states"




###


#Using dplyr to summarize the data 
exstate <- clean_df %>% 
  group_by(states) %>%
  summarize(count = n())



#Building frequency heat map

#Giving state boundaries a white border
l <- list(color = toRGB("white"), width = 2)
#Specifying some map attributes
g <- list(
  scope = 'usa',
  projection = list(type = 'albers usa'),
  showlakes = TRUE,
  lakecolor = toRGB('white')
)

#Specifying Columns and Axis
map <- plot_geo(exstate, locationmode = 'USA-states') %>%
  add_trace(
    z = ~count, locations = ~states,
    color = ~count, colors = 'Oranges'
  ) %>%
#Setting the colorbar   
  colorbar(title = "Users") %>%
  layout(
    title = paste("Location of users that", inputHandle, "most recently favorited"),
    geo = g
  )
#Returning map
return(map)
}

