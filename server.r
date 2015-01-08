
# server.r
library(shiny)
library(datasets)

# Define SERVER for lumberjack application
# Generate the model using the Cylindrical Tree Algorithm, that is,
# Tree volume is the product of height and cross sectional area
Trees<- trees
Trees$logGirth<- log10(Trees$Girth)
Trees$logHeight<- log10(Trees$Height)
Trees$logVolume<- log10(Trees$Volume)

model<- lm(logVolume ~  logHeight + logGirth, data=Trees)

Text<-c("The Lumberjack App will calculate Tree Volume in cubic feet from tree height and girth information that you provide. Use the 'sliders' to input your data.")

# Define server logic required to summarize and view the
# predicted volumes

shinyServer(function(input, output) {

  # Calculate the predicted volume and prediction interval given the inputed Height and Girth vectors
  predictModel <- reactive({
    newdata<- data.frame(logHeight=log10(input$Height), logGirth=log10(input$Girth))
    logPrediction<- as.data.frame(predict(model, newdata=newdata, interval='prediction'))
      predictedVolume<- 10^(logPrediction$fit)
      lowerBound<- 10^(logPrediction$lwr)
      upperBound<- 10^(logPrediction$upr)
      
      Height<- input$Height 
      Girth<- input$Girth 

    Prediction<- data.frame(Height, Girth, predictedVolume, lowerBound, upperBound)
  })
  # Output Text information
  output$text<- renderText({
    Text
  })
    
  # Output the Prediction dataframe as a rendered table
  output$predictions <- renderTable({
    predictModel()
  })
})

