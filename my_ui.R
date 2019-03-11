### ui file


my_ui <- fluidPage(
  titlePanel("CO2 Emissions and GDP"),
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "year", label = "Select a Year", 
                  choices = year_choices, selected = "2014")
    )
  )
)
