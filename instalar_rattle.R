#!/usr/bin/env Rscript

system("apt-get update ")
system("apt-get install -y libcairo2-dev libfontconfig1-dev libexpat1-dev libexpat1 libx11-xcb-devlibxt-dev libbabl-dev libgegl-dev mesa-common-dev libglu1-mesa-dev libcurl4-openssl-dev libxml2-dev")

system("apt-get install -y r-cran-*")

#R CMD INSTALL ggplot2_0.9.1.tar.gz

options("source",echo=FALSE)

system("R CMD javareconf")

message("Apagando objetos de sessões anteriores...")
rm(list=ls(all=TRUE))

cat("\n+*****************************************************************************************+")
cat("\n| Baixando bibliotecas:                                                                   |")
cat("\n+*****************************************************************************************+")
cat("\n")

message("Setando repositorios...")
r = getOption("repos")
r["CRAN"] = "https://vps.fmvz.usp.br/CRAN/"
options(repos = r)
rm(r)

message("baixando pacotes e instalando SAScci downloader RCurl setwidth devtools")
install.packages( c( "SAScii" , "downloader" , "RCurl" , "setwidth" , "devtools" ) )

message("Carregando biblioteca devtools para obter colorout do github...")
library(devtools)

message("Baixando e instalando biblioteca colorout...")
install_github("jalvesaq/colorout")

message("Carregando biblioteca colorout...")
library(colorout)
message("Carregando biblioteca setwidth...")
library(setwidth)
message("Carregando biblioteca SAScci...")
library(SAScii) 
message("Carregando biblioteca downloader...")
library(downloader)	
message("Carregando biblioteca RCurl...")
library(RCurl)

install.packages("highlight", dependencies = c("Depends", "Suggests"))
install.packages("Rcpp", dependencies = c("Depends", "Suggests"))
install.packages("formatR", dependencies = c("Depends", "Suggests"))
install.packages("highr", dependencies = c("Depends", "Suggests"))

install.packages("Cairo", dependencies = c("Depends", "Suggests"))
install.packages("mime", dependencies = c("Depends", "Suggests"))
install.packages("rgl", dependencies = c("Depends", "Suggests"))
install.packages("shiny", dependencies = c("Depends", "Suggests"))
install.packages("knitr", dependencies = c("Depends", "Suggests"))
install.packages("rglwidget", dependencies = c("Depends", "Suggests"))
install.packages("curl", dependencies = c("Depends", "Suggests"))
install.packages("NMF", dependencies = c("Depends", "Suggests"))

install.packages("igraph", dependencies = c("Depends", "Suggests"))
install.packages("arules", dependencies = c("Depends", "Suggests"))
install.packages("arulesViz", dependencies = c("Depends", "Suggests"))
install.packages("biclust", dependencies = c("Depends", "Suggests")) :
install.packages("fpc", dependencies = c("Depends", "Suggests")) :
install.packages("readxl", dependencies = c("Depends", "Suggests")) :
install.packages("rggobi", dependencies = c("Depends", "Suggests")) :

install.packages("rattle", dependencies=c("Depends", "Suggests"))
library(rattle)
rattle()

