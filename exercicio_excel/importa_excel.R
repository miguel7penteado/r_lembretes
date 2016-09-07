
#!/usr/bin/env Rscript

options("source",echo=FALSE)

cat("\n+*************************************************************+")
cat("\n| Importando arquivo do Excell                                |")
cat("\n+*************************************************************+")
cat("\n|                                                             |")
cat("\n+*************************************************************+")
cat("\n| Versão atual: 1.0                                           |")
cat("\n+*************************************************************+")
cat("\n| Mantenedor e desenvolvedor atual:                           |")
cat("\n| Miguel Suarez Xavier Penteado <miguel7penteado@gmail.com>   |")
cat("\n+*************************************************************+")
cat("\n| Desenvolvedores originais:                                  |")
cat("\n| Miguel Suarez Xavier Penteado <miguel7penteado@gmail.com>   |")
cat("\n+*************************************************************+")
cat("\n")



cat("\n+*************************************************************+")
cat("\n|         Dicas legais para minha planilha                    |")
cat("\n+*************************************************************+")
cat("\n|                                                             |")
cat("\n| 1-Primiera linha reservo para  o cabeçalho, nome das colunas|")
cat("\n|                                                             |")
cat("\n| 2-Primeira coluna reservo para código                       |")
cat("\n|                                                             |")
cat("\n| 3-Evite espaço em branco em nomes compostos de colunas      |")
cat("\n|                                                             |")
cat("\n| 4-Valores faltantes eu preencho com NA                      |")
cat("\n|                                                             |")
#cat("\n| 5- Evite os caracteres e seguir na nomeação:                |")
#cat("\n|                                                             |")
#cat("\n| ?, $,%, ^, &, *, (, ),-,#, ?,,,<,>, /, |, \, [ ,] ,{, }     |")
#cat("\n|                                                             |")
cat("\n+*************************************************************+")
cat("\n")

message(" 1- Limpando os projetos anteriores da memória...")
rm(list=ls())

message("descubra qual seu diretório de trabalho atual...")
getwd()

# Estou usando linux. Se você usa windows use
# o formato c:\Users\fulano_de_tal\Documentos\R\Laboratorio\exercicio1\

message("Selecione seu diretório onde esta sua planilha...")
setwd("/home/sp-miguel/Documents/R/Laboratorio/exercicio1/")

cat("\n+*************************************************************+")
cat("\n| Importando planilhas com o pacote XLConnect                 |")
cat("\n+*************************************************************+")
cat("\n")

message("Obtendo a biblioteca, XLConnect por download... ")
install.packages("XLConnect")

message("Carregando a biblioteca XLConnect ...")
library(XLConnect) 

message("Carregando minha planilha ...")
minha_planilha_r <- readWorksheetFromFile("arquivo1.xls", sheet = 1)

cat("\n+*************************************************************+")
cat("\n| Testando a minha planilha carregada...                      |")
cat("\n+*************************************************************+")
cat("\n")

message("Listando objetos em memória...")
ls()

message("Listar o conteúdo da minha planilha...")
print(minha_planilha_r)

cat("\n+*************************************************************+")
cat("\n| Filtrando minha \"planilha\" - meu DataFrame                |")
cat("\n+*************************************************************+")
cat("\n")

message("Agora quero que me mostre a dimensão da minha planilha...")
dim(minha_planilha_r)

message("Mostre-me a primeira linha da minha planilha...")
head(minha_planilha_r,1)

message("Mostre-me as primeiras 2 linhas da minha planilha...")
head(minha_planilha_r,2)

message("Estatísticas descritivas de cada coluna...")
summary(minha_planilha_r)

message("Extraindo a coluna de idade de cada pessoa...")
coluna_idade_extraida <- minha_planilha_r["idade"]

message("Estatísticas descritivas da coluna idade...")
summary(coluna_idade_extraida)


