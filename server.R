#server.R
library(dplyr)

# Reading in the data
source('getTrends.R')
source('getFav.R')

# Start shinyServer
shinyServer(function(input, output) { 
  
#Render table returning the trends using shintGetTrends function
  
  output$chart <- renderTable({ 
    return(getTrends(input$text, input$city))
  })

# Render a plotly map showing the locations of where the tweets generated were favorited using getFav function  
  
  output$map <- renderPlotly({
    return(getFav(input$user))
  })
  
  #Rendering the summary for the trends tab
  
  output$textTrends <- renderText(
    paste0(
      "The following table is created by using your input location (", input$city
      , ") and input search keyword/phrase. Based on the location chosen, the table below will display the
      10 most recent, trending tweets in ", input$city, ". If you have not entered a keyword/phrase in the text input box,
      then the table will include the top 10 trending tweets from the location (", input$city, ") without searching for 
      the user's text input. In the case that the user's string is not found to match with at least 10 posts in the location
      they have chosen, however many posts there are will be shown."
      )
    )
  
  #Rendering the summary for the favorite map tab
  
  output$textMap <- renderText(
    paste0(
      "The following map is created by using your input of a twitter user handle (@", input$user
          , "), by gathering the latest 100 favorites (likes) from their account and locations where the tweets were 
          generated from. The information is then summarized into a choropleth map displayed below, where the 
          darker areas represent more tweets were favorited from that area by the user (@", input$user
          , "). Some good examples would be NBA, Google, NASA, Microsoft, MTV."
      )
    )
  #Closing the Shiny function
  })