##server file
library("shiny")
library("dplyr")
library("ggplot2")


my_server <- function(input, output) {
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
    scatter_data <- all_three %>% 
      select(
        Country.Name,
        Country.Code.x,
        paste0("X", input$year_plot, ".x"),
        paste0("X", input$year_plot, ".y"),
        paste0("X", input$year_plot)
      )
    names(scatter_data)[3] <- paste0(input$year_plot, "_co2_emissions")
    names(scatter_data)[4] <- paste0(input$year_plot, "_urban_percent")
    names(scatter_data)[2] <- "Country.Code"
    names(scatter_data)[5] <- paste0(input$year_plot, "_gdp_per_capita")
    as.data.frame(scatter_data)
      if (input$trendline) {
        point_plot <- ggplot(data = scatter_data, mapping = aes(x = scatter_data[, 4], y = scatter_data[, 3], 
                                                                color = scatter_data[, 5])) +
          geom_point() +
          geom_smooth(se = FALSE) +
          #geom_text(data = filter(all_three, scatter_data[, 4] > 90), aes(label = Country.Name)) +
          labs(
            title = "Urban Percent Change vs CO2 Emissions",
            x = "Urban Population (%)",
            y = "CO2 Emissions (metric tons per capita)",
            color = "GDP per capita (Current US$)"
          )
      } else {
        point_plot <- ggplot(data = scatter_data, mapping = aes(x = scatter_data[, 4], y = scatter_data[, 3], 
                                                                color = scatter_data[, 5])) +
          geom_point() +
          labs(
            title = "Urban Percent Change vs CO2 Emissions",
            x = "Urban Population (%)",
            y = "CO2 Emissions (metric tons per capita)",
            color = "GDP per capita (Current US$)"
          )
      }
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
    world_map@data <- backup_data
    filtered_data <- filter(all_data_global, Year == input$year_var) %>%
      select(Country.Name, Country.Code, `CO2 Emissions (metric tons per capita)`, `Percentage of Population in Urban Areas`, `GDP per capita, in current US$`)
    world_map@data <- left_join(world_map@data, filtered_data, by = 'Country.Code')
    qpal <- colorQuantile(palette = "Greens", domain = world_map@data[[input_var]], n = 7)
    labels <- paste0("<strong>", world_map@data$Country.Name, "</strong> <br/>",
                     input$datatype_var, ": ", round(world_map@data[[input_var]], digits = 2),
                     "<br/>GDP per capita: ", round(world_map@data$`GDP per capita, in current US$`, 2)) %>%
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

  output$region_data_summarized <- renderDataTable({
    region_data_subset <- filter(all_data_global, Year == input$year_var) %>%
      group_by(REGION) %>%
      summarise(
        "Country Average CO2 emission per capita" = mean(`CO2 Emissions (metric tons per capita)`),
        "Country Average Urbanized Population" = mean(`Percentage of Population in Urban Areas`),
        "Country Average GDP in Current US$" = mean(`GDP per capita, in current US$`)
      )
  })
  
  output$colcompare <- renderPlot({

    all_three_col <- left_join(co2_col, urban_col, by = c("Country.Name", "Country.Code" , "year"))

    all_three_col <- left_join(all_three_col, gdp_col, by = c("Country.Name", "Country.Code", "year"))

    all_three_col <- select(all_three_col, -Indicator.Name.x, -Indicator.Name.y, -Indicator.Name)

    all_three_col <- gather(all_three_col, key = Indicator.Name, value = "data", -Country.Name, -Country.Code,-year)

    just_series_col <- filter(all_three_col, Indicator.Name == input$serieschoice)

    just_series_col <- filter(just_series_col, Country.Name == input$countrychoicea | Country.Name == input$countrychoiceb)

    just_series_col <- spread(just_series_col, key = year, value = data)

    just_series_col <- select(just_series_col, Country.Name, Country.Code, Indicator.Name, paste0("X", input$year_compare[1]):paste0("X", input$year_compare[2]))

    just_series_col <- gather(just_series_col, key = year, value = "Data",
           -Country.Name, -Country.Code, -Indicator.Name)

    col_chart <- ggplot(data = just_series_col) +
      geom_col(mapping = aes(x = year, Data, fill = Country.Name), position = "dodge") +
      labs(x = paste0(input$countrychoicea, "/", input$countrychoiceb, " (", input$year_compare[1], "-", input$year_compare[2],")"), y = input$serieschoice, fill = "Country Name")
    col_chart
  })

  output$compare_text <- renderText({
    paste0("This is column chart compares data from two countries of your choosing.
          Right now it is comparing ", input$serieschoice, " between ", input$countrychoicea, " and ",
          input$countrychoiceb, " between years ", input$year_compare[1], " and ", input$year_compare[2], ".")

  })
}

