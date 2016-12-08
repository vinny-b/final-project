#server.R
library(dplyr)

# Reading in the data
source('shinyGetTrends.R')
source('getFav.R')

# Start shinyServer
shinyServer(function(input, output) { 
  
#Render table returning the trends using shintGetTrends function
  
  output$chart <- renderTable({ 
    return(shinyGetTrends(input$text, input$city))
  })

# Render a plotly map showing the locations of where the tweets generated were favorited using getFav function  
  
  output$map <- renderPlotly({
    return(getFav(input$string))
  })
  
  #Rendering the summary paragraph for the trends tab
  
  output$textTrends <- renderText(
    paste0(
      "The following table is created by using your input of the location(", input$city
      , ") and text(", input$text, "). Based on the location chosen the table below 
      will display the trending tweets from the location(", input$city, ") which contain the 
      text(", input$text, "). If there is no data in the text input(", input$text, "), then the table will 
      include the trending tweets from the location(", input$text, ") chosen from the select input." 
      )
    )
  
  #Rendering the summary paragraph for the favorite map tab
  
  output$textMap <- renderText(
    paste0(
      "The following map is created by using your input of a twitter user(", input$search
          , "),then gathering the top 30 favourites(likes) from their account and gathering information 
          regarding the location the tweets were generated from. The information is then summarized into 
          a heat map displayed below, where the darker areas represent more tweets were favorited from that 
          area by the user(", input$search, ")"
          )
    )
  #Closing the Shiny function
  })