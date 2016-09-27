library(shiny)
library(shinyapps)

interface <- fluidPage(
  sliderInput(inputId = "objeto_r_entrada", label = "Escolha um numero", value = 25 , min =1 , max = 100),
  plotOutput("meu_objeto_r"),
  verbatimTextOutput("meu_objeto_r_2")
 
);
# interface tem funções de entrada e saida
# Com a associacao a inputId, objeto_r_entrada passa a ser um objeto reativo.
