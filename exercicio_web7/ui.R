library(shiny)
library(shinyapps)

interface <- fluidPage(
  sliderInput(inputId = "objeto_r_entrada", label = "Escolha um numero", value = 25 , min =1 , max = 100),
  actionButton(inputId = "botao_r", label = "Atualizar" ),
  textInput(inputId = "minha_caixa_texto", label = "Titulo", value = "Histograma" ),
  plotOutput("meu_objeto_r"),
  verbatimTextOutput("meu_objeto_r_2")
 
);
# interface tem funções de entrada e saida
# Com a associacao a inputId, objeto_r_entrada passa a ser um objeto reativo.
