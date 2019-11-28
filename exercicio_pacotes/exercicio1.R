#!/usr/bin/env Rscript

if (!require('devtools')) install.packages('devtools')
if (!require('rlang'))    install.packages('rlang')
if (!require('usethis'))  install.packages('usethis')
library(devtools)
library(usethis)

if (!require('roxygen2')) install_github("klutometis/roxygen")
library(roxygen2)

pacote_diretorio_temporario <- file.path("/tmp", "meupacote1")
usethis::create_package(pacote_diretorio_temporario)
usethis::proj_activate(pacote_diretorio_temporario)
usethis::use_package_doc()
usethis::use_git("Criação do pacote")
usethis::use_mit_license("Miguel Suez Xve Penteado")
usethis::use_readme_rmd()
usethis::use_readme_md()
usethis::use_news_md()
usethis::use_package("devtools", "Depends")
usethis::use_package("dplyr",    "Depends")
#usethis::use_dev_package("devtools", "Imports")
usethis::use_r("minhafuncao1")

descritor_arquivo<-file("R/minhafuncao1.R")
writeLines(
	c(
		"#\' Funcao minhafuncao1",
		"#\' Essa e uma funcao de exemplo para somar 2 numeros",
		"#\' @param parametro1 primeira parcela da soma",
		"#\' @param parametro2 segunda  parcela da soma",
		"#\' @keywords minhafuncao1",
		"#\' @export",
		"#\' @examples",
		"#\' @minhafuncao1()",
		"\n",
		"minhafuncao1 <- function(parametro1,parametro2)",
		"{",
		"	saida <- parametro1 + parametro2",
		"	return(saida)",
		"}",
		"\n"
	),descritor_arquivo)

close(descritor_arquivo)

arquivo_descritor_do_pacote<-file("DESCRIPTION")
writeLines(
        c(  
				"Package: meupacote1",
				"Title: Pacote meupacote1 criado para exemplificar empacotamento",
				"Version: 0.0.0.1",
				"Authors@R: ",
				"	person(given = \"Miguel\",",
				"		   family = \"Penteado\",",
				"		   role = c(\"aut\", \"cre\"),",
				"		   email = \"miguel7penteadot@gmail.com\",",
				"		   comment = c(ORCID = \"YOUR-ORCID-ID\"))",
				"Description: Este pacote vai te ensinar a fazer pacotes em R com 1 funcao.",
				"License: GPL",
				"Encoding: UTF-8",
				"LazyData: true",
                "\n",
                "\n"
        ),arquivo_descritor_do_pacote)

close(arquivo_descritor_do_pacote)

devtools::document()
#use_version("1.0.0")
devtools::build()
#install("/tmp/meupacote1")
install.packages("/tmp/meupacote1_0.0.0.1.tar.gz", repos=NULL, type="source")
library(meupacote1)
search()
teste <- meupacote1::minhafuncao1(1,2)
print(teste)
remove.packages("meupacote1")
search()




