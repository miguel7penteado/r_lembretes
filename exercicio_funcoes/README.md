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

## Exercício 2

```R
suppressPackageStartupMessages(require(optparse))

lista_de_opcoes = list(
  make_option(c("-p1", "--parcela1"), action="store",       default=NA,          type='character', help="primeira parcela da soma"),
  make_option(c("-p2", "--parcela2"), action="store",       default=NA,          type='character', help="segunda parcela da soma"),
  make_option(c("-v", "--verbose"),   action="store_true",  default=TRUE,                          help="Mostra informações detalhadas do processo"),
  make_option(c("-q", "--quieto"),    action="store_false", dest="verbose",                        help="Não mostra informações, apenas resultados."),
  make_option(c("-c", "--cvar"),      action="store",       default="this is c",                   help="a variable named c, with a default [default %default]")  
)

opt = parse_args(OptionParser(option_list=lista_de_opcoes))

if (opt$v) {
    # you can use either the long or short name
    # so opt$a and opt$avar are the same.
    cat("avar:\n")
    cat(opt$avar)
    cat("\n\na:\n")
    cat(opt$a)
    
    # show the user what b and c are
    cat("\n\nb:\n")
    cat(opt$b)
    cat("\n\nc:\n")
    cat(opt$c)
    cat("\n\n")
    
    # show the user the difference between cat, write and print
    cat("cat(opt$c): \n")
    cat(opt$c) # does NOT produce its own \n
    cat("\n\nwrite(opt$c,file=stdout()): \n")
    write(opt$c,file=stdout()) # does produce its own \n
    cat("\n\nprint(opt$c,quote=FALSE): \n")
    print(opt$c,quote=FALSE) # no way to remove [1] from in front of line. does produce its own \n.
    cat("\n\n")
}

# main point of program is here, do this whether or not "verbose" is set
if(!is.na(opt$avar) & !is.na(opt$bvar)) {
    cat("here are strings a and b together at last:\n")
    cat(paste(opt$a,opt$b,sep=''))
    cat("\n\n")
} else {
    cat("you didn't specify both variables a and b\n", file=stderr()) # print error messages to stderr
}

```

```R
minha_funcao_1 <- function(parametro_1, parametro_2)
{
	saida <- parametro_1 + parametro_2
	return(saida)
}

resultado <- minha_funcao_1(1,2)

print(resultado)
```


