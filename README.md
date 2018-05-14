# ELK Stack para consumo de datasources CSV de GobMX y PTP

## Pre-requisitos
- [Docker](https://docs.docker.com/install/)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Instrucciones

Ejecutar `docker-compose up` para levantar los tres servicios del ELK stack:
- ElasticSearch
- LogStash
- Kibana

Abrir en el navegador `http://localhost:5601/app/kibana` lo cual nos dara acceso a los Dev Tools de Kibana.

## Datasets

[PTP - Presupuesto de Egresos de la Federacion - Formato OFDP](./datasets/ptp-pef-ofdp.md)
