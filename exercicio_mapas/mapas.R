#!/usr/bin/env Rscript

cat("\n+*************************************************************+")
cat("\n| Carregamento de um mapa (camada vetorial) usando shapefile  |")
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
	setwd(sprintf("~/exercicio_r_mapas%s",Sys.Date()))
	system("pwd")
	message("Definindo mapa de caracteres com suporte a acentuação e virgula - pt_BR.UTF-8")
#	options( encoding="pt_BR.UTF-8" )
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
install.packages( c( "downloader" , "RCurl" , "setwidth" , "devtools" ) )

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
source_url("https://raw.githubusercontent.com/miguel7penteado/ibge_r_pnad_continua/master/funcao_download.R" , prompt = FALSE , echo = FALSE)

cat("\n+*****************************************************************************************+")
cat(sprintf("\n|baixando da internet o shapefile - %s |",system())
cat("\n+*****************************************************************************************+")
cat("\n")

endereco_do_shape_zipado_na_net <- "ftp://ftp.ibge.gov.br/Trabalho_e_Rendimento/Pesquisa_Nacional_por_Amostra_de_Domicilios_continua/Trimestral/Microdados/Documentacao/Dicionario_e_input_20160817.zip"

nome_do_shape_zipado <- "shape_zipado"

message("Baixando o arquivo de dicionáriod e variáveis da internet...")
download_cached( endereco_do_shape_zipado_na_net , nome_do_shape_zipado , mode = 'wb' )

message("Descompactando shape zipado no driretorio local...")
arquivos_descompactados <- unzip( nome_do_shape_zipado , exdir = getwd() )


cat(sprintf("\n+*****************************************************************************************+"))
cat(sprintf("\n|  Arquivos formato RDA guardados em %s                                                   |",getwd()))
cat(sprintf("\n|  Processo finalizado !                                                                  |"))
cat(sprintf("\n+*****************************************************************************************+"))
cat(sprintf("\n###########################################################################################"))
cat(sprintf("\n"))

options("source",echo=TRUE)



