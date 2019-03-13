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
          p("One other factor that varies widely by region and could show a profound correlation with our data is gdp per capita.
            As one can see by hovering over different locations on the map, countries with higher urbanization rates and therefore more
            CO2 output tend to have a higher gdp per capita. This shows a trend towards industrialization in these countries, which is also
            shown by their greater co2 outputs."),
          br(),
          p("Overall, there are no great regional patterns between CO2 output, urbanization, and GDP per capita. There are definite patterns visible,
            yet none of them can be attributed to regional causes over the causes already found. Developing countries have low GDP, co2 output, and urbanization,
            and they seem to be clustered together. Evidence of this is located in both African, Asian, and some South American countries."),
          br(),
          p("When one looks at the dataset over the full time period, a large amount of change is visible--but not quite where one might expect it.
            A snowball effect is illustrated, with the middle-upper countries on the distrition seeing great gains in co2, urbanization, and gdp, while
            developing countries grow slowly or even stagnate."),
          br(),
          p("Greater implications from a regional analysis data provide helpful insight for future endeavors. Visualization of this data can help researchers
            to combat global warming more effectively by targeting the biggest culprits. Also, the patterns visible can help researchers to predict and
            combat harmful countries before they begin to urbanize and output massive amounts of CO2. Urbanization itself may also be called into questionl; 
            if its benefits are worth the risk, or if it's even a substantial cause of the co2 output.")
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
)


