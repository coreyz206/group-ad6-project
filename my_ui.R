### ui file
library("shiny")
library("dplyr")
library("ggplot2")

source("analysis.R")

my_ui <- fluidPage(
  titlePanel("CO2 Emissions and GDP"),
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "year", label = "Select a Year", 
                  choices = yeaer_choices, selected = "2014")
    )
  )
)
