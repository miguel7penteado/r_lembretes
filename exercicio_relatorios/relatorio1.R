#!/usr/bin/env Rscript

cat("\n+*************************************************************+")
cat("\n| Carregamento de relatorio com a função plot                 |")
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

print(Sys.setenv(DIRETORIO_DO_PROJETO_R = "projeto_relatorio_r", "A+C" = 123))
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

	cat(sprintf("Gerando diretório /projeto_relatorio_r/%s ...\n",Sys.Date()))
	system(sprintf("mkdir -p ~/projeto_relatorio_r/%s",Sys.Date()))
	setwd(sprintf("~/projeto_relatorio_r/%s",Sys.Date()))
	system("pwd")
	message("Definindo mapa de caracteres com suporte a acentuação e virgula - pt_BR.UTF-8")
	options( encoding="UTF-8" )
#    options( encoding="ISO-8859-1" )
	
} else{
	if ( .Platform$OS.type == 'windows' ) 
	{	
		cat("\n+*****************************************************************************************+")
		cat(sprintf("\n|Definindo o diretório de trabalho - C:\\%HOMEPATH%\\analise_pand_continua\\%s ...|",Sys.getenv("DIRETORIO_DO_PROJETO_R")))
		cat("\n+*****************************************************************************************+")
		cat("\n")

		cat(sprintf("Gerando diretório C:\\%HOMEPATH%\\exercicio_r_mapas\\%s\n'' ...",Sys.Date()))
		system(sprintf("mkdir C:\\%HOMEPATH%\\projeto_relatorio_r\\%s\\",Sys.Date()))
		setwd(sprintf("C:\\%HOMEPATH%\\projeto_relatorio_r\\%s\\",Sys.Date()))
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

vetor_pacotes <- c( "downloader" ,
                    "RCurl" ,
                    "setwidth",
                    "devtools",
                    "rgdal",
                    "plyr",
                    "ggplot2",
                    "lattice",
                    "rgeos",
                    "mapview",
                    "sp")

message("baixando pacotes e instalando downloader RCurl setwidth devtools rgdal plyr ggplot2 lattice rgeos sp ")
install.packages( vetor_pacotes )

library(sp)
library(ggplot2)
library(gstat)


message("Carregando minha funcao de download...")
source_url("https://raw.githubusercontent.com/miguel7penteado/ibge_r_pnad_continua/master/UTF-8/funcao_download.R" , prompt = FALSE , echo = FALSE)

#endereco_do_shape_zipado_na_net <- "https://github.com/miguel7penteado/r_lembretes/raw/master/exercicio_mapas/shapes.zip"

cat("\n+*****************************************************************************************+")
cat(sprintf("\n|Gerando o relatorio a partir dos dados Orange do R  |")
cat("\n+*****************************************************************************************+")
cat("\n")

plot(Orange$age,Orange$circumference, xlab="Idade",ylab="Circunferência",col="blue",main="Plantação:",pch=20)
