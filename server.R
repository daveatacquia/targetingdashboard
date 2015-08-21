
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shinydashboard)
library(jsonlite)
library(rCharts)
library(curl)

shinyServer(function(input, output) {
    
    data <- reactive({
        #data <- fromJSON("./data/example.json")
        data <- fromJSON("http://52.20.161.146:8000/reports/homepage-banner/targeting?account_name=KATBAI2&site_name=Drupal")
    })
    
    df <- reactive({
        data <- data()
        seg <- data$segments
        segment.names <- names(seg)
        df <- data.frame(segment=NULL,variation=NULL,cr=NULL)
        for(i in seq_along(seg)) {
            for(j in seq_along(seg[[i]]$variations)) {
                #seg[[i]]$variations[[j]]$results$conversionrate
                variation.names <- names(seg[[i]]$variations)
                df <- rbind(df, 
                            data.frame(segment=segment.names[i], 
                                       variation=variation.names[j],
                                       cr=seg[[i]]$variations[[j]]$results$conversionrate))
            }
        }
        df
    })
    
    output$shown <- renderValueBox({
        data <- data()
        valueBox(
            value = sprintf("%s", data$totals$shown),
            subtitle = sprintf("Shown"),
            icon = icon("users")
        )
    })
    
    output$conversions <- renderValueBox({
        data <- data()
        valueBox(
            value = sprintf("%s", data$totals$converted),
            subtitle = sprintf("Conversions"),
            icon = icon("thumbs-up")
        )
    })
    
    output$conversionrate <- renderValueBox({
        data <- data()
        valueBox(
            value = sprintf("%.0f%%", data$totals$conversionrate),
            subtitle = sprintf("Conversion Rate"),
            icon = icon("area-chart")
        )
    })
    
    # Fill in the spot we created for a plot
    output$segmentPlot <- renderChart2({
        df <- df()
        # Render a barplot
        n1 <- nPlot(cr ~ segment, group = "variation", data = df, type = "multiBarChart")
        return(n1)
    })
    
    output$table <- renderDataTable({
        df <- df()
        df
    }) 
})
