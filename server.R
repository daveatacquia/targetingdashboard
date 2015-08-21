
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shinydashboard)
library(jsonlite)
library(rCharts)

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
        n1 <- nPlot(cr ~ segment, group = "variation", data = df, type = "multiBarChart")
        return(n1)
    })
    
    output$segmentTable <- renderUI({
        # Create a Bootstrap-styled table
        df <- df()
        tags$table(class = "table",
                   tags$thead(tags$tr(
                       tags$th("Segment"),
                       tags$th("Variation"),
                       tags$th("Conversion Rate")
                   )),
                   tags$tbody(
                       tags$tr(
                           tags$td(df[1,1]),
                           tags$td(df[1,2]),
                           tags$td(df[1,3])
                       ),
                       tags$tr(
                           tags$td(df[2,1]),
                           tags$td(df[2,2]),
                           tags$td(df[2,3])
                       ),
                       tags$tr(
                           tags$td(df[3,1]),
                           tags$td(df[3,2]),
                           tags$td(df[3,3])
                       ),
                       tags$tr(
                           tags$td(df[4,1]),
                           tags$td(df[4,2]),
                           tags$td(df[4,3])
                       ),
                       tags$tr(
                           tags$td(df[5,1]),
                           tags$td(df[5,2]),
                           tags$td(df[5,3])
                       ),
                       tags$tr(
                           tags$td(df[6,1]),
                           tags$td(df[6,2]),
                           tags$td(df[6,3])
                       )
                   )
        )
    })
})
