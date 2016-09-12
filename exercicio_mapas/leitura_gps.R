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

library(gdalUtils)
library(rgdal)


caminho <- readOGR(dsn = "./arquivo.gpx", layer="tracks")

pontos_colhidos <- readOGR(dsn = "./arquivo.gpx", layer="track_points")

plot(caminho, col="coral4", lwd=2)
plot(pontos_colhidos, add=TRUE, pch=16, col="chartreuse4")

