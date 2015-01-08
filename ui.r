
# ui.r
library(shiny)

# Define UI for lumberjack application
shinyUI(fluidPage(

  # Application title.
  titlePanel("Lumberjack App"),

  # Sidebar with sliderInput to input the height of the tree
  # in feet and the girth of the tree in inches.
  # The App calculates the volume of the tree in cubic feet.
  # The helpText function is also used to include clarifying text. 
  # The inclusion of a submitButton defers the rendering of output
  # until the user explicitly clicks the button (rather than
  # doing it immediately when inputs change). 
  
  sidebarLayout(
    sidebarPanel(
      
      sliderInput("Height", label = h3("Height of Tree in feet"), min = 63, 
        max = 87, value = c(70, 80)),
        
      helpText("Enter the range of the height of the tree in feet.",
               "The min and max of the range is determined by the",
               "model dataset. Your input must be within this range."),
               
      sliderInput("Girth", label = h3("Girth of Tree in inches"), min = 8.3, 
        max = 20.6, value = c(11, 17)),
        
      helpText("Enter the range of the girth (diameter) of the tree in inches.",
               "The min and max of the girth is determined by the",
               "model dataset. Your input must be within this range."),
                          
      submitButton("Update Tree Information")
    ),

    # Output the Tree Volume Predictions as an HTML table with the
    # inputed data and prediction intervals
    
    mainPanel(
      h3("Predict Tree Volumes in the Field on your Mobile"),
      h5(textOutput("text")),
      h3("Predicted Tree Volumes with 95% Prediction Intervals"),
      tableOutput("predictions")
    )
  )
))


