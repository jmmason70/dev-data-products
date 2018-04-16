#
# This is the user-interface definition of my Shiny web application. You can
# run the application by clicking 'Run App' above.
#
#

# Load libraries
library(shiny)
library(leaflet)

# Create data
citydata <- data.frame(
  city = c('Atlanta', 'Chicago', 'Denver', 'Houston', 'Los Angeles', 'Miami', 'New York', 'San Francisco', 'Seattle', 'Washington, DC'),
  lat = c(33.7490, 41.8781, 39.7392, 29.7604, 34.0522, 25.7617, 40.7128, 37.7749, 47.6062, 38.9072),
  lng = c(-84.2880, -87.6298, -104.9903, -95.3698, -118.2437, -80.1918, -74.0060, -122.4194, -122.3321, -77.0369)
)

# Define UI for application that draws a map based on selected inputs
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Distances Between Two Major US Cities."),
  
  # Sidebar with widgets for dropdown inputs for starting and ending cities and action button. 
  sidebarLayout(
    sidebarPanel(
      helpText("Pick a departure city and a destination city from the below drop down menus and then click GO.  
               The distance between the two cities will be displayed."),
      
      selectInput("city1", 
                  label = "Starting City:",
                  choices = citydata$city,
                  selected = "Atlanta"),
      selectInput("city2",
                  label = "Ending City:",
                  choices = citydata$city,
                  selected = "Chicago"),
      actionButton("action",
                   label = "GO!")
      ),
    
    # Show text output and a leaflet map circle markers, city names, and a red polyline between selected cities.
    mainPanel(
      
      h3(textOutput("cities")),
      h3(textOutput("miles")),
      leafletOutput("map")
    )
  )
)
)
