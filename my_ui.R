### ui file

my_ui <- fluidPage(theme = shinytheme("cosmo"),
  titlePanel("CO2 Emissions and Urbanization"),
  navbarPage("Urban Living vs CO2 Emissions",
    tabPanel("Introduction",
      mainPanel(
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
                 what is significant about them, and how has this changed over the past 20 years?")),
        br(),
        p(strong("3. What are the differences based on years between two countries for CO2 emissions, GDP per capita, and urban population percent?")),
        br(),
        br(),
        p("Below are the links for the sources of the datafiles:"),
        p(a("All Data", href="https://data.worldbank.org/indicator?tab=all")),
        p(a("Urban Population", href="https://data.worldbank.org/indicator/SP.URB.TOTL.IN.ZS?view=chart")),
        p(a("CO2 Emissions", href="https://data.worldbank.org/indicator/EN.ATM.CO2E.PC?view=chart")),
        p(a("GDP Per Capita", href="https://data.worldbank.org/indicator/NY.GDP.PCAP.CD?view=chart"))
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
          plotOutput(outputId = "scatter"), textOutput(outputId = "scatter_text"),
          br(),
          p("The effect of urbanization in a country has a large effect on the amount of CO2 emissions in that country. While there may
            be another impacting factor, such as the infrastructure and the importance of fossil fuels to an economy, the data shows that
            there is a strong positive correlation between the amount of urban population and the CO2 emissions. The interesting part about
            this is that the CO2 are based on a per capita scale which means it already factored in the raw population of each country. This
            means that the urban population does determine to some degreee, shown by the trendline, that as the urban population of a country
            increases the amount of CO2 emissions will also increase. This is partially a result of the industrialization that occurs around
            urban areas."),
          br(),
          p("While the actual correlation coeffiecient can be calculated in order to show how these two variables are related on a deeper level
            then just the trendline, it requires some very deep statistical analysis. Therefore, it is better just show the trendline and how ordered
            the grouping the of dots are to the trendline. There are very few outliers for this trend and it will require some deeper understanding
            of the infrastructures in these countries and how they utilize or do not utilize clean energies."),
          br(),
          p("Overall, this correlation is important because it shows that there is a way to break the trend of CO2 emissions as the urban population
            continues to increase. This means that we need to investigate how these countries with high urban population percentages but very low CO2
            emissions have built their infrastructure and how they harvest and use energy in order to break the chain of increasingly emitting large
            amounts of CO2 emissions into the ozone layer each year.")
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
        plotOutput("colcompare"), textOutput("compare_text"),
        br(),
        p("The Comparison tool allows users not only to view trends in CO2 Emissions, GDP and 
          Urban Population over a range of years, but also allows users to compare the data from
          two countries of their choosing. This allows users to compare between the
          3 trends and deduce correlations (i.e does GDP per Capita effect CO2 Emissions per Capita?) 
          but also to compare these trends between countries, (i.e does China have more CO2 Emissions per 
          Capita then the USA, and is there a trend between CO2 Emissions and Urban Population over the years?)"),
        br(),
        p("This allows us to bring the Global Information from the other two plots down to a national level and pinpoint
          specific nations with a great impact on global trends (for example, China) as well as more clearly visualize 
          trends over the years. Using the `World` Column in the Dataset, we can also compare national level trends to 
          global trends directly."),
        br(),
        p("For Example: Comparing years 1990 and 2014 with the United States and the World, we can see
          that the USA's Urban Population has increased ever so slightly over the past two decades. The World 
          Urban Population has also increased over this time, so it's safe to assume that the United States, the 
          third most populated country in the world is partially responsible for that increase. This trend can also
          be seen for USA and World GDP. We can also see that the USA emits 4 times more CO2 in Metric tons per capita
          than the world average, and is thus probably a major contributor to that World Average. However, the world average
          in CO2 emissions continues to increase while the US has significantly decreased theirs. There must be some other nation
          responsible."),
        br(),
        p("Comparing the USA with China, we see a dramatic increase of CO2 Emissions per capita, and with a large population,
          China is definitely a large contributor to the overall rise of Global CO2 Emissions. All things considered, they still have
          a far lower CO2 Emissions per capita than the United States.")
        )
      )
    )
  )
)


