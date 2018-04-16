#
# This is the server logic of my Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
#

# load libraries
library(shiny)
library(dplyr)  # Needed for subsetting data using the select function
library(leaflet)

# Create data
citydata <- data.frame(
  city = c('Atlanta', 'Chicago', 'Denver', 'Houston', 'Los Angeles', 'Miami', 'New York', 'San Francisco', 'Seattle', 'Washington, DC'),
  lat = c(33.7490, 41.8781, 39.7392, 29.7604, 34.0522, 25.7617, 40.7128, 37.7749, 47.6062, 38.9072),
  lng = c(-84.2880, -87.6298, -104.9903, -95.3698, -118.2437, -80.1918, -74.0060, -122.4194, -122.3321, -77.0369)
)

distancedata <- data.frame(
  destcity = c('Atlanta', 'Chicago', 'Denver', 'Houston', 'Los Angeles', 'Miami', 'New York', 'San Francisco', 'Seattle', 'Washington, DC'),
  'Atlanta' = c(NA, 587, 1212, 701, 1936, 604, 748, 2139, 2182, 543), 
  'Chicago' = c(587, NA, 920, 940, 1745, 1188, 713, 1858, 1737, 597),
  'Denver' = c(1212, 920, NA, 879, 831, 1726, 1631, 949, 1021, 1494),
  'Houston' = c(701, 940, 879, NA, 1374, 968, 1420, 1645, 1891, 1220),
  'Los Angeles' = c(1936, 1745, 831, 1374, NA, 2339, 2451, 347, 959, 2300),
  'Miami' = c(604, 1188, 1726, 968, 2339, NA, 1092, 2594, 2734, 923),
  'New York' = c(748, 713, 1631, 1420, 2451, 1092, NA, 2571, 2408, 205),
  'San Francisco' = c(2139, 1858, 949, 1645, 347, 2594, 2571, NA, 678, 2442),
  'Seattle' = c(2182, 1737, 1021, 1891, 959, 2734, 2408, 678, NA, 2329),
  'Washington, DC' = c(543, 597, 1494, 1220, 2300, 923, 205, 2442, 2329, NA),
  check.names=F
)

# Define server logic required to draw the leaflet map
shinyServer(function(input, output, session){
  
  # Define event for when the action button is pressed 
  observeEvent(input$action, {
    
    # Define the data to use for the outputs using data from the citydata and distancedata
    # city1latlng and city2latlng will grab the latitude and longitude of the two selected 
    # cities in the UI from citydata and will be used to draw the red polyline on the leaflet map.
    city1 <- input$city1
    city2 <- input$city2
    city1latlng <- select(filter(citydata, city == city1),c(lat,lng))
    city2latlng <- select(filter(citydata, city == city2),c(lat,lng))
    
    # mileage will grab the distance between the two selected cities in the UI from distancedata
    # and will be used for output$miles
    mileage <- (select(filter(distancedata, destcity == city1),c(city2)))
    
    output$cities <- renderText({
      paste("The distance from ", city1, "to ", city2, "is:" )
    })
    
    output$miles <- renderText({
      paste(mileage, "miles")
    })
    
    # This will draw a leaflet map with corresponding circle markers and city names for each city
    # and will draw a red line between the two selected cities in the UI
    output$map <- renderLeaflet({
      leaflet() %>%
        addTiles() %>%
        addCircleMarkers(lng=citydata$lng, lat=citydata$lat, label=citydata$city, weight=4, fill=TRUE, radius=5, labelOptions=labelOptions(noHide=TRUE, textOnly=TRUE)) %>%
        addPolylines(lng = c(city1latlng$lng, city2latlng$lng), lat = c(city1latlng$lat, city2latlng$lat), weight = 3, fillOpacity = 0.5, color = "red")
    })
  })
})
