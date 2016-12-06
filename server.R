# server.R
library(dplyr)

# Read in data
setwd("C:/Users/mihuz_000/Desktop/Info/m14-shiny")
source('exercise-4/scripts/buildMap.R')
source('exercise-4/scripts/buildScatter.R')
df <- read.csv('exercise-4/data/electoral_college.csv', stringsAsFactors = FALSE)
state.codes <- read.csv('exercise-4/data/state_codes.csv', stringsAsFactors = FALSE)

# Join together state.codes and df
joined.data <- left_join(df, state.codes, by="state")

# Compute the electoral votes per 100K people in each state
joined.data <- joined.data %>% mutate(ratio = votes/population * 100000)

# Start shinyServer
shinyServer(function(input, output) { 
  
  src = "http://data-informed.com/wp-content/uploads/2013/11/R-language-logo-224x136.png"
  output$picture<-renderText({c('<img src="',src,'">')})
  
  
  # Render a plotly object that returns your map
  output$value <- renderPrint({
    input$text })

  output$map <- renderPlotly({ 
    return(BuildMap(joined.data, input$mapvar))
  }) 
  
  output$scatter <- renderPlotly({
    return(BuildScatter(joined.data, input$search))
  })
})