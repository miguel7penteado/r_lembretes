library(shiny)
library(shinyapps)

servidor <- function(input, output)
{
  output$mostre_ao_usuario <- renderPlot({ hist( rnorm(input$obtido_usuario) ) })
  
}



