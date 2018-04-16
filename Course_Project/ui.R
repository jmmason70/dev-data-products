#
# This is the user-interface definition of my Shiny web application. You can
# run the application by clicking 'Run App' above.
#
#

# Load libraries
library(shiny)
library(leaflet)

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
