library(shiny)
library(shinyapps)

servidor <- function(input, output)
{
  output$meu_objeto_r <- renderPlot({ hist( rnorm(input$objeto_r_entrada) ) })
  output$meu_objeto_r_2 <- renderPrint({ summary( rnorm(input$objeto_r_entrada) ) })
  
}

# input$objeto_r_entrada é compreendido por renderPlot.


