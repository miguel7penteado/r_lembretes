library(shiny)
library(shinyapps)

interface <- fluidPage(
  sliderInput(inputId = "obtido_usuario", label = "Escolha um numero", value = 25 , min =1 , max = 100),
  plotOutput("mostre_ao_usuario")
    
);
# interface tem funções de entrada e saida


servidor <- function(input, output)
{
  output$mostre_ao_usuario <- renderPlot({ hist( rnorm(input$obtido_usuario) ) })
  
}

shinyApp(ui = interface, server = servidor)

