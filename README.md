# ELK Stack para consumo de datasources CSV de GobMX y PTP

## Manual

- [Manual](docs/README.md)

## Pre-requisitos
- [Docker](https://docs.docker.com/install/)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Instrucciones

### Iniciar servidor ElasticSearch + Kibana

Ejecutar `docker-compose -f elastic-kibana.yml up` para levantar los servicios.

Abrir en el navegador [http://localhost:5601/](http://localhost:5601/app/kibana) lo cual nos dara acceso Kibana.

### Datasets disponibles

- [Datos Gob MX / SFP - Compranet - Contratos OCDS](./datasets/sfp-compranet-ocds/)
- [PTP - Presupuesto de Egresos de la Federacion - Formato OFDP](./datasets/ptp-pef-ofdp/)
- [Datos Gob MX / SFP - Compranet - Contratos Ingresados a Compranet](./datasets/sfp-compranet-contratos/)
