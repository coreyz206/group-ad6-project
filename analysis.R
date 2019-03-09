### PLACEHOLDER ###
library("ZillowR")
library("httr")
library("jsonlite")
library("plyr")
library("dplyr")
library("XML")


source("api_key.R")


base_uri <- "http://www.zillow.com/webservice/"
neighborhood_endpoint <- "GetRegionChildren.htm?"
demographics_endpoint <- "GetDemographics.htm"

response_zillow <- GET(paste0(base_uri, neighborhood_endpoint, "zws-id=", zwsid, "&state=", "wa", "&city=seattle"))

response_test <- GET("http://www.zillow.com/webservice/GetRegionChildren.htm?zws-id=X1-ZWz1gy3bbhi1hn_211k7&state=wa&city=seattle&childtype=neighborhood")
#response_chart <- GET("http://www.zillow.com/webservice/GetRegionChart.htm?zws-id=X1-ZWz1gy3bbhi1hn_211k7&state=wa&city=seattle&childtype=neighborhood")
response_zillow_text <- content(response_zillow, "text")
response_zillow_data <- xmlParse("GetRegionChildren.xml")


response_zillow_text
response_zillow_data




