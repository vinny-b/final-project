# install.packages('twitteR')
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

#This will enable the use of a local file to cache OAuth access credentials between R sessions.
options(httr_oauth_cache=T)
setup_twitter_oauth(consumer.key, consumer.secret, access.token, access.secret)





shinyGetTrends <- function (inputString, inputCity = "Albuquerque") {
  
  
  # Get all locations within the US
  trends.data.frame <- availableTrendLocations() %>%
    filter(country %in% 'United States')
  
  # Remove the United States from the list
  trends.data.frame <- trends.data.frame[-c(64), ]
  # View(trends.data.frame)
  
  # Key-Value pair list of all cities that twitteR has trending data on and their
  # corresponding longitude and latitude coordinates
  geo.location.data <- list(Albuquerque="35.085334,-106.605553",
                            Atlanta="33.748995,-84.387982",
                            Austin="30.267153,-97.743061",
                            Baltimore="39.290385,-76.612189",
                            Baton_Rouge="30.458283,-91.14032",
                            Birmingham="33.520661,-86.80249",
                            Boston="42.360082,-71.05888",
                            Charlotte="35.227087,-80.843127",
                            Chicago="41.878114,-87.629798",
                            Cincinnati="39.103118,-84.51202",
                            Cleveland="41.499320,-81.694361",
                            Colorado_Springs="38.833882,-104.821363",
                            Columbus="39.961176,-82.998794",
                            Dallas_Ft._Worth="32.761422,-96.858013",
                            Denver="39.739236,-104.990251",
                            Detroit="42.331427,-83.045754",
                            El_Paso="31.761878,-106.485022",
                            Fresno="36.746842,-119.772587",
                            Greensboro="36.072635,-79.791975",
                            Harrisburg="40.273191,-76.886701",
                            Honolulu="21.306944,-157.858333",
                            Houston="29.760427,-95.369803",
                            Indianapolis="39.768403,-86.158068",
                            Jackson="32.298757,-90.18481",
                            Jacksonville="30.332184,-81.655651",
                            Kansas_City="39.099727,-94.578567",
                            Las_Vegas="36.114707,-115.17285",
                            Long_Beach="33.770050,-118.193739",
                            Los_Angeles="34.052234,-118.243685",
                            Louisville="38.252665,-85.758456",
                            Memphis="35.149534,-90.04898",
                            Mesa="33.415184,-111.831472",
                            Miami="25.761680,-80.19179",
                            Milwaukee="43.038902,-87.906474",
                            Minneapolis="44.977753,-93.265011",
                            Nashville="36.162664,-86.781602",
                            New_Haven="41.308274,-72.927884",
                            New_Orleans="29.951066,-90.071532",
                            New_York="40.712784,-74.005941",
                            Norfolk="36.850769,-76.285873",
                            Oklahoma_City="35.467560,-97.516428",
                            Omaha="41.252363,-95.997988",
                            Orlando="28.538335,-81.379236",
                            Philadelphia="39.952584,-75.165222",
                            Phoenix="33.448377,-112.074037",
                            Pittsburgh="40.440625,-79.995886",
                            Portland="45.523062,-122.676482",
                            Providence="41.823989,-71.412834",
                            Raleigh="35.779590,-78.638179",
                            Richmond="37.540725,-77.436048",
                            Sacramento="38.581572,-121.4944",
                            St._Louis="38.610302,-90.412518",
                            Salt_Lake_City="40.760779,-111.891047",
                            San_Antonio="29.424122,-98.493628",
                            San_Diego="32.715738,-117.161084",
                            San_Francisco="37.774929,-122.419416",
                            San_Jose="37.338208,-121.886329",
                            Seattle="47.606209,-122.332071",
                            Tallahassee="30.438256,-84.280733",
                            Tampa="27.950575,-82.457178",
                            Tucson="32.221743,-110.926479",
                            Virginia_Beach="36.852926,-75.977985",
                            Washington="38.907192,-77.036871")
  
  
  # Formats and returns the user's search string so that it's compatible with the 
  # twitteR search functions
  formatted.search.string <- gsub(" ", "+", inputString)
  
  # Returns the longitude and latitude of the given city that twitteR has trending
  # data on
  geo.data.colname <- paste0("geo.location.data$", inputCity)
  input.city.coordinates <- eval(parse(text = geo.data.colname))
  
  # Finds the geocode to use in the searchTwitter(...) function based on the 
  # chosen.city
  city.geocode <- paste0(input.city.coordinates, ",50mi")
  
  num.posts <- 20
  
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
