#!/usr/bin/env Rscript

cat("\n+*************************************************************+")
cat("\n|      Exercício simples de Matrizes                          |")
cat("\n+*************************************************************+")
cat("\n|                                                             |")
cat("\n+*************************************************************+")
cat("\n| Versão atual: 1.0                                           |")
cat("\n+*************************************************************+")
cat("\n| Mantenedor e desenvolvedor atual:                           |")
cat("\n| Miguel Suarez Xavier Penteado <miguel7penteado@gmail.com>   |")
cat("\n+*************************************************************+")
cat("\n")


message("desabilitando impressão em tela do nome do comando...")
options("source",echo=FALSE)

cat("\n| Gerando uma matriz simples de 3 linhas e 3 colunas ( 3x3)   |")
cat("\n| Matrizes diferem de tabelas por terem todos os seus         |")
cat("\n| elementos sendo do mesmo tipo (tudo numero, tudo string...) |")
cat("\n")

message("criando um vetor de 9 elementos, ou seja, 3 x 3...")
vetor <- c(1,2,3,4,5,6,7,8,9)

message("definindo a matriz 3x3 e preenchendo com o vetor anterior")
matriz <- matrix(vetor,nrow=3,ncol=3)

options("source",echo=TRUE)
matriz

options("source",echo=FALSE)
# Resultado deve ser algo assim:
#     [,1] [,2] [,3]
#[1,]    1    4    7
#[2,]    2    5    8
#[3,]    3    6    9



cat("\n| Gerando uma matriz simples de 3 linhas e 3 colunas ( 3x3)   |")
cat("\n| agora nomeando as linhas e colunas com a função matrix      |")
cat("\n")

message("criando um vetor de 9 elementos, ou seja, 3 x 3...")
vetor <- c(1,2,3,4,5,6,7,8,9)

message("criando um vetor que vai nomear as posições das 3 linhas")
nome_linha <- c("linha_1","linha_2","linha_3")

message("criando um vetor que vai nomear as posições das 3 colunas")
nome_coluna <- c("a","b","c")

message("gerando a matriz...")
matriz <- matrix(vetor,nrow=3,ncol=3,byrow=TRUE,dimnames=list(nome_linha,nome_coluna))

# Resultado:
#         a b c
#
#linha_1  1 2 3
#linha_2  4 5 6
#linha_3  7 8 9

options("source",echo=TRUE)
matriz


