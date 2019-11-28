#!/usr/bin/env Rscript

library(knitr)
library(rmdformats)

options(max.print="75")

opts_chunk$set(echo=FALSE,cache=TRUE,prompt=FALSE,tidy=TRUE,comment=NA,message=FALSE,warning=FALSE)
opts_knit$set(width=75)



minha_funcao_1 <- function(parametro_1, parametro_2)
{
	saida <- parametro_1 + parametro_2
	return(saida)
}

resultado <- minha_funcao_1(1,2)

print(resultado)

