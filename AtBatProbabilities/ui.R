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
      h4("Enter a pitcher's projected FIP for an at-bat"),
      numericInput("fip","Pitcher FIP",value=3.5,min=0,max=9,step=0.01),
      uiOutput("tab"),
      h4("Enter a batter's expected woba for an at-bat"),
      numericInput("xwoba","Batter xwOBA",value=0.320,min=.100,max=0.500,step=0.001),
      uiOutput("tab2"),
      submitButton("Submit")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      h3("Outcome probabilities"),
      h4("This tool takes pitcher and batter inputs (FIP and xwOBA) to project probabilities of the most common outcomes of an at-bat. This is based on modeling built on 2022 Statcast data for every pitch during the MLB regular season.
"),
      plotOutput("probabilityPlot")
    )
  )
)
