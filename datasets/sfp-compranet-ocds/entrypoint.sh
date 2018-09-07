#!/bin/bash

shopt -s nullglob;
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

ES_HOST=${ES_HOST:-"localhost:9200"}
KBN_HOST="${ES_HOST//:9200/:5601}"
ES_INDEX=${ES_INDEX:-"sfp-compranet-ocds-compiled-releases"}
FILE_EXT=${1:-".json"}

INPUT_FILES="/input/*$FILE_EXT"
RECORDS_FILES="/data/*.records"
COUNTER=0

ES_PING="$(curl -s "$ES_HOST" | jq -crM '.tagline | tostring')"

echo -e "
Este proceso cargara a ElasticSearch los datos extraidos de los archivos .json \
de los procedimientos de contratacion de la APF en JSON por paquetes.\

${RED}
Atencion: este proceso puede tardar bastante tiempo, dependiendo de la cantidad \
de datos, la velocidad del procesamiento de datos y de la carga al servidor.

${GREEN}Servidor ElasticSearch:${NC} $ES_HOST ($ES_PING)
${GREEN}Indice en ElasticSearch:${NC} $ES_INDEX
${GREEN}Archivos seleccionados:${NC} $INPUT_FILES
"

# Checar si podemos conectar con ElasticSearch
if [ "$ES_PING" != "You Know, for Search" ]; then
    echo -e "${RED}No pudimos encontrar el servidor ElasticSearch: $ES_HOST ${NC}"
    exit 1
fi

# Iniciar procesamiento de datos
for FILE in $INPUT_FILES
do
    BASENAME=`basename $FILE`
    LINESFILE="${BASENAME/%$FILE_EXT/.records}"
    echo -e "Procesando $FILE, por favor espere."
    jq -crM ".[].records[]" "$FILE" | sed 's/{"$numberLong":"\([^"]\+\)"}/\1/g' > "/data/$LINESFILE"
    COUNTER=$((COUNTER+1))
done

if [ $COUNTER -eq 0 ]; then
    echo -e "${RED}No se encontraron archivos que procesar${NC}"
    exit 1
else
    echo -e "${GREEN}Se encontraron " `cat $RECORDS_FILES | wc -l` " registros, preparando carga...${NC}"
fi

# Iniciar carga a ElasticSearch

echo
echo -e "Recreando indice: $ES_HOST/$ES_INDEX"
curl -w "\n" -s -XDELETE "$ES_HOST/$ES_INDEX" > /dev/null
curl -w "\n" -s -H "Content-Type: application/json" -XPUT "$ES_HOST/$ES_INDEX" --data-binary @/opt/template.json > /dev/null
curl -w "\n" -s -XGET "$ES_HOST/_cat/indices" | grep "$ES_INDEX"

echo
echo -e "Logstash esta enviando los datos al Servidor ElasticSearch, por favor espere."
cat $RECORDS_FILES | ES_HOST="$ES_HOST" ES_INDEX="$ES_INDEX" /usr/share/logstash/bin/logstash > /logs/logstash.log 2>&1
if [ $? -eq 0 ]; then
    echo -e "${GREEN}Carga finalizada${NC}"
    # Crea el index pattern en kibana de forma automatica, asumiendo que Kibana está en el mismo host que ElasticSearch
    echo -e "Intentando crear Index Pattern en Kibana"
    KBN_ID=$(curl -s -f -XPOST "$KBN_HOST/api/saved_objects/index-pattern" -H 'kbn-version: 6.4.0' -H 'Content-Type: application/json' --data-binary "{\"attributes\":{\"title\":\"$ES_INDEX\"}}" | jq -crM '.id')
    if [ -n "$KBN_ID" ]; then
        curl -s -XPOST -H 'Content-Type: application/json' -H 'kbn-version: 6.4.0' "$KBN_HOST/api/kibana/settings/defaultIndex" -d"{\"value\":\"$KBN_ID\"}" > /dev/null
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}Kibana está listo: $KBN_HOST/app/kibana#/discover"
        fi
    fi
else
    echo -e "${RED}Ocurrio un error, favor de reportar con el siguiente contenido${NC}"
    cat /logs/logstash.log
fi
