# Pipeline Logstash for procurement data in OCDS format (Open Contracting)
[Versión en Español](#user-content-pipeline-logstash-para-datos-de-contratos-en-formato-ocds-open-contracting)

Data can be downloaded in: [Datos Gob MX](https://datos.gob.mx/busca/dataset/concentrado-de-contrataciones-abiertas-de-la-apf)

It is necessary to download [data packages](https://datos.gob.mx/busca/dataset/concentrado-de-contrataciones-abiertas-de-la-apf/resource/ed1ec7e5-61ae-4d00-8adc-67c77844e75c)

The documentation of OCDS scheme can be found here: [Open Contracting](http://standard.open-contracting.org/latest/en/getting_started/)

## Dependency

- ElasticSearch Server
- Docker

### ElasticSearch

- **Index**: `sfp-compranet-ocds-compiled-releases`

## Instructions to use this script

1. Download data packages, which should entail one or several .json files.
1. Unzip .json files into the `input` folder.

Execute the following commands in this folder:

1. `docker build . -t logstash-sfp-compranet-ocds:latest`
    This will generate our container, which will allow us to run the process with all the dependencies we need.
    **This command should only be executed one time**

1. `docker run --rm -it --net="host" -v $PWD/logs:/logs:rw -v $PWD/input:/input logstash-sfp-compranet-ocds`

    This command can receive the following parameters
    * `-e "ES_HOST=servidor.com:9200"` It specifies the hostname of the ElasticSearch server (default:`localhost:9200`)
    * `-e "ES_INDEX=nombre-indice"` It specifies the index name to use in ES (defaul:`sfp-compranet-ocds-compiled-releases`)

    Example:
    ```
    docker run --rm -it --net="host" -v $PWD/logs:/logs:rw -v $PWD/input:/input -e "ES_HOST=example.org:9200" logstash-sfp-compranet-ocds
    ```

1. When this procedure is over, we will be able to review the data in ElasticSearch and Kibana.


# Pipeline Logstash para datos de Contratos en formato OCDS (Open Contracting)

Datos descargables en: [Datos Gob MX](https://datos.gob.mx/busca/dataset/concentrado-de-contrataciones-abiertas-de-la-apf)

Se requiere descargar los [datos por paquetes](https://datos.gob.mx/busca/dataset/concentrado-de-contrataciones-abiertas-de-la-apf/resource/ed1ec7e5-61ae-4d00-8adc-67c77844e75c)

La documentacion del esquema OCDS se puede encontrar en: [Open Contracting](http://standard.open-contracting.org/latest/en/getting_started/)

## Dependencias

- Servidor ElasticSearch
- Docker

### ElasticSearch

- **Indice**: `sfp-compranet-ocds-compiled-releases`

## Instrucciones para usar este script

1. Descargar los paquetes de datos, deben consistir de uno o varios archivos .json
1. Extraer los archivos .json en la carpeta `input`

Ejecutar en esta carpeta los siguientes comandos:

1. `docker build . -t logstash-sfp-compranet-ocds:latest`
    Esto generará nuestro contenedor para correr el proceso con todas las dependencias necesarias.
    **Este comando solo tendremos que ejecutarlo una vez**

1. `docker run --rm -it --net="host" -v $PWD/logs:/logs:rw -v $PWD/input:/input logstash-sfp-compranet-ocds`

    Este comando puede recibir los siguientes parametros
    * `-e "ES_HOST=servidor.com:9200"` Especifica el hostname del servidor ElasticSearch (default:`localhost:9200`)
    * `-e "ES_INDEX=nombre-indice"` Especifica el nombre del indice a usar en ES (defaul:`sfp-compranet-ocds-compiled-releases`)

    Ejemplo:
    ```
    docker run --rm -it --net="host" -v $PWD/logs:/logs:rw -v $PWD/input:/input -e "ES_HOST=example.org:9200" logstash-sfp-compranet-ocds
    ```

1. Al finalizar este procedimiento ya podremos consultar los datos en ElasticSearch y Kibana.



