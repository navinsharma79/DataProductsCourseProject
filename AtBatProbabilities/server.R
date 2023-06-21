#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(tidyr)
library(ggplot2)

function(input, output, session) {
  prob_table <- read.csv("../data/outcome_probs_xwoba.csv")
  
  output$probabilityPlot <- renderPlot({
    batter_xwoba <- input$xwoba
    fip <- input$fip
    
    # hack-ey solution for now to convert FIP to xwoba
    # 2.50 is .240
    # 5.3 is .360
    pitcher_xwoba <- ((.120)/(5.3-2.5))*(fip-2.5)+.240
    
    # this is the regression data to predict expected woba based on the pitcher and batter info
    #Coefficients:
    #(Intercept)      xwoba_p      xwoba_b  
    #-0.2648       0.9228       0.9365 
    
    xwoba=(pitcher_xwoba*.9228+batter_xwoba*.9365-.2648)
    
    bin_min <- min(prob_table$xwoba)
    bin_max <- max(prob_table$xwoba)
    bin_width <-(bin_max-bin_min)/(max(prob_table$xwoba_bin)-min(prob_table$xwoba_bin))
    
    xwoba <- ifelse(xwoba<bin_min,bin_min,xwoba)
    xwoba <- ifelse(xwoba>bin_max,bin_max,xwoba)
    
    bin <- floor((xwoba-bin_min)/bin_width + min(prob_table$xwoba_bin))
    
    plot_data <- (prob_table %>% filter(xwoba_bin==bin))[4:9] %>% pivot_longer(cols=everything())
    
    ggplot(data=plot_data,aes(x=name,y=value)) + geom_bar(stat="identity") + labs(x="Batting Event",y="Probability")
    
  })
  
  url <- a("What is FIP?", href="https://www.mlb.com/glossary/advanced-stats/fielding-independent-pitching")
  output$tab <- renderUI({
    tagList(url)
  })
  
  url2 <- a("What is xwOBA?", href="https://www.mlb.com/glossary/statcast/expected-woba")
  output$tab2 <- renderUI({
    tagList(url2)
  })
  
  
}
