##server file
library("shiny")
library("dplyr")
library("ggplot2")


my_server <- function(input, output) {
  output$intro <- renderText({
    intro_text <- "This is the intro, make sure to actually make it an introduction"
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
