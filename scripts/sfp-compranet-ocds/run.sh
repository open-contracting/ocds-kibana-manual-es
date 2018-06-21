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

ES_HOST=${1:-"http://localhost:9200"}

echo "Comenzando:"
echo "ElasticSearch: $ES_HOST"
./_prepare.sh
./_bulk.sh "$ES_HOST"
echo "Fin"
