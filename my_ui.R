### ui file

my_ui <- fluidPage(
  titlePanel("CO2 Emissions and GDP"),
  navbarPage("Something",
    tabPanel("Introduction",
      mainPanel(
        textOutput(outputId = "intro")
      )  
    ),
    tabPanel("Table",
      sidebarLayout(
        sidebarPanel(
          selectInput(inputId = "year", label = "Select a Year", 
                      choices = year_choices, selected = "2014"),
          sliderInput(inputId = "percent", label = "Select Urban Percent Range",
                      min = 0, max = 100, value = c(0, 100))
        ),
        mainPanel(
          dataTableOutput(outputId = "datasets_by_year"), textOutput(outputId = "table_text")
        )
      )
    )
  )
)



