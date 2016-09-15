#!/usr/bin/env Rscript

cat("\n+*************************************************************+")
cat("\n| Servidor - planilha google - R                              |")
cat("\n+*************************************************************+")
cat("\n|                                                             |")
cat("\n+*************************************************************+")
cat("\n| Versão atual: 1.0                                           |")
cat("\n+*************************************************************+")
cat("\n| Mantenedor atual e desenvolvedor:                           |")
cat("\n| Miguel Suarez Xavier Penteado <miguel7penteado@gmail.com>   |")
cat("\n+*************************************************************+")
cat("\n|                                                             |")
cat("\n|                                                             |")
cat("\n|                                                             |")
cat("\n+*************************************************************+")
cat("\n")

print(Sys.setenv(DIRETORIO_DO_PROJETO_R = "projeto_mapa_r", "A+C" = 123))
Sys.getenv("DIRETORIO_DO_PROJETO_R")
Sys.unsetenv("DIRETORIO_DO_PROJETO_R")


message("desligando temporariamente a impressão dos comandos...")
options("source",echo=FALSE)

cat("\n+*****************************************************************************************")
sessionInfo()
cat("\n+*****************************************************************************************")
cat("\n")

if ( .Platform$OS.type == 'unix' ) 
{	
	cat("\n+*****************************************************************************************+")
	cat(sprintf("\n|Definindo o diretório de trabalho - $HOME/analise_pand_continua/%s ...|",Sys.getenv("DIRETORIO_DO_PROJETO_R")))
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
		cat(sprintf("\n|Definindo o diretório de trabalho - C:\\%HOMEPATH%\\analise_pand_continua\\%s ...|",Sys.getenv("DIRETORIO_DO_PROJETO_R")))
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
cat(sprintf("\n|Carregando pacotes... - %s |",Sys.Date()))
cat("\n+*****************************************************************************************+")
cat("\n")

message("Setando repositorios...")
r = getOption("repos")
r["CRAN"] = "https://vps.fmvz.usp.br/CRAN/"
options(repos = r)
rm(r)

vetor_pacotes <- c( "shiny", "googlesheets" ,"DT")

message("Instalando pacotes shiny googlesheets DT ")
install.packages( vetor_pacotes )


library(shiny)
library(googlesheets)
library(DT)

minha_chave <- "1Bs0OH6F-Pdw5BG8yVo2t_VS9Wq1F7vb_VovOmnDSNf4"
my_ss <- gs_key(minha_chave)
meus_dados <- gs_read(my_ss)

options("source",echo=FALSE)

shinyServer(function(entrada, saida, sessao_usuario)
{
	saida$plot <- renderPlot({	meus_dados$type <- ordered(meus_dados$type, levels=c("PRE","POST")) boxplot=(meus_dados$score~meus_dados$type,ylim=c(0,100),boxwex=0.6)  })

	saida$summary <- renderPrint({ aggregate(score~type,data=meus_dados, summary) })

	saida$the_data <- renderDataTable({ datatable(meus_dados) })
	
})

