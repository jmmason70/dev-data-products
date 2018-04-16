#
# This is the server logic of my Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
#

# load libraries
library(shiny)
library(dplyr)  # Needed for subsetting data using the select function
library(leaflet)

# Define server logic required to draw the leaflet map
shinyServer(function(input, output, session){
  
  # Define event for when the action button is pressed 
  observeEvent(input$action, {
    
    # Define the data to use for the outputs using data from the citydata and distancedata
    # data frames imported from .csv files (citydata.csv and distancedata.csv)
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
        addCircleMarkers(lng=citydata$lng, lat=citydata$lat, label=citydata$city, weight=4, fill=TRUE, radius=5, labelOptions=labelOptions(noHide=TRUE, 
                                                                                                                                           textOnly=TRUE)) %>%
        addPolylines(lng = c(city1latlng$lng, city2latlng$lng), lat = c(city1latlng$lat, city2latlng$lat), weight = 3, fillOpacity = 0.5, color = 
                       "red")
    })
  })
})
