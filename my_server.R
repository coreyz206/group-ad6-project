##server file
library("shiny")
library("dplyr")
library("ggplot2")


my_server <- function(input, output) {
  output$intro <- renderText({
    intro_text <- paste("The following application formulates a report on the correlations between GDP per capita, the urban population
    as a percentage of the total population and the CO2 emissions by each country. Under each tab, there are different visualizations
    and comparisons of how these indicators influence each other and how they answer questions about cultures in countries across the
    globe. First, a little bit of background of these indicators is necessary, outlining both what they are and how they are calculated.
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
    emissions. The following data all comes from the", paste0(a("World Bank Group", href="https://data.worldbank.org/indicator?tab=all"), "."),
    "As each tab is investigated the questions about these indicators and their correlations are answered. The datasets can be found by clicking
    on the following links:", paste0(a("Urban Population", href="https://data.worldbank.org/indicator/SP.URB.TOTL.IN.ZS?view=chart"), ","),
    paste0(a(href="https://data.worldbank.org/indicator/EN.ATM.CO2E.PC?view=chart", "CO2 Emissions"), ","), 
    paste0(a("GDP per capita", href="https://data.worldbank.org/indicator/NY.GDP.PCAP.CD?view=chart"), "."))
    intro_text
  })
  
  output$datasets_by_year <- renderDataTable({
    comparison_by_year <- all_three %>% 
      select(
        Country.Name,
        Country.Code.x,
        paste0("X", input$year, ".x"),
        paste0("X", input$year, ".y"),
        paste0("X", input$year)
      )
    names(comparison_by_year)[2] <- "Country.Code"
    names(comparison_by_year)[3] <- paste0(input$year, "_CO2_emissions")
    names(comparison_by_year)[4] <- paste0(input$year, "_urban_percent")
    names(comparison_by_year)[5] <- paste0(input$year, "_gdp_per_capita")
    comparison_by_year <- filter(
      comparison_by_year,
      input$percent[1] < comparison_by_year[, 4] & input$percent[2] > comparison_by_year[, 4]
    )
    comparison_by_year
  })
  
  #need to finish this description
  output$table_text <- renderText({
    table_description <- paste("The above table of data provides the name of the country")
    table_description
  })
  
  output$scatter <- renderPlot({
    co2_and_urban <- mutate(
      co2_and_urban,
      co2_change = paste0("X", input$year_difference[2], ".x") - paste0("X", input$year_difference[1], ".x"),
      urban_change = paste0("X", input$year_difference[2], ".y") - paste0("X", input$year_difference[1], ".y")
    )
    #I need to get this working for changing years, also need to get the trendline to switch on or off based on checkbox
    point_plot <- ggplot(data = co2_and_urban) +
      geom_point(x = urban_change, y = co2_change) +
      geom_smooth()
    point_plot
  })
  
  output$scatter_text <- renderText({
    point_message <- "I just need to put a placeholder here for the time being"
    point_message
  })
}
