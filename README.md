# ELK Stack para consumo de datasources CSV de GobMX y PTP

## Pre-requisitos
- [Docker](https://docs.docker.com/install/)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Instrucciones

Ejecutar `docker-compose up` para levantar los tres servicios del ELK stack:
- ElasticSearch
- LogStash
- Kibana

*Nota:Se usan las imagenes oficiales de elastic.co SIN paquetes extra*

Abrir en el navegador `http://localhost:5601/app/kibana` lo cual nos dara acceso a los Dev Tools de Kibana.

## Datasets

[PTP - Presupuesto de Egresos de la Federacion - Formato OFDP](./datasets/ptp-pef-ofdp.md)

...

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

#### Enviar POST requests con payloads

Se recomienda usar [HTTPie](https://httpie.org/) para mejor ergonomia y luego:
```
http POST http://localhost:8080/ @/path/file.csv
```
O
```
http POST http://localhost:8080/ < /path/file.csv
```
