library(httr)
library(jsonlite)
library(tibble)

# API key
apikey = "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJibXVuaXpAbW9uZHJhZ29uLmVkdSIsImp0aSI6IjM5N2Y0Zjg2LTE0N2MtNGFjYy05ZjI4LTExYjZiODk3NzE4MCIsImlzcyI6IkFFTUVUIiwiaWF0IjoxNjQ3MjY0NzA4LCJ1c2VySWQiOiIzOTdmNGY4Ni0xNDdjLTRhY2MtOWYyOC0xMWI2Yjg5NzcxODAiLCJyb2xlIjoiIn0.h4cBR_lOro719PbcSJ_4J3DtggMDV2dCcyolWDWv6TQ"

# URL base y destino API
url_base <- "https://opendata.aemet.es/opendata/"
api_dist <- "api/prediccion/especifica/municipio/diaria/11035"

# URL combinada.
url <- paste0(url_base, api_dist)

# Obtenemos la respuesta del GET
response <- httr::GET(
  url = url, 
  add_headers(api_key = apikey)
)

# Nos quedamos con la parte del contenido solo.
# En texto plano.
content <- httr::content(response, as = "text", encoding = "UTF-8")

# Pasamos de texto plano a tibble
data_tibble <- jsonlite::fromJSON(content)
data_tibble <- tibble::as_tibble(data_tibble)

# Nos interesa principalmente la URL de los datos
url_datos = data_tibble$datos

# Volvemos a hacer otro GET para lograr los datos definitivos
response_datos <- httr::GET(
  url = url_datos,
  add_headers(api_key = apikey)
)

# Nos quedamos con el contenido
datos <- httr::content(response_datos)

# Lo pasamos a tibble
datos <- jsonlite::fromJSON(datos)
datos <- tibble::as_tibble(datos)

# Los datos meteo estan mas anidados aun
datos_meteo <- datos$prediccion$dia[[1]]
