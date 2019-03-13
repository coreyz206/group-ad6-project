### ui file

my_ui <- fluidPage(
  titlePanel("CO2 Emissions and Urbanization"),
  navbarPage("Urban Living vs CO2 Emissions",
    tabPanel("Introduction",
      mainPanel(
        #textOutput(outputId = "intro"),
        p("The following application formulates a report on the correlations between GDP per capita, the urban population
          as a percentage of the total population and the CO2 emissions by each country. Under each tab, there are different visualizations
          and comparisons of how these indicators influence each other and how they answer questions about cultures in countries across the
          globe."), 
          p("First, a little bit of background of these indicators is necessary, outlining both what they are and how they are calculated.
          GDP per capita, or Gross Domestic Product, is a measure of a country's economy and how many people are living in that country. It is
          calculated by taking the GDP and then dividing it by the population of that country. So, GDP per capita is a way of putting a number
          to the standard of living in the countries by measuring the amount of people and the countries gross domestic product. For clarification,
          gross domestic product is the total amount of goods and services provided by a country during one fiscal year. As for the urban population
          indicator, it is quite simple, it is the amount the amount of people living in the country divided by the amount of people in the country
          living in an urban area, giving the resulting percentage of people living in urban areas in each country. Lastly, CO2 emissions are
          the amount of carbon dioxide released into the atmosphere. In this case, the CO2 emissions are calculated on the scale of metric tons
          per capita, which means that it is the metric tons of CO2 emissions divided by the total population of each country in order to get a
          relative scale for each country. This way it is based more on how much they are producing relative to how big their population is, rather
          than just the amount of CO2 emissions in total. The following report was created to show the effects of urban living and GDP on the CO2
          emissions from 1990-2016. The data also allows for a look into how industrialization (higher gdp) has impacted urban living and the CO2
          emissions."),
        p("The following report will answer a series of questions about the data and some important analysis about the data. The following the questions
          are listed below as well as the links to the datasets."),
        br(),
        p(strong("1. What is the correlation between urban population percentage and the CO2 emissions per capita and which countries are the outliers
          to this correlation?")),
        br(),
        p(strong("2. Are there any regional patterns to CO2 emissions in relation to urban population and gdp? Which continents/world regions contribute the most,
                 what is significant about them, and how has this changed over the past 20 years?"))
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
    tabPanel("Global Trends",
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
            value = 2014,
            step = 1,
            sep = ""
          )
        ),
        mainPanel(
          leafletOutput("map"),
          p("Firstly, in analyzing geographical patterns, I will put the data on a choropleth map to gain a broad view. After 
            initial analysis, there do seem to be some patterns between regions in the 2014 dataset. Africa has both a low urban population
            and low CO2 output per capita, the Americas and Europe have generally above average CO2 output and urban density, and Asia has
            a low urban population but high per capita CO2 output. While the Americas, Europe, and Africa seem to show a correlation between
            general urbanization and CO2 output, Asian countries seem to counteract that theory. To further analyze this data, more factors
            must be brought in."),
          br(),
          p("The first new factor I will bring in is GDP, and I will summarize all the data for each region, and show it below."),
          dataTableOutput(outputId = "region_data_summarized"),
          p("placeholder text")
        )
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
      plotOutput("colcompare"), textOutput("compare_text"))
    )
  )

)


