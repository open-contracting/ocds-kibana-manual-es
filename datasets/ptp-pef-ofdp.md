# PTP - Presupuesto de Egresos de la Federacion - Formato OFDP

Datos descargables en: [PTP - Estándar Internacional de Datos Presupuestarios Abiertos](http://transparenciapresupuestaria.gob.mx/es/PTP/datos_presupuestarios_abiertos)

Se incluyen muestras al 1% de los originales y diccionario de datos en `./sources/ptp/pef/ofdp`

## ElasticSearch

- **Indice**: `poder-ptp-pef-ofdp`
- **Mappings**: Definidos en `./logstash/templates/ptp-pef-ofdp.json`

## LogStash

Pipeline definido en `./logstash/pipelines/ptp-pef-ofdp.conf`

### Módulos de entrada:
- File: A la escucha de archivos .csv en la carpeta `./logstash/input/ptp-pef-ofdp`

### Módulos de salida:
- Consola
- ElasticSearch, indice: `poder-ptp-pef-ofdp`

Cada documento esta indexado con el conjunto de los IDs disponibles (**WIP**)

## Instrucciones para probar el Pipeline
1. Asegurarse que el indice este creado en ElasticSearch (enviar `PUT poder-ptp-pef-ofdp`)
  1. Se puede comprobar con `GET _cat/_indices?v`
  1. LogStash al inicializarse ha instalado un template para los mappings de este indice
1. Copiar el/los archivo(s) CSV con formato OFDP a la carpeta `./logstash/input/ptp-pef-ofdp`
1. LogStash debe detectar los nuevos archivos y procesarlos
1. Al finalizar podemos ir a Kibana y crear el Index Pattern **SIN** usar timestamp.
