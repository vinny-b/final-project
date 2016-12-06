# ui.R
library(shiny)
library(plotly)
shinyUI(navbarPage('Identifying Trends in Twitter',
                   # Create a tab panel for your map
                   tabPanel("What's Trending Where?",
                            titlePanel('Top Trending Tweets Statewide'),
                            # Create sidebar layout
                            sidebarLayout(
                              
                              # Side panel for controls
                              sidebarPanel(
                                
                                # Input to select variable to map
                                
                                br("Choose a city to see the top 10 trending topics in that city."),
                                br(),
        
                                selectInput('mapvar', label = 'Choose a city:', choices = list("Population" = 'population', 'Electoral Votes' = 'votes', 'Votes / Population' = 'ratio')),
                                br("Further specify your result by entering a keyword to see related tweets in that city."),
                                br(),
                                textInput("text", label = "Search for a Tweet:", value = "Enter a keyword..."),
                                br(),
                                
                                
                              ),
    
                                
                
                              # Main panel: display plotly map
                              mainPanel(
                                plotlyOutput('map'),
                                htmlOutput("picture")
                              )
                   )
                   ), 
                   
                   # Create a tabPanel to show your scatter plot
                   tabPanel('Favorites Map',
                            # Add a titlePanel to your tab
                            titlePanel('Where are your favorite Tweets coming from?'),
                            
                            # Create a sidebar layout for this tab (page)
                            sidebarLayout(
                              
                              # Create a sidebarPanel for your controls
                              sidebarPanel(
                                
                                # Make a textInput widget for searching for a state in your scatter plot
                                textInput('search', label="Twitter Handle:", value = 'Enter Twitter handle...')
                              ),
                              
                              # Create a main panel, in which you should display your plotly Scatter plot
                              mainPanel(
                                plotlyOutput('scatter')
                              )
                            )
                   )
))