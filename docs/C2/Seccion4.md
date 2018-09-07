# Puesta en marcha de la Plataforma ELK para el Análisis de Contrataciones en formato OCDS

Al final de esta sección tendremos todo lo necesario hacer consultas y visualizaciones sobre los datos de Contrataciones en formato OCDS.

> Para este procedimiento se recomienda tener familiaridad básica con la terminal de comandos
    * [Mac](https://www.soydemac.com/abrir-terminal-mac/)
    * [Windows](https://www.wikihow.com/Open-the-Command-Prompt-in-Windows)
    * [Linux/Ubuntu](https://elblogdeliher.com/como-moverse-por-los-directorios-en-la-terminal-de-ubuntu/)

## Objetivos

1. Iniciar un servidor ElasticSearch con Kibana
1. Cargar los datos publicados de Contrataciones en un formato sencillo de consultar.
1. Realizar una consulta sobre los datos

El presente proyecto esta desarrollado para poder iniciar los 3 servicios, según sea necesario de forma fácil y rápida.


## Pre-requisitos

1. Abrir la terminal para comandos del Sistema Operativo
1. [Instalar Docker CE](https://docs.docker.com/install/)
1. [Instalar Docker Compose](https://docs.docker.com/compose/install/)
1. [Descargar el archivo que contiene las
   herramientas](https://github.com/ProjectPODER/elk-gobmx-csv/archive/master.zip)
1. Descomprimir el archivo descargado y entrar a la carpeta que se acaba de crear
    * En la terminal: `cd elk-gobmx-csv-master`

## Iniciar el *Contenedor Servidor* con ElasticSearch y Kibana

Ahora podremos iniciar el servidor ejecutando el siguiente comando en la terminal:
```
docker-compose -f elastic-kibana.yaml up
```
> Este comando le indica al programa Docker que debe crear un contenedor segun lo indicado en el archivo
> `elastic-kibana.yaml`, en el mismo indicamos que ambos programas deben iniciarse.

Pasados unos *minutos*<sup>1</sup> deberiamos poder abrir en el navegador web la dirección
[http://localhost:5601/app/kibana](http://localhost:5601/app/kibana) y Kibana se mostrará disponible. > <sup>1</sup>
Puede variar dependiendo de los recursos disponibles

Apartir de este momento ElasticSearch y Kibana están listos para ser usados. Aunque aún no tenemos datos disponibles.

## Cargar los datos OCDS a ElasticSearch

Para este proceso debemos posicionarnos en la carpeta `elk-gobmx-csv-master/datasets/sfp-compranet-ocds`, en la
terminal:
```
cd datasets/sfp-compranet-ocds
```

### Descargando los paquetes de datos

Lo primero que debemos hacer es asegurarnos de haber descargado el archivo de **Contrataciones en formato OCDS por
paquetes json** publicado en el sitio
[datos.gob.mx](https://datos.gob.mx/busca/dataset/concentrado-de-contrataciones-abiertas-de-la-apf/resource/ed1ec7e5-61ae-4d00-8adc-67c77844e75c)
> Al 2 de Septiembre de 2018 este archivo lleva por nombre `contratacionesabiertas_bulk_paquetes.json.zip` y tiene un
tamaño de 310.5 MB aproximadamente.

Ahora debemos descomprimir el archivo `contratacionesabiertas_bulk_paquetes.json.zip` esto generará multiples archivos
`.json` dentro de una carpeta:
```
carpeta/contratacionesabiertas_bulk_paquete1.json carpeta/contratacionesabiertas_bulk_paquete2.json
carpeta/contratacionesabiertas_bulk_paquete3.json
...
```
> Estos archivos pueden ser bastante grandes en tamaño, es recomendable tener por lo menos 2GB libres de espacio en
> disco duro antes de continuar.

**IMPORTANTE** Debemos saber la ruta completa de esta carpeta con los archivos .json pues será necesaria para el paso de
carga. A manera de ejemplo asumamos que los archivos fueron descargados y descomprimidos dentro de la carpeta de
Descargas del sistema operativo.

La ruta completa a esta carpeta **debería ser**
[<sup>1</sup>](https://en.wikipedia.org/wiki/Home_directory#Default_home_directory_per_operating_system)
* **Linux/Ubuntu/Mac**: `/home/{nombre de usuario}/Descargas` Se puede abreviar como `$HOME/Descargas`
* **Windows**: `C:\Users\{nombre de usuario}\Descargas` Se puede abreviar como `%HOMEPATH%\Descargas`

Al confirmar esto podemos continuar.

## Procesando y cargando los datos

**IMPORTANTE** **El proceso actual carga especificamente el dato `compiledRelease` de cada documento OCDS, esto en
función de poder realizar el análisis sobre la ultima versión disponible de los *releases* OCDS, se recomienda leer los
capitulos anteriores antes de proceder**

En esta misma carpeta tenemos disponible otra herramienta especificamente diseñada para la carga de los datos, que
también hace uso de un contenedor Docker. Usaremos dos comandos unicamente: el primero para preparar el contenedor, el
segundo para ejecutarlo.

```
docker build . -t logstash-sfp-compranet-ocds:latest
```
> Con este comando Docker estará preparando el contenedor con todo lo necesario para procesar y cargar los datos.

Una vez finalizado, podemos ejecutar el proceso de carga según el sistema operativo disponible.

**Linux/Ubuntu o Mac**
```
docker run --net="host" -v $HOME/Descargas:/input logstash-sfp-compranet-ocds
```
**Windows**
```
docker run --net="host" -v %HOMEPATH%\Descargas:/input logstash-sfp-compranet-ocds
```
> Este comando utilizará el contenedor preparado con anterioridad ejecutando el proceso y carga de los datos. Para
> mayores detalles puede consultar la [documentación técnica](../../datasets/sfp-compranet-ocds/README.md) de este
> proceso.

La pantalla ahora debe mostrar información del proceso. Esto puede tomar algunos minutos.

Al finalizar exitosamente deberemos ver la leyenda: `Carga finalizada` y `Kibana esta listo`.

Ahora podremos visitar la pagina de [Kibana](http://localhost:5601/app/kibana) y consultar ver los datos cargados.

---

Para conocer más sobre los detalles técnicos de como logramos hacer la carga de los datos, en la siguiente sección
hablaremos de como utilizamos LogStash para este proceso.

[Inicio](../README.md) | [Anterior: Plataforma ELK para el Análisis de Contrataciones en formato OCDS](Seccion3.md) |
[Siguiente: Procesamiento de datos con Logstash](Seccion5.md)
