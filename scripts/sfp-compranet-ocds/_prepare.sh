#!/bin/bash

# Usando los archivos JSON originales, separa cada entrada en lineas nuevas de archivos homonimos con extension .lines

## Quita las llaves cuadradas ([, ]) del nivel mas alto
## Separa en lineas cada ',{"_id"'
## Quita las comas al final de cada linea
## Quita las lineas vacias
## Reemplaza los campos "_id" en "id", esto se hace porque ElasticSearch no permite campos llamados "_id"
## El campo records.releases.planning.relatedProjects.totalValue.amount en algunas ocasiones necesita arreglo
## Todo se envia a un nuevo archivo

JSON_DIR=$1
if [ ! -d "$JSON_DIR" ]; then
    JSON_DIR=`pwd`
fi
JSON_DIR="$JSON_DIR/*.json"
echo "Buscando archivos en: $JSON_DIR"

shopt -s nullglob;
for filename in $JSON_DIR
do
    if [ -f "$filename" ] && [ -s "$filename" ]; then
        echo "Procesando $filename"
        cat $filename \
            | sed -e 's/^\[\|\]$//g' \
            | sed 's/\(,\)\?{"_id"/\n{"_id"/g' \
            | sed 's/,$//' \
            | sed '/^$/d' \
            | sed 's/"_id"/"id"/g' \
            | sed 's/{"\$numberLong":"\([0-9]\+\)"}/\1/g' \
            > "${filename/%.json/.lines}"
    fi
done
