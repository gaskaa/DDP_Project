## server.r
require(shiny)
require(rCharts)

#Load the data
#setwd("~/Desktop/Developing-Data-Products-Project/MyApp")
sat_data <- read.csv("satellite_data.csv", header=TRUE)
satData <- sat_data[,1:27]

shinyServer(
    
    function(input, output){
        
        #Creata a reactive subset
        usersData <- reactive({
            #Subset the data based on the input and include the users
            satData1 <- subset(satData, Country.of.Operator.Owner==input$country, select=c(Users))
            usesSummary <- summary(satData1$Users)
            usesData <- data.frame(User = names(usesSummary), Number = usesSummary)
            usesData[order(usesData$Number, decreasing=TRUE),]
         })
        
        #Create a barchart of satellite users
        output$myChart<-renderChart({
            p1 <- Highcharts$new()
            p1$series(data =usersData()$Number, type = "bar", name="Satellites", color="darkblue")
            p1$xAxis(categories = usersData()$User)
            p1$title(text = "Number of Satellites per User")
            p1$addParams(dom="myChart")
            return(p1)
        })
        
        #Creata a reactive expression
        purposeData <- reactive({
            #Subset the data based on the input and include the purpose
            satData2 <- subset(satData, Country.of.Operator.Owner==input$country, select=c(Purpose))
            usesSummary2 <- summary(satData2$Purpose)
            usesData2 <- data.frame(Use = names(usesSummary2), Number = usesSummary2)
            usesData2[order(usesData2$Number, decreasing=TRUE),]
        })
        
        
        #Create a barchart of satellite uses
        output$myChart2<-renderChart({
            p2 <- Highcharts$new()
            p2$series(data =purposeData()$Number, type = "bar", name="Satellites", color="darkblue")
            p2$xAxis(categories = purposeData()$Use)
            p2$title(text = "Number of Satellites per Use")
            p2$addParams(dom="myChart2")
            return(p2)
        })
        
        #Calculate the sum of the satellites per country
        output$satSum <- renderPrint({sum(usersData()$Number)})
    }
)