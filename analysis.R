### PLACEHOLDER ###
library("dplyr")
library("ggplot2")
library("maps")
library("mapproj")

<<<<<<< HEAD
library(foreign)

pew_dataset <- read.spss("./data/pew_dataset.sav")
=======
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


#these can all be made into tables and maps now
gdp_and_urban_pop <- left_join(gdp_per_capita, urban_population, by = "Country.Name")
gdp_and_urban_change <- mutate(
  gdp_and_urban_pop,
  urban_change = X2014.y - X1990.y,
  gdp_change = X2014.x - X1990.x
)
year_choices <- colnames(gdp_and_urban_pop[4:30])
year_choices <- substr(year_choices, 2, 5)

gdp_and_co2 <- left_join(gdp_per_capita, co2_emissions, by = "Country.Name")
gdp_and_co2_change <- mutate(
  gdp_and_co2,
  co2_change = X2014.y - X1990.y,
  gdp_change = X2014.x - X1990.x
)

co2_and_urban <- left_join(co2_emissions, urban_population, by = "Country.Name")
co2_and_urban_change <- mutate(
  co2_and_urban,
  co2_change = X2014.x - X1990.x,
  urban_change = X2014.y - X1990.y
)


##shiny app
###must be interactive, include visualizations, text must be interactive based on user selections
###must have links to where we got the information from
###must have interactive widgets and answer our critical questions
####optional, use some css to style our shiny app so that it doesn't look so plain, only if time permitting
##We should try to make an interactive map
>>>>>>> 3897c7ad86ed2c723bec353d7c12d62e77312bf8
