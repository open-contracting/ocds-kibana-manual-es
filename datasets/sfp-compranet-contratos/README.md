# Datos Gob MX / SFP - Compranet - Contratos Ingresados a Compranet

Datos descargables en: [Datos Gob MX](https://datos.gob.mx/busca/dataset?q=Contratos+ingresados+a+CompraNet+201&organization=sfp&sort=title_string+desc)

Se incluyen muestras al 1% de los originales y diccionario de datos en `./data/diccionario.xlsx`

## ElasticSearch

- **Indice**: `poder-sfp-compranet-contratos`
- **Mappings**: Definidos en `./template.json`

## LogStash

Pipeline definido en `./pipeline.conf`

### Módulos de entrada:
- File: A la escucha de archivos .csv en la carpeta `./input/`

### Módulos de salida:
- Consola
- ElasticSearch, indice: `poder-sfp-compranet-contratos`

Cada documento esta indexado con el conjunto de los IDs disponibles (**WIP**)

## Instrucciones para probar el Pipeline
1. Asegurarse que el indice este creado en ElasticSearch (enviar `PUT poder-sfp-compranet-contratos`)
  1. Se puede comprobar con `GET _cat/_indices?v`
  1. LogStash al inicializarse ha instalado un template para los mappings de este indice
1. Copiar el/los archivo(s) CSV con formato OFDP a la carpeta `./input/`
1. LogStash debe detectar los nuevos archivos y procesarlos
1. Al finalizar podemos ir a Kibana y crear el Index Pattern **SIN** usar timestamp.
