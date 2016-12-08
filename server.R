# server.R
library(dplyr)

# Read in data
source('shinyGetTrends.R')
source('getFav.R')

# Start shinyServer
shinyServer(function(input, output) { 
  
  # Render a plotly object that returns your map

  output$chart <- renderTable({ 
    return(shinyGetTrends(input$text, input$city))
  })
  output$map <- renderPlotly({
    return(getFav(input$string))
  })
})