# Plataforma ELK para datos de Contratos en formato OCDS (Open Contracting)

## Manual

- [Manual](docs/README.md)

## Pre-requisitos
- [Docker](https://docs.docker.com/install/)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Instrucciones básicas

### Iniciar servidor ElasticSearch + Kibana

Ejecutar `docker-compose -f elastic-kibana.yml up` para levantar los servicios.

Abrir en el navegador [http://localhost:5601/](http://localhost:5601/app/kibana) lo cual nos dara acceso Kibana.

### Procesamiento de datos

Para tomar los datos publicados en OCDS y poder ingresarlos en la plataforma ELK debemos seguir las instrucciones en [Pipeline](./pipeline/README.md)
