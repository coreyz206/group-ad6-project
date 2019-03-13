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
  
  output$table_text <- renderText({
    table_description <- paste("The above data table is constructed using the three datasets, CO2 emissions (metric tons per capita),
      urban population percentage, and GDP per capita (current US$), which is accessible from the years 1990 to 2014. The data is current showing the data 
      for", paste0(input$year, ","), "which allows the user to select which year they would like to view so that they can compare the
      data in the other sections to data table. This allows for a way for the user to not only be able to view the data whenever they
      they would like but also to fact check the visualizations. The data table can also be manipulated by user to filter for which range
      of urban population percentages are showing, currently the range is", paste0(input$percent[1], " to ", input$percent[2], "."), "While
      this data does not answer any specific questions about the data, it does allow the user to view all of the data and get a better understanding
      for what the data looks like and how these questions are answered in other tabs.")
    table_description
  })
  
  output$scatter <- renderPlot({
    # difference <- co2_and_urban %>% 
    #   mutate(
    #     co2_change = paste0("X", input$year_difference[2], ".x") - paste0("X", input$year_difference[1], ".x"),
    #     urban_change = paste0("X", input$year_difference[2], ".y") - paste0("X", input$year_difference[1], ".y")
    #   )
    #I need to get this working for changing years, also need to get the trendline to switch on or off based on checkbox
    scatter_data <- co2_and_urban %>% 
      select(
        Country.Name,
        Country.Code.x,
        paste0("X", input$year_plot, ".x"),
        paste0("X", input$year_plot, ".y")
      )
    names(scatter_data)[3] <- paste0(input$year_plot, "_co2_emissions")
    names(scatter_data)[4] <- paste0(input$year_plot, "_urban_percent")
    names(scatter_data)[2] <- "Country.Code"
    as.data.frame(scatter_data)
    point_plot <- ggplot(data = scatter_data, mapping = aes(x = scatter_data[, 4], y = scatter_data[, 3])) +
      geom_point() +
      geom_smooth(se = FALSE) +
      labs(
        title = "Urban Percent Change vs CO2 Emissions",
        x = "Urban Population (%)",
        y = "CO2 Emissions (metric tons per capita)"
      )
    point_plot
  })
  
  output$scatter_text <- renderText({
    point_message <- paste("The above scatterplot answers questions about this data and their relation. If the 'Show Trendline'
                           button is selected then you can see the line of best fit for this data for whichever year is selected. 
                           In this case, the year selected is", paste0(input$year_plot, ","), "meaning that this was the correlation
                           for the selected year. Every single year has had a strong correlation between the urban population percentage
                           and the amount of CO2 emissions per capita. This does not mean that it is the correlation should be automatically
                           associated because there are many outlying countries. This means that those outlying countries are doing something
                           and it needs to be investigated. The intention of this scatterplot is to draw attention to how the urban population 
                           effects the CO2 emissions and why some countries are so successful at having a high urban popultion but also having
                           very low CO2 emissions. Which means this requires more knowledge about the outliers to trend, and an investigation
                           on how they regulate CO2 emissions and how they have built their infrastructure, whether it be based on harnessing the
                           power of clean energy sources or some other cause.")
    point_message
  })
  
  output$map <- renderLeaflet({
    input_var <- input$datatype_var
    world_map@data <- filter(co2_urban_mapdata, Year == input$year_var)
    qpal <- colorQuantile(palette = "Greens", domain = world_map@data[[input_var]], n = 7)
    labels <- paste0("<strong>", world_map@data$Country.Name, "</strong> <br/>",
                     input$datatype_var, ": ", round(world_map@data[[input_var]])) %>% 
      lapply(htmltools::HTML)
    
    leaflet(world_map) %>%
      addTiles() %>%
      setView(lat=10, lng=0, zoom=2) %>%
      addPolygons(
        fillColor = ~qpal(world_map@data[[input_var]]),
        weight = 2,
        opacity = 1,
        color = "white",
        fillOpacity = 0.5,
        highlight = highlightOptions(
          weight = 2,
          color = "#e6e6e6",
          fillOpacity = .5,
          bringToFront = TRUE
        ),
        label = labels,
        labelOptions = labelOptions(
          style = list("font-weight" = "normal", padding = "3px 8px"),
          textsize = "15px",
          direction = "auto"
        )
      )
  })
}
