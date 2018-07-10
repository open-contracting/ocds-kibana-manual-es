#!/bin/bash

# Argumentos posicionales
LINES_DIR=$1
if [ ! -d "$LINES_DIR" ]; then
    LINES_DIR=`pwd`
fi
LINES_DIR="$LINES_DIR/*.lines"
ES_HOST=${2:-"http://localhost:9200"}

if [ ! -d ./jsonpyes ] || [ ! -f ./jsonpyes/jsonpyes.py ]; then
    echo "Dependencia no encontrada: jsonpyes"
    exit 1
fi

# Instala template
curl -X PUT "$ES_HOST/poder-sfp-compranet-ocds" -H 'Content-Type: application/json' -d'@template.json'

# Comienza la carga de cada archivo
shopt -s nullglob
for filename in $LINES_DIR
do
    echo "Procesando y enviando: $filename"
    ./jsonpyes/jsonpyes.py --bulk $ES_HOST --import --index poder-sfp-compranet-ocds --type _doc --data "$filename" > "${filename/%.lines/.log}"
done
