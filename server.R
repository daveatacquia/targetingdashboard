
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shinydashboard)
library(rCharts)


shinyServer(function(input, output) {
    
    output$shown <- renderValueBox({
        valueBox(
            value = sprintf("%s", total.shown),
            subtitle = sprintf("Shown"),
            icon = icon("users")
        )
    })
    
    output$conversions <- renderValueBox({
        valueBox(
            value = sprintf("%s", total.converted),
            subtitle = sprintf("Conversions"),
            icon = icon("thumbs-up")
        )
    })
    
    output$conversionrate <- renderValueBox({
        valueBox(
            value = sprintf("%.0f%%", total.cr),
            subtitle = sprintf("Conversion Rate"),
            icon = icon("area-chart")
        )
    })
    
    # Fill in the spot we created for a plot
    output$segmentPlot <- renderChart2({
        
        # Render a barplot
        n1 <- nPlot(cr ~ segment, group = "variation", data = df, type = "multiBarChart")
        return(n1)
    })
    
    output$segmentTable <- renderUI({
        # Create a Bootstrap-styled table
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
