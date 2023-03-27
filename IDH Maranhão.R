### MApas em r com geobr
### mapas do IDH municipal do Estado do Maranhão
### Elaboração: Paulo Roberto Carneiro de Sá
### 07/05/2020

#pacotes necessários
library(geobr)
library(ggplot2)
library(sf)
library(dplyr)
library(rio)
library(readr)
library(readxl)

library(geobr)
options(timeout= 4000000)
metadata<-download_metadata() # para ver codigos
head(metadata)

all_mun_ma <- read_municipality(code_muni=21, year=2018)

class(all_mun_ma)

library(readxl)
url <- "http://atlasbrasil.org.br/2013/data/rawData/atlas2013_dadosbrutos_pt.xlsx"
destfile <- "atlas2013_dadosbrutos_pt.xlsx"

#options(timeout= 4000000) # as vezes o site demora conforme sua internet
curl::curl_download(url, destfile)
atlas2013_dadosbrutos_pt <- read_excel(destfile, 
                                       sheet = "MUN 91-00-10")
dados_ma <- subset(atlas2013_dadosbrutos_pt, UF == '21' & ANO == '2010',
                   select=c(Codmun7,IDHM,IDHM_E,IDHM_L,IDHM_R))
print(dados_ma)
View(dados_ma)

all_mun_ma <- read_municipality(code_muni=21, year=2010)

dataset_final = left_join(all_mun_ma, dados_ma, by=c("code_muni"="Codmun7"))

max(dataset_final$IDHM) #0.768

min(dataset_final$IDHM) #0.443

########################################################################################
#IDHM

ggplot() +
  geom_sf(data=dataset_final, aes(fill=IDHM), color= NA, size=.15)+
  labs(title="IDHM 2013 (ano base 2010) dos Municipíos do MA",
       caption='Fonte: Elaboração própria', size=8)+
  scale_fill_distiller(palette = "Greens", limits=c(0.5, 0.8),
                       name="Code_muni")+
  theme_minimal()

########################################################################################
#IDH_E

max(dataset_final$IDHM_E) #0.752
min(dataset_final$IDHM_E) #0.286

ggplot() +
  geom_sf(data=dataset_final, aes(fill=IDHM_E), color= NA, size=.15) #grafico simples

ggplot() +
  geom_sf(data=dataset_final, aes(fill=IDHM_E), color= NA, size=.15)+
  labs(title="IDHM Educação 2013 (ano base 2010) dos Municipíos do MA",
       caption='Fonte: Elaboração própria', size=8) #grafico elaborado azul

ggplot() +
  geom_sf(data=dataset_final, aes(fill=IDHM_E), color= NA, size=.15)+
  labs(title="IDHM Educação 2013 (ano base 2010) dos Municipíos do MA",
       caption='Fonte: Elaboração própria', size=8)+
  scale_fill_distiller(palette = "Reds", limits=c(0.0, 1.0),
                       name="Code_muni")            ##grafico elaborado vermelho

#######################################################################################
# o mapa abaixo permite vizualizar melhor os melhores e piores indices do IDHM

ggplot() +
  geom_sf(data=dataset_final, aes(fill=IDHM), color= NA, size=.15)+
  labs(title="IDHM 2013 (ano base 2010) dos Municipíos do MA",
       caption='Fonte: Elaboração própria', size=8)+
  scale_fill_distiller(palette = "RdGy", limits=c(0.5, 0.8),
                       name="IDHM")+
  theme_minimal()













































































































































