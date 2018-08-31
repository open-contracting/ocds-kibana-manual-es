# ELK Stack para consumo de datasources CSV de GobMX y PTP

## Manual

- [Manual](docs/README.md)

## Pre-requisitos
- [Docker](https://docs.docker.com/install/)
- [Docker Compose](https://docs.docker.com/compose/install/)

*Nota:Se usan las imagenes oficiales de elastic.co*

## Instrucciones

### Iniciar ElasticSearch + Kibana

Ejecutar `docker-compose -f elastic-kibana.yml up` para levantar los servicios.

Abrir en el navegador `http://localhost:5601/app/kibana` lo cual nos dara acceso a los Dev Tools de Kibana.


### Iniciar Logstash para procesamiento de datos

Ejecutar `docker-compose -f logstash.yml up` para levantar el servicio de Logstash.

Seguir las instrucciones de cada dataset

## Datasets

- [PTP - Presupuesto de Egresos de la Federacion - Formato OFDP](./datasets/ptp-pef-ofdp/)
- [Datos Gob MX / SFP - Compranet - Contratos Ingresados a Compranet](./datasets/sfp-compranet-contratos/)
- [Datos Gob MX / SFP - Compranet - Contratos OCDS](./datasets/sfp-compranet-ocds/)

## Extras

#### Crear muestras de archivos originales

Para la creacion de archivos mas pequenos y manejables se ha usado [shuf](https://en.wikipedia.org/wiki/Shuf)

Como:
```
shuf -n NUMERO_ENTRADAS_DESEADAS -o OUTPUTFILE INPUTFILE
```

Ejemplo:
```
shuf -n 1000 -o pef.sample.csv pef.full.csv
```
