
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(shinydashboard)

library(jsonlite)
library(rCharts)

shinyServer(function(input, output) {
    
    output$segmentChart <- renderChart({
        data <- fromJSON("./data/example.json")
        seg <- data$segments
        segment.names <- names(seg)
        df <- data.frame(segment=NULL,variation=NULL,cr=NULL)
        for(i in seq_along(seg)) {
            for(j in seq_along(seg[[i]]$variations)) {
                variation.names <- names(seg[[i]]$variations)
                df <- rbind(df, 
                            data.frame(segment=segment.names[i], 
                                       variation=variation.names[j],
                                       cr=seg[[i]]$variations[[j]]$results$conversionrate))
            }
        }
        n1 <- nPlot(cr ~ segment, group = "variation", data = df, type = "multiBarChart")
        return(n1)
    })
    
    output$shownBox <- renderInfoBox({
        infoBox(
            "Progress", paste0(25 + input$count, "%"), icon = icon("list"),
            color = "purple"
        )
    })
    
    output$conversionsBox <- renderInfoBox({
        infoBox(
            "Progress", paste0(25 + input$count, "%"), icon = icon("list"),
            color = "purple"
        )
    })
    
    output$crBox <- renderInfoBox({
        infoBox(
            "Progress", paste0(25 + input$count, "%"), icon = icon("list"),
            color = "purple"
        )
    })
    
})
