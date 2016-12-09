#installing packages
  #install.packages('twitteR')

#Loading packages
library(twitteR)
library(dplyr)


# Necessary for starting up the Twitter API OAuth Connection
if (!require("twitteR")) {
  install.packages("twitteR", repos="http://cran.rstudio.com/") 
  library("twitteR")
}

# Storing the consumer key and variable
consumer.key <- '974S5E5vr0pJ8VuOx2oIYf4Z0'
consumer.secret <- '8acGBD7TKoLhFVG5TSsfa0PMeUpwnQgQVDwL1BfoGy5XHowIMb'

# Storing the access token and secret
access.token <- '804111108076228608-K6ml4zNsg2RZLb4ep3Dir4JJhuzb1AQ'
access.secret <- 'nwvP4yzA6mKNE2P0Ma0diEvHQNN24McUnLH80kbmD4uGx'

# This will enable the use of a local file to cache OAuth access credentials between R sessions.
options(httr_oauth_cache=T)
setup_twitter_oauth(consumer.key, consumer.secret, access.token, access.secret)




#Defining the shinyGetTrends function with inputstring and inputlocation
getTrends <- function (inputString, inputCity = "Albuquerque") {
  
  # Dataframe of all cities that twitteR has trending data on and their
  # corresponding longitude and latitude coordinates. This list of cities
  # was retrieved by using twitteR's availableTrendLocations() method
  geo.location.data <- read.csv(file = 'GeoLocationData.csv')
  
  # Formats and returns the user's search string so that it's compatible with the 
  # twitteR searchTwitter function that retrieves the posts
  formatted.search.string <- gsub(" ", "+", inputString)
  
  # Returns the longitude and latitude of the given city that twitteR has trending
  # data on
  geo.data.colname <- paste0("geo.location.data$", inputCity)
  input.city.coordinates <- eval(parse(text = geo.data.colname))
  
  # Finds the geocode to use in the searchTwitter(...) function based on the 
  # chosen.city
  city.geocode <- paste0(input.city.coordinates, ",50mi")
  
  # Number of posts to be returned
  num.posts <- 10
  
  # This function gets the recent posts that contain a given search string in 
  # the chosen city. If there are fewer posts than asked for, this function will
  # return as many posts as there are. If there are 0 recent posts, a message
  # saying that there weren't any posts will be returned. If the city you choose
  # contains spaces in the name, replace them with underscores.
  if (num.posts == 'error') {
    return_value <- "There weren't enough recent posts with your search string."
    stop("doEverything error message")
  } else {
    return_value <- searchTwitter(formatted.search.string, n = num.posts, lang = 'en', 
                                 geocode = city.geocode, resultType = 'recent')
  }
  if (length(return_value) == 0) {
    return_value <- ("Your search string wasn't found in any recent Twitter posts.")
  }

  if (return_value == ("Your search string wasn't found in any recent Twitter posts.") ||
      return_value == ("There weren't enough recent posts with your search string.")) {
        return (return_value)
      }
  else {
    # Takes the data returned from the getRecentPostsInChosenLocation(...) function
    # and converts it into a data frame
    tweetdataframe <- do.call('rbind', lapply(return_value, as.data.frame))
    
    return (tweetdataframe$text)
  }
}
