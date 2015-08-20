library(shinydashboard)

dashboardPage(
    dashboardHeader(title = "Lift Targeting"),
    dashboardSidebar(
        sidebarMenu(
            menuItem("Personalizations", tabName = "personalizations", icon = icon("dashboard")),
            menuItem("Config", tabName = "config", icon = icon("th"))
        )
    ),
    dashboardBody(
        tabItems(
            # First tab content
            tabItem(tabName = "personalizations",
                dashboardBody(
                    fluidRow(
                        infoBoxOutput("shownBox"),
                        infoBoxOutput("conversionsBox"),
                        infoBoxOutput("crBox")
                    ),
                    fluidRow(
                        showOutput("segmentChart", "nvd3")
                    )
                )
            ),
            
            # Second tab content
            tabItem(tabName = "testing",
                    h2("Testing Report")
            )
        )
    )
)