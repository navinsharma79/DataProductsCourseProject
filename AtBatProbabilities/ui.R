#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
fluidPage(
  
  # Application title
  titlePanel("Predicting batting outcomes based on pitcher and batter inputs"),
  
  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      h3("Input Pitcher and Batter Information"),
      numericInput("fip","Pitcher FIP",value=3.5,min=0,max=9,step=0.01),
      uiOutput("tab"),
      numericInput("xwoba","Batter xwOBA",value=0.320,min=.100,max=0.500,step=0.001),
      uiOutput("tab2"),
      submitButton("Submit")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      h3("Outcome probabilities"),
      plotOutput("probabilityPlot")
    )
  )
)
