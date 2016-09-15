#!/usr/bin/env Rscript

cat("\n+*************************************************************+")
cat("\n| Carregamento de uma camada vetorial                         |")
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
library(rgdal)
library(mapview)


message("Carregando minha funcao de download...")
source_url("https://raw.githubusercontent.com/miguel7penteado/ibge_r_pnad_continua/master/UTF-8/funcao_download.R" , prompt = FALSE , echo = FALSE)

endereco_do_shape_zipado_na_net <- "https://github.com/miguel7penteado/r_lembretes/raw/master/exercicio_mapas/shapes.zip"

cat("\n+*****************************************************************************************+")
cat(sprintf("\n|baixando da internet o shapefile  |",endereco_do_shape_zipado_na_net))
cat("\n+*****************************************************************************************+")
cat("\n")

diretorio_atual <- getwd()
nome_do_shape_zipado <- "shape_zipado.zip"


message("Baixando o arquivo de dicionáriod e variáveis da internet...\n")
download_cached( endereco_do_shape_zipado_na_net , nome_do_shape_zipado , mode = 'wb' )

message("Descompactando shape zipado no driretorio local...")
#arquivos_descompactados <- unzip( nome_do_shape_zipado , exdir= diretorio_atual  )
system(sprintf("unzip %s",nome_do_shape_zipado))

shapefile_penapolis <- shapefile_carregado
shapefile_penapolis$eixo_x <- shapefile_carregado$LONGITUDE
shapefile_penapolis$eixo_y <- shapefile_carregado$LATITUDE
coordinates(shapefile_penapolis) = ~eixo_x + eixo_y
eixo_x.range <- as.numeric(c(-50.51, -49.75))  
eixo_y.range <- as.numeric(c(-21.60, -21.19))  

grade_mapa <- expand.grid(eixo_x = seq(from = eixo_x.range[1], to = eixo_x.range[2], by = 0.002), eixo_x = seq(from = eixo_y.range[1], to = eixo_y.range[2], by = 0.002))  # expand points to grid
coordinates(grade_mapa) <- ~eixo_x + eixo_y
gridded(grade_mapa) <- TRUE

message("Interpolação usando distancia inversa ponderada... - idw ")
DistanciaIvensaPonderada <- idw(formula = temp ~ 1, locations = shapefile_penapolis, newdata = grade_mapa)

idw.saida = as.shapefile_carregado.frame(DistanciaIvensaPonderada)  # output is defined as a shapefile_carregado table

names(idw.saida)[1:3] <- c("long", "lat", "temp")
idw.saida <- idw.saida[,1:3]

coordinates(idw.saida) <- ~long+lat
morocco <- readOGR("Data/morocco/TNG", "TNG")
proj4string(idw.saida)<-proj4string(morocco)
tempData <- idw.saida[morocco,]
proj4string(shapefile_penapolis)<-proj4string(morocco)
gridded(tempData) <- TRUE
m<-mapView(tempData, zcol = "temp") + shapefile_penapolis
m
