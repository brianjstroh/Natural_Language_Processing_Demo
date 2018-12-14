#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

source("Predict_Next.R")

shinyServer(function(input, output) {
      
      hide(id = "loading-content", anim = TRUE, animType = "fade")    
      show("my-content")
      next_words <- reactive({
            predict_next10(input$phrase)
      })
      
      output$words <- renderTable({
            head(next_words(), n = input$num_suggestions)
      })
})

