setwd("~/Datos-Viajeros-BBB")

### Proyecto: "Datos Viajeros BBB" ####

# install.packages("rvest")
library('rvest')

###### Exracción de información de la tabla (clima) ##############

# Se asigna la url generada a la variable paginaVoyHoyClima
paginaVoyHoyClima <- 'https://www.voyhoy.com/blog/mejor-epoca-visitar-san-pedro-atacama-clima-consejos-2-2/'

#Leyendo el HTML del archivo
webpagblogclima <- read_html(paginaVoyHoyClima)

#Extrayendo el contenido de la tabla a traves de tag
contenedorDeTablas <- html_nodes(webpagblogclima, "table")

# Extraccion informacion tabla 1
tabla1<- html_table(contenedorDeTablas  [[2]])

# Viendo el contenido de la posicion 1,2 de la tabla1
print(tabla1[1])

# Pasanso tabla a dataframe
dfTabla <- as.data.frame(tabla1)


##################################################################
###### Creando grafico para el clima #############################
##################################################################


# Usando la libreria ggplot2
library('ggplot2')

# Grafico de barra con el clima temperatura mínima
tabla1 %>%
  ggplot() +
  aes(x = X1 , y = X3) +
  geom_bar(stat="identity")

# Grafico de barra con el clima temperatura máxima
tabla1 %>%
  ggplot() +
  aes(x = X1 , y = X2) +
  geom_bar(stat="identity")

# GrÃ¡fico boxplot con el clima temperatura mínima
tabla1 %>%
  ggplot() +
  geom_boxplot(aes(x = X1, y = X3)) +
  theme_bw()

# GrÃ¡fico boxplot con el clima temperatura máxima
tabla1 %>%
  ggplot() +
  geom_boxplot(aes(x = X1, y = X2)) +
  theme_bw()


############################################################
###### Views por cada consejo ##############################
############################################################

paginaconcuenta<-'https://www.voyhoy.com/blog/category/consejos-viajeros/'

webpagecuenta<- read_html(paginaconcuenta)

# Extraccion del texto contenido en la clase meta-views
cuentaviews<- html_nodes(webpagecuenta, ".meta-views")

textocuenta<- html_text(cuentaviews)

# viendo el contenido de la variable cuentaviews
print(textocuenta)

# Pasanso views a dataframe
dfViews <- as.data.frame(textocuenta)


##################################################################
###### Extraer titulo de cada consejo ############################
##################################################################

# Se asigna la url generada a la variable paginaVoyHoyConsejos
paginaVoyHoyConsejos <- 'https://www.voyhoy.com/blog/category/consejos-viajeros/'

#leyendo el HTML del archivo
webpagConsejos <- read_html(paginaVoyHoyConsejos)

#Extrayendo contenido en la clase 
contenidoConsejo <- html_nodes(webpagConsejos,'h2')

#Pasando la info a texto 
textoConsejo <- html_text(contenidoConsejo)

# viendo el contenido de la variable cuentaviews
print(textoConsejo)

# Pasanso consejos a dataframe
dfTitulos <- as.data.frame(textoConsejo)

##################################################################
###### Unir ambos df #############################################
##################################################################

UnionTablas <- merge(dfTitulos,dfViews)

#guardar la informacion en cvs
write.csv(UnionTablas, file = "TablaMix.cvs")

##############################################################

#guardar la informacion en cvs
write.csv(dfTabla, file = "TablaClima.cvs")
write.csv(dfTitulos, file = "TablaConsejos.cvs")
write.csv(dfViews, file = "TablaViews.cvs")
