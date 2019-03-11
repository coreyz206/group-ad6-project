### PLACEHOLDER ###
library("dplyr")
library("ggplot2")
library("maps")
library("mapproj")

maternal_mortality_rate <- read.csv("data/maternal_mortality_filtered.csv", stringsAsFactors = FALSE)
life_expectancy_at_birth <- read.csv("data/life_expectancy_at_birth_filtered.csv", stringsAsFactors = FALSE)
gdp_per_capita <- read.csv("data/gdp_per_capita_filtered.csv", stringsAsFactors = FALSE)
income_per_capita <- read.csv("data/income_per_capita_filtered.csv", stringsAsFactors = FALSE)
unemployment_percent <- read.csv("data/unemployment_percent_filtered.csv", stringsAsFactors = FALSE)
co2_emissions <- read.csv("data/co2_emissions_filtered.csv", stringsAsFactors = FALSE)
urban_population <- read.csv("data/urban_population_percent_filtered.csv", stringsAsFactors = FALSE)

world_map <- map_data("world")
world_map_updated <- mutate(
  world_map,
  Country.Code == iso.alpha(world_map$region, n = 3)
)
