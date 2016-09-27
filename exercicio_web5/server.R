library(shiny)
library(shinyapps)

servidor <- function(input, output)
{
	dados_instantaneos <- reactive({ rnorm(input$objeto_r_entrada) })	
	
	output$meu_objeto_r <- renderPlot({ hist( dados_instantaneos() ) })
	output$meu_objeto_r_2 <- renderPrint({ summary( dados_instantaneos() ) })
  
}

# input$objeto_r_entrada é compreendido por renderPlot.
# funçao reactive é executada todas as vezes que existe mudança nos 
# dados de entrada.



