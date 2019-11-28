# Exercício sobre criar funções em R

## Exercício 1

```R
library(knitr)
library(rmdformats)
```
```R
options(max.print="75")

opts_chunk$set(echo=FALSE,cache=TRUE,prompt=FALSE,tidy=TRUE,comment=NA,message=FALSE,warning=FALSE)
opts_knit$set(width=75)
```

```R
minha_funcao_1 <- function(parametro_1, parametro_2)
{
	saida <- parametro_1 + parametro_2
	return(saida)
}
```
```R
resultado <- minha_funcao_1(1,2)

print(resultado)
```



