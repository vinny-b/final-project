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
        
                                selectInput('city', label = 'Choose a city:', choices = list('Albuquerque' = 'Albuquerque', 'Atlanta' = 'Atlanta', 'Austin' = 'Austin',
                                                                                             'Baltimore' = 'Baltimore', 'Baton Rouge' = 'Baton_Rouge' , 'Birmingham' = 'Birmingham' ,
                                                                                             'Boston' = 'Boston' , 'Charlotte' = 'Charlotte' , 'Chicago' = 'Chicago' , 
                                                                                             'Cincinnati' = 'Cincinnati' , 'Cleveland' = 'Cleveland' , 'Colorado Springs' = 'Colorado_Springs' ,
                                                                                             'Columbus' = 'Columbus' , 'Dallas_Ft. Worth' = 'Dallas-Ft._Worth' , 'Denver' = 'Denver' ,
                                                                                             'Detroit' = 'Detroit' , 'El Paso' = 'El_Paso' , 'Fresno' = 'Fresno', 'Greensboro' = 'Greensboro' ,
                                                                                             'Harrisburg' = 'Harrisburg', 'Honolulu' = 'Honolulu', 'Houston' = 'Houston' ,
                                                                                             'Indianapolis' = 'Indianapolis' , 'Jackson' = 'Jackson' , 'Jacksonville' = 'Jacksonville' ,
                                                                                             'Kansas City' = 'Kansas_City' , 'Las Vegas' = 'Las_Vegas' , 'Long Beach' = 'Long_Beach' ,
                                                                                             'Los Angeles' = 'Los_Angeles' , 'Louisville' = 'Louisville' , 'Memphis' = 'Memphis', 'Mesa' = 'Mesa' ,
                                                                                             'Miami' = 'Miami' , 'Milwaukee' = 'Milwaukee' , 'Minneapolis' = 'Minneapolis' , 
                                                                                             'Nashville' = 'Nashville' , 'New Haven' = 'New_Haven' , 'New Orleans' = 'New_Orleans' ,
                                                                                             'New York' = 'New_York' , 'Norfolk' = 'Norfolk' , 'Oklahoma City' = 'Oklahoma_City' ,
                                                                                             'Omaha' = 'Omaha' , 'Orlando' = 'Orlando' , 'Philadelphia' = 'Philadelphia' ,
                                                                                             'Phoenix' = 'Phoenix' , 'Pittsburgh' = 'Pittsburgh' , 'Portland' = 'Portland' ,
                                                                                             'Providence' = 'Providence' , 'Raleigh' = 'Raleigh', 'Richmond' = 'Richmond' ,
                                                                                             'Sacramento' = 'Sacramento' , 'Salt Lake City' = 'Salt_Lake_City' , 'San Antonio' = 'San_Antonio',
                                                                                             'San Diego' = 'San_Diego' , 'San Francisco' = 'San_Francisco' , 'San Jose' = 'San_Jose',
                                                                                             'Seattle' = 'Seattle' , 'St. Louis' = 'St._Louis' , 'Tallahassee' = 'Tallahassee' ,
                                                                                             'Tampa' = 'Tampa' , 'Tuscon' = 'Tuscon' , 'Virginia Beach' = "Virginia_Beach",
                                                                                             'Washington' = 'Washington'), value = "Albuquerque"),
                                br("Further specify your result by entering a keyword to see related tweets in that city."),
                                br(),
                                textInput("text", label = "Search for a Tweet:", value = "Enter a keyword..."),
                                br()
                                
                                
                              ),
    
                                
                
                              # Main panel: display plotly map
                              mainPanel(
                                plotlyOutput('chart'),
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
                                plotlyOutput('map')
                              )
                            )
                   )
))