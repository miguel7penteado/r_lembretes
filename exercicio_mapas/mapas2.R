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
                    "spatstat",
                    "maptools",
                    "maps",
                    "RColorBrewer",
                    "grDevices",
                    "reshape2",
                    "rCharts",
                    "knitr",
                    "base64enc",
                    "googleVis",
                    "sp")

library(plyr)         # Para manipular dados
library(ggplot2)      # Para ter a interface gráfica ggplot2
library(lattice)      # Para ter a interface gráfica Lattice
library(rgdal)        # Para carregar "shapefiles" dentro do R
library(rgeos)        # Para usar operações geométricas
library(spatstat)     # Para usar tesselação de Voronoi
library(sp)           # Metodod para obter coordenadas de objetos espaciais.
library(maptools)     # Um pacote para construir mapas.
library(maps)         # Um pacote para construir mapas.
library(RColorBrewer) # Um pacote para construir paletas de cor.
library(grDevices)    # Um pacote para construir paletas de cor.
library(reshape2)     # Um pacote para trasnformar dados com maior facilidade.
library(rCharts)      # Um pacote para criar e customizar visualizações interativas de javascript em R
library(knitr)        # Um pacote para geração de relatórios dinamicos
library(base64enc)    # Ferramentas para codificação em base64
suppressPackageStartupMessages(library(googleVis)) # Para usar com visualização Google.


message("baixando pacotes e instalando SAScci downloader RCurl setwidth devtools")
install.packages( vetor_pacotes )

message("Carregando biblioteca devtools para obter colorout do github...")
library(devtools)

message("Baixando e instalando biblioteca colorout...")
install_github("jalvesaq/colorout")
message("Carregando...")
library(colorout)

message("Baixando e instalando biblioteca webmap...")
install_github("RCura/webmaps")
message("Carregando...")
library(webmaps)

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

sirgas_2000_geografico <- CRS("+init=epsg:4674")

message("Carregando o shape setores...")
shapefile_setores <- readOGR(diretorio_atual, layer="SETORES",verbose=TRUE)
message("Covertendo sistema de coordenadas...")
shapefile_setores <- spTransform(shapefile_setores,sirgas_2000_geografico)
message("Verificando de shapefile_setores é um dataframe espacial...")
class(shapefile_setores)
message("Verificando os atributos de shapefile_setores")
attributes(shapefile_setores@data)

message("Carregando o shape municipios...")
shapefile_municipios <- readOGR(diretorio_atual, layer="MUNICIPIOS",verbose=TRUE)
message("Covertendo sistema de coordenadas...")
shapefile_municipios <- spTransform(shapefile_municipios,sirgas_2000_geografico)
message("Verificando de shapefile_municipios é um dataframe espacial...")
class(shapefile_municipios)
message("Verificando os atributos de shapefile_municipios")
attributes(shapefile_municipios@data)


#cbind
#rbind


message("Verificando se os sistemas de coordenadas são os mesmos:")
identical(proj4string(shapefile_municipios),proj4string(shapefile_setores))

osmMap(camada_setores,camada_municipios,title="Setores do Municipio")


cat(sprintf("\n+*****************************************************************************************+"))
cat(sprintf("\n|  Arquivos formato RDA guardados em %s                                                   |",getwd()))
cat(sprintf("\n|  Processo finalizado !                                                                  |"))
cat(sprintf("\n+*****************************************************************************************+"))
cat(sprintf("\n###########################################################################################"))
cat(sprintf("\n"))

message("Slavando o shapefile no diretorio local...")
writeOGR(trees, dsn=".", layer="SETORES_ALTERADO", driver="ESRI Shapefile")

options("source",echo=TRUE)



