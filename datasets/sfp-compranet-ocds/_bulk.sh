#!/bin/bash

# Argumentos posicionales
ES_HOST=${1:-"http://elastic:elastic@localhost:9200"}

if [ ! -d ./jsonpyes ] || [ ! -f ./jsonpyes/jsonpyes.py ]; then
    echo "Dependencia no encontrada: jsonpyes"
    exit 1
fi

# Comienza la carga de cada archivo
shopt -s nullglob
for filename in *.lines
do
    echo "Procesando y enviando: $filename"
    ./jsonpyes/jsonpyes.py --bulk $ES_HOST --import --index dev-poder-sfp-compranet-ocds --type _doc --data "$filename" > "${filename/%.lines/.log}"
done
