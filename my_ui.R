### ui file


my_ui <- fluidPage(
  titlePanel("CO2 Emissions and GDP"),
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "year", label = "Select a Year", 
                  choices = year_choices, selected = "2014"),
      sliderInput(inputId = "percent", label = "Select Urban Percent Range",
                  min = 0, max = 100, value = c(0, 100))
    ),
    mainPanel(
      tabsetPanel(
        type = "tabs",
        #tabPanel("Map", plotOutput(outputId = "urban_pop_co2"), textOutput(outputId = "map_text")),
        tabPanel("Table", dataTableOutput(outputId = "datasets_by_year"))
      )
    )
  )
)


