### analysis and data prep

gdp_per_capita <- read.csv("data/gdp_per_capita_filtered.csv", stringsAsFactors = FALSE)
co2_emissions <- read.csv("data/co2_emissions_filtered.csv", stringsAsFactors = FALSE)
urban_population <- read.csv("data/urban_population_percent_filtered.csv", stringsAsFactors = FALSE)

source("colnamefix.R")

### LEAFLET DATA SETUP ###
co2_formatted <- co2_emissions %>%
  gather(key = year, value = "CO2 Emissions (metric tons per capita)", 
         -Country.Name, -Country.Code, -Indicator.Name, -Indicator.Code) %>%
  select(-Indicator.Name, -Indicator.Code)

urban_formatted <- urban_population %>%
  gather(key = year, value = "percentpop", 
         -Country.Name, -Country.Code, -Indicator.Name, -Indicator.Code) %>%
  select(-Indicator.Name, -Indicator.Code)

urban_formatted$year <- sapply(urban_formatted$year, substr, 2, 5)
urban_formatted$year <- as.numeric(urban_formatted$year)
urban_formatted <- urban_formatted %>%
  filter(year < 2015)

co2_urban_formatted <- co2_formatted %>%
  mutate(
    "Percentage of Population in Urban Areas" = urban_formatted$percentpop
  )
co2_urban_formatted$year <- sapply(co2_urban_formatted$year, substr, 2, 5)

colnames(co2_urban_formatted)[1:3] <- c("Country.Name", "Country.Code",
                                        "Year")

world_map <- readOGR(dsn = "./data", layer = "TM_WORLD_BORDERS-0.3", stringsAsFactors = FALSE)

world_map@data <- select(world_map@data, -FIPS, -ISO2, -UN, -AREA, -POP2005, -NAME)
colnames(world_map@data)[1] <- "Country.Code"

co2_urban_mapdata <- left_join(co2_urban_formatted, world_map@data, by = "Country.Code")

backup_data <- world_map@data

### LEAFLET SETUP END

gdp_formatted <- gdp_per_capita %>%
  gather(key = year, value = "GDP per capita, in current US$", 
         -Country.Name, -Country.Code, -Indicator.Name) %>%
  select(-Indicator.Name)
gdp_formatted$year <- sapply(gdp_formatted$year, substr, 2, 5)
gdp_formatted$year <- as.numeric(gdp_formatted$year)
gdp_formatted <- gdp_formatted %>%
  filter(year < 2015)

all_data_global <- co2_urban_mapdata %>%
  mutate("GDP per capita, in current US$" = gdp_formatted$`GDP per capita, in current US$`) %>%
  select(-SUBREGION, -LON, -LAT)


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
year_choices <- year_choices[1:25]

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

all_three <- left_join(co2_and_urban, gdp_per_capita, by = "Country.Name")

## Data Processing for Comparative Column Chart

country_names <- all_three$Country.Name
indicator_names<- c(all_three$Indicator.Name.x[1], all_three$Indicator.Name.y[1], all_three$Indicator.Name[1])

co2_col <- co2_emissions %>%
  gather(key = year, value = "CO2 emissions (metric tons per capita)", 
         -Country.Name, -Country.Code, -Indicator.Name, -Indicator.Code) %>% 
  select(-Indicator.Code)


urban_col <- urban_population %>%
  gather(key = year, value = "Urban population (% of total)", 
         -Country.Name, -Country.Code, -Indicator.Name, -Indicator.Code) %>% 
  select(-Indicator.Code)


gdp_col <- gdp_per_capita %>% 
  gather(key = year, value = "GDP per capita (current US$)", 
         -Country.Name, -Country.Code, -Indicator.Name) 
