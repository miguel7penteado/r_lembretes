# Exercício sobre criação de pacotes em `R`

```{R, 1-Carga de Pacotes}

#!/usr/bin/env Rscript

if (!require('devtools')) install.packages('devtools')
if (!require('rlang'))    install.packages('rlang')
if (!require('usethis'))  install.packages('usethis')
library(devtools)
library(usethis)

if (!require('roxygen2')) install_github("klutometis/roxygen")
library(roxygen2)

```
