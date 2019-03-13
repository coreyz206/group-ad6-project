### ui file

my_ui <- fluidPage(
  titlePanel("CO2 Emissions and GDP"),
  navbarPage("Urban Living vs CO2 Emissions",
    tabPanel("Brief",
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
    ),
    tabPanel("Plot",
      sidebarLayout(
        sidebarPanel(
          # sliderInput(inputId = "year_difference", label = "Select a Year Range", 
          #             min = 1990, max = 2014, value = c(1990, 2014)),
          selectInput(inputId = "year_plot", label = "Select a Year", 
                      choices = year_choices, selected = "2014"),
          checkboxInput(inputId = "trendline", label = "Show Trendline", value = FALSE)
        ),
        mainPanel(
          plotOutput(outputId = "scatter"), textOutput(outputId = "scatter_text")
        )
      )
    ),
    tabPanel("Map",
      sidebarLayout(
        sidebarPanel(
          selectInput(
            inputId = "datatype_var",
            label = strong("Select data to show"),
            choices = c("CO2 Emissions (metric tons per capita)", "Percentage of Population in Urban Areas"),
            selected = "CO2 Emissions (metric tons per capita)"
          ),
          sliderInput(
            inputId = "year_var",
            label = strong("Select a year"),
            min = 1990,
            max = 2014,
            value = 1990,
            step = 1,
            sep = ""
          )
        ),
        mainPanel(
          leafletOutput("map")
        )
    )
  ),
  tabPanel("Compare",
    sidebarLayout(
      sidebarPanel(
        sliderInput(
          inputId = "year_compare", 
          label = "Years to Compare", 
          value = c(1990, 2014), 
          min = 1990, 
          max = 2014, 
          sep = ""
          ),
        selectInput("serieschoice", "Series Choice", choices = indicator_names),
        selectInput("countrychoicea", "Country A Choice", choices = country_names),
        selectInput("countrychoiceb", "Country B Choice", choices = country_names)
        ),
      
    mainPanel(
      plotOutput("colcompare"))
    )
  )
)
)