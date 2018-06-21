#!/bin/bash

# Argumentos posicionales
ES_HOST=${1:-"http://localhost:9200"}
THREADS=${2:-4}

if [ ! -d ./jsonpyes ] || [ ! -f ./jsonpyes/jsonpyes.py ]; then
    echo "Dependencia no encontrada: jsonpyes"
    exit 1
fi

# Comienza la carga de cada archivo
shopt -s nullglob
for filename in *.lines
do
    echo "Procesando y enviando: $filename"
    ./jsonpyes/jsonpyes.py --threads $THREADS --bulk $ES_HOST --import --index poder-sfp-compranet-ocds --type records --data "$filename" > "${filename/%.lines/.log}"
done
