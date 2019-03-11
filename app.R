##app file
library("shiny")
library("dplyr")
library("ggplot2")
library("maps")
library("mapproj")
library("tidyr")

source("analysis.R")
source("my_ui.R")
source("my_server.R")

shinyApp(ui <- my_ui, server = my_server)