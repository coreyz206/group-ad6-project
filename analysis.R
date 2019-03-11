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

#what needs to be done:
##Each of us need to ask a couple of analytical questions that we can then answer using the data?
###The requirements say that we can't just include visualizations, we should for each question, but we also need to answer the question
###using our data. 

##QUESTIONS - choice one (maternal, life, income)
#How does income per capita effect the life expectancy and and maternal mortality rate, is a positive or negative correlation or no correlation?
#What is the average life expectancy in the world and for each country?
#Why are maternal mortality rates different between countries, does it tie into income per capita
#What countries have the highest and lowest life expectancies, what is the average life expectancy?

##QUESTIONS - choice two (co2 emissions, urban population, gdp per capita)
#Does the GDP per capita effect the amount of co2 emissions by a country? 
#Do countries that have a higher urban population percent tend to see, a higher gdp per capita?
#Do countries with high co2 emissions have a greater density of urban population?
#Which countries have the lowest and highest amounts of co2 emissions and why? 