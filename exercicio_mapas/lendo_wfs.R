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

dsn <- "WFS:http://geomap.reteunitaria.piemonte.it/ws/gsareprot/rp-01/areeprotwfs/wfs_gsareprot_1?service=WFS&request=getCapabilities"

ogrinfo(dsn, so=TRUE)
## [1] "Had to open data source read only."
## [2] "INFO: Open of `WFS:http://geomap.reteunitaria.piemonte.it/ws/gsareprot/rp-01/areeprotwfs/wfs_gsareprot_1?service=WFS&request=getCapabilities'"
## [3] "      using driver `WFS' successful."
## [4] "1: AreeProtette"
## [5] "2: ZPS"  
## [6] "3: SIC"

ogr2ogr(dsn, "sic.shp", "SIC")

sic <- readOGR("sic.shp", "sic", stringsAsFactors=FALSE)
## OGR data source with driver: ESRI Shapefile 
## Source: "sic.shp", layer: "sic"
## with 128 features
## It has 23 fields

plot(sic)
