# Instalación y puesta en marcha de la herramienta

El presente proyecto esta desarrollado para poder iniciar los 3 servicios, según sea necesario de forma fácil y rápida.

## Pre-requisitos

1. Instalar Docker CE donde se desee ejecutar los contenedores.
    > Ver [Install Docker](https://docs.docker.com/install/)
1. Instalar Docker Compose
    > Ver [Install Docker Compose](https://docs.docker.com/compose/install/)
1. Descargar el contenido de este repositorio
    > Ver [Liga](https://codeload.github.com/mxcoder/elk-gobmx-csv/zip/master)

## Como iniciar el *Contenedor Servidor* (ElasticSearch y Kibana)

1. Descomprimir el archivo descargado
1. En el nuevo directorio ejecutar el comando `docker-compose -f elastic-kibana.yml up`

    - Pasados unos minutos deberíamos poder abrir en el navegador [http://localhost:5601/app/kibana](http://localhost:5601/app/kibana) lo cual nos dará acceso a Kibana.
    - El usuario y contraseña para acceder a Kibana son `elastic` y `elastic` respectivamente.

1. ElasticSearch y Kibana están listos para comenzar a recibir y visualizar datos.

> En este punto no tenemos datos en la base de datos ElasticSearch, así que ese debe ser el siguiente paso.

## Carga de datos OCDS automática

> TODO: CAMBIAR CUANDO SE TENGA LA NUEVA ESTRUCTURA DE DATOS

En los archivos descomprimidos podemos encontrar la carpeta `datasets/sfp-compranet-ocds`, dentro de ella encontraremos una pequeña herramienta para cargar los datos OCDS tal cual fueron publicados en sencillos pasos:

1. Entrar a la carpeta `datasets/sfp-compranet-ocds/`
1. Descargar los datos de [Datos Gob MX](https://datos.gob.mx/busca/dataset/concentrado-de-contrataciones-abiertas-de-la-apf) y extraer los archivos `*.json` en la carpeta `input`
1. Ejecutar los siguientes comandos:
    1. `docker build . -t sfp-compranet-ocds:latest`
    1. `docker run --rm -it -v $PWD/input:/input sfp-compranet-ocds`

Estas mismas instrucciones las pueden encontrar un poco más detalladas en: [datasets/sfp-compranet-ocds](/datasets/sfp-compranet-ocds/README.md)

[Inicio](../README.md) | [Anterior: Plataforma ELK para el Análisis de Contrataciones en formato OCDS](Seccion3.md) | [Siguiente: Procesamiento de datos con Logstash](Seccion5.md)
