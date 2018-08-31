#!/bin/bash

if ! command -v python2.7 &>/dev/null; then
    echo "Dependencia no encontrada: Python 2.7"
    exit 1
fi

# Descarga mxcoder/jsonpyes si es necesario
if [ ! -d ./jsonpyes ]; then
    echo "Descargando jsonpyes y dependencias"
    pip install -q --user elasticsearch
    curl -sS https://codeload.github.com/mxcoder/jsonpyes/zip/master > file.zip && unzip -qq file.zip
    mv jsonpyes-master jsonpyes && rm file.zip
fi

ES_HOST=${1:-"http://elastic:elastic@localhost:9200"}
INPUT_DIR=${2:-"./input/"}
ES_INDEX=${3:-"poder-sfp-compranet-ocds"}

echo "Comenzando:"
echo "ElasticSearch: $ES_HOST"
./_prepare.sh "$INPUT_DIR"
./_bulk.sh "$INPUT_DIR" "$ES_HOST" "$ES_INDEX"
echo "Fin"
