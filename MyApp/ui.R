## ui.R
library(shiny)
require(rCharts)
#Load the data
#setwd("~/Desktop/Developing-Data-Products-Project/MyApp")
sat_data <- read.csv("satellite_data.csv", header=TRUE)
satData <- sat_data[,1:27]

shinyUI(
    
    # Use a fluid layout
    fluidPage(    
        
        # Give the page a title
        titlePanel("Satellite Use by Country"),
        
        # Generate a row with a sidebar
        sidebarLayout(      
            
            # Define the sidebar with one input
            sidebarPanel(
                selectInput("country", "Country", 
                            choices=sort(unique(as.character(satData$Country.of.Operator.Owner)))),
                hr(),
                helpText("Select a country. Hover over barchart to see exact number in each category.")
            ),
            
            # Create a spot for the barplots
            mainPanel(
                h4("Total Number of Satellites"),
                verbatimTextOutput("satSum"),
                chartOutput("myChart", "highcharts"), 
                chartOutput("myChart2", "highcharts"),
                HTML('<style>.rChart {width: 100%; height: 500px}</style>')
            )
            
        )
    )
)