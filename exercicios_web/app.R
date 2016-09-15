#!/usr/bin/env Rscript

cat("\n+*************************************************************+")
cat("\n| Carregamento de uma pagina web - versão 1                   |")
cat("\n+*************************************************************+")
cat("\n|                                                             |")
cat("\n+*************************************************************+")
cat("\n| Versão atual: 1.0                                           |")
cat("\n+*************************************************************+")
cat("\n| Mantenedor e desenvolvedor atual:                           |")
cat("\n| Miguel Suarez Xavier Penteado <miguel7penteado@gmail.com>   |")
cat("\n+*************************************************************+")
cat("\n|                                                             |")
cat("\n|                                                             |")
cat("\n|                                                             |")
cat("\n+*************************************************************+")
cat("\n")

message("desligando temporariamente a impressão dos comandos...")
options("source",echo=FALSE)

#R.version()

if ( .Platform$OS.type == 'unix' ) 
{	
	cat("\n+*****************************************************************************************+")
	cat(sprintf("\n|Definindo o diretório de trabalho - $HOME/analise_pand_continua/%s ...|",Sys.Date()))
	cat("\n+*****************************************************************************************+")
	cat("\n")

	cat(sprintf("Gerando diretório /exercicio_r_mapas/%s ...\n",Sys.Date()))
	system(sprintf("mkdir -p ~/exercicio_r_mapas/%s",Sys.Date()))
	setwd(sprintf("~/exercicio_r_mapas/%s",Sys.Date()))
	system("pwd")
	message("Definindo mapa de caracteres com suporte a acentuação e virgula - pt_BR.UTF-8")
#	options( encoding="UTF-8" )
    options( encoding="ISO-8859-1" )
	
} else{
	if ( .Platform$OS.type == 'windows' ) 
	{	
		cat("\n+*****************************************************************************************+")
		cat(sprintf("\n|Definindo o diretório de trabalho - C:\\%HOMEPATH%\\analise_pand_continua\\%s ...|",Sys.Date()))
		cat("\n+*****************************************************************************************+")
		cat("\n")

		cat(sprintf("Gerando diretório C:\\%HOMEPATH%\\exercicio_r_mapas\\%s\n'' ...",Sys.Date()))
		system(sprintf("mkdir C:\\%HOMEPATH%\\exercicio_r_mapas\\%s\\",Sys.Date()))
		setwd(sprintf("C:\\%HOMEPATH%\\exercicio_r_mapas\\%s\\",Sys.Date()))
		system("cd")
		message("Definindo mapa de caracteres com suporte a acentuação e virgula do windows - windows-1252")
		message("também definido como em sistemas de Banco de Dados como ISO-8859-1")
		options( encoding="windows-1252" )
	}
}

if ( .Platform$OS.type == 'unix' ) 
{	
#	print("Por favor aguarde um instante a instalação dos pacotes gdal")
#	print(" e proj no linux ")
#	system("sudo apt-get update && sudo apt-get install libgdal-dev libproj-dev libclc-amdgcn libclc-r600")
	
} else
{
	if( .Platform$OS.type == 'windows' )
	{
#		print("Vamos ver se existem instalados os pacotes gdal")
#		print(" e proj for windows...  ")
#		system(" dir ")

	}
}	

message("Apagando objetos de sessões anteriores...")
rm(list=ls(all=TRUE))

cat("\n+*****************************************************************************************+")
cat(sprintf("\n|IMPORTANDO UM ARQUIVO VETORIAL USANDO WEBMAPS - %s |",Sys.Date()))
cat("\n+*****************************************************************************************+")
cat("\n")

message("Setando repositorios...")
r = getOption("repos")
r["CRAN"] = "https://vps.fmvz.usp.br/CRAN/"
options(repos = r)
rm(r)

message("baixando pacotes e instalando SAScci downloader RCurl setwidth devtools")
install.packages( c( "downloader" , "RCurl" , "setwidth" , "devtools" , "rgdal", "sp") )

message("Carregando biblioteca devtools para obter colorout do github...")
library(devtools)

message("Baixando e instalando biblioteca colorout...")
install_github("jalvesaq/colorout")
message("Carregando...")
library(colorout)

message("Baixando e instalando biblioteca webmap...")
install_github("RCura/webmaps")

install.packages(c("shiny","rgdal"))

library(shiny)

minha_tela <- "Primeira aplicação !"

servidor <- function(input=entrada, output=saida, session=sessao)
{
	
}

shinyApp(minha_tela,servidor)

options("source",echo=TRUE)


