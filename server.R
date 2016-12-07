# server.R
library(dplyr)

# Read in data
source('shinyGetTrends.R')

# Start shinyServer
shinyServer(function(input, output) { 
  
  src = "http://data-informed.com/wp-content/uploads/2013/11/R-language-logo-224x136.png"
  output$picture<-renderText({c('<img src="',src,'">')})
  
  
  # Render a plotly object that returns your map

  output$chart <- renderTable({ 
    return(shinyGetTrends(input$text, input$city))
    
  })
})