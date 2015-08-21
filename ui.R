library(shinydashboard)
require(rCharts)

dashboardPage(
    dashboardHeader(title = "Lift Dashboard"),
    dashboardSidebar(
        sidebarMenu(
           menuItem("Targeting", tabName = "targeting"),
            menuItem("Testing", tabName = "testing"),
            selectInput("perSelect", "Personalization:", choices = c('Banner A1'='1','Banner B2'='2'))
        )
    ),
    dashboardBody(
        tabItems(
           # Targeting tab content
            tabItem(tabName = "targeting",
                    fluidRow(
                        valueBoxOutput("shown"),
                        valueBoxOutput("conversions"),
                        valueBoxOutput("conversionrate")
                    ),
                    fluidRow(
                        showOutput("segmentPlot", "nvd3")
                    ),
                    fluidRow(
                        box(
                            width = 12, status = "info", solidHeader = TRUE,
                            title = "Segment Data",
                            uiOutput("segmentTable")
                        )
                    )
                ),
            
               # Testing tab content
                tabItem(tabName = "testing",
                        fluidRow(
                        )
                )
            )
        )
)

