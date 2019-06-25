# Puesta en marcha de la Plataforma ELK para el Análisis de Contrataciones en formato OCDS

Al final de esta sección tendremos todo lo necesario para hacer consultas y visualizaciones sobre los datos de Contrataciones en formato OCDS.

Para una mejor comprensión de esta sección se recomienda tener familiaridad básica con la terminal de comandos:

* [Mac](https://www.soydemac.com/abrir-terminal-mac/)
* [Windows](https://www.wikihow.com/Open-the-Command-Prompt-in-Windows)
* [Linux/Ubuntu](https://elblogdeliher.com/como-moverse-por-los-directorios-en-la-terminal-de-ubuntu/)

## Objetivos

1. Iniciar un servidor ElasticSearch con Kibana.
1. Cargar los datos publicados de Contrataciones en un formato sencillo de consultar.
1. Realizar una consulta sobre los datos.

El presente proyecto está desarrollado para poder iniciar los 3 servicios, según sea necesario de forma fácil y rápida.


## Prerequisitos

1. Abrir la terminal para comandos del Sistema Operativo
1. [Instalar Docker CE](https://docs.docker.com/install/)
1. [Instalar Docker Compose](https://docs.docker.com/compose/install/)
1. [Descargar el archivo que contiene las
   herramientas](https://github.com/ProjectPODER/ManualKibanaOCDS/archive/master.zip)
1. Descomprimir el archivo descargado y entrar a la carpeta que se acaba de crear
    * En la terminal: `cd ManualKibanaOCDS-master`

## Iniciar el *Contenedor Servidor* con ElasticSearch y Kibana

Ahora podremos iniciar el servidor ejecutando el siguiente comando en la terminal:
```
docker-compose -f elastic-kibana.yaml up
```
> Este comando le indica al programa Docker que debe crear un contenedor según lo indicado en el archivo
> `elastic-kibana.yaml`, en el mismo indicamos que ambos programas deben iniciarse.

Pasados unos minutos, depende de los recursos disponibles, deberíamos poder abrir en el navegador web la dirección
[http://localhost:5601/app/kibana](http://localhost:5601/app/kibana) y Kibana se mostrará disponible.

A partir de este momento ElasticSearch y Kibana están listos para ser usados. Aunque aún no tenemos datos disponibles.

## Cargar los datos OCDS a ElasticSearch

Para este proceso debemos posicionarnos en la carpeta `elk-gobmx-csv-master/pipeline`, en la
terminal:
```
cd pipeline
```

### Descargando los paquetes de datos

Si queremos trabajar con el total de los contratos publicados en estándar OCDS sin importar los últimos datos
publicados, lo primero que debemos hacer es asegurarnos de haber descargado el archivo de **Contrataciones en formato
OCDS por paquetes json** publicado en el sitio
[datos.gob.mx](https://datos.gob.mx/busca/dataset/concentrado-de-contrataciones-abiertas-de-la-apf/resource/ed1ec7e5-61ae-4d00-8adc-67c77844e75c)
> Al 2 de Septiembre de 2018 este archivo lleva por nombre `contratacionesabiertas_bulk_paquetes.json.zip` y tiene un
tamaño de 310.5 MB aproximadamente.

Es importante mencionar que el formato de esta información se conoce en el estándar OCDS como [recordPackages](https://standard.open-contracting.org/latest/en/schema/record_package/) o [paquete de Registros](https://standard.open-contracting.org/latest/es/schema/record_package/); las herramientas y código incluidas en éste manual utilizan este formato, para utilizar alguno otro como *releases* o *releasePackages* o alguna otra estructura no definida por el estándar OCDS serían necesarias modificaciones al código.

> Estos archivos pueden ser bastante grandes en tamaño, es recomendable tener por lo menos 2GB libres de espacio en
> disco duro antes de continuar.

Ahora debemos descomprimir el archivo `contratacionesabiertas_bulk_paquetes.json.zip`, esto generará múltiples archivos
`.json` dentro de una carpeta:
```
carpeta/contratacionesabiertas_bulk_paquete1.json
carpeta/contratacionesabiertas_bulk_paquete2.json
carpeta/contratacionesabiertas_bulk_paquete3.json
...
```

**IMPORTANTE:** Debemos saber la ruta completa de esta carpeta con los archivos .json, pues será necesaria para el paso de carga.

A manera de ejemplo asumamos que los archivos fueron descargados y descomprimidos dentro de la carpeta de Descargas del
sistema operativo. La ruta completa a esta carpeta **debería ser**
[<sup>1</sup>](https://en.wikipedia.org/wiki/Home_directory#Default_home_directory_per_operating_system)

* **Linux/Ubuntu/Mac**: `/home/{nombre de usuario}/Descargas`
    Se puede abreviar como `$HOME/Descargas`
* **Windows**: `C:\Users\{nombre de usuario}\Descargas`
    Se puede abreviar como `%HOMEPATH%\Descargas`

Al confirmar esto u obtener la ruta completa de la carpeta con los archivos `.json` podemos continuar.

## Procesando y cargando los datos

### IMPORTANTE
**El proceso actual carga específicamente la parte `compiledRelease` de cada documento OCDS, esto en
función de poder realizar el análisis sobre la ultima versión disponible de los *releases* OCDS, se recomienda leer los
capítulos anteriores antes de proceder**

En esta misma carpeta tenemos disponible otra herramienta diseñada para la carga de los datos, que
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
> mayores detalles puede consultar la [documentación técnica](https://github.com/ProjectPODER/ManualKibanaOCDS/tree/master/pipeline) de este
> proceso.

La pantalla ahora debe mostrar información del proceso. Esto puede tomar algunos minutos.

Al finalizar exitosamente deberemos ver la leyenda: `Carga finalizada` y `Kibana esta listo`.

Ahora podremos visitar la pagina de [Kibana](http://localhost:5601/app/kibana) y consultar ver los datos cargados.

---

Para conocer más sobre los detalles técnicos de como logramos hacer la carga de los datos, en la siguiente sección
hablaremos de como utilizamos LogStash para este proceso.

### Extra: Descargando los datos OCDS directo de la API de datos.gob.mx

Anteriormente se explicó cómo descargar el conjunto completo de los datos en OCDS mediante un sólo archivo, en esta
sección presentamos una alternativa para descargar sólo los contratos que buscamos o contratos más actualizados que aún
no se hayan publicado en el archivo completo, para esto usaremos la API datos.gob.mx proporcionada por el Gobierno Mexicano.

> Para ver la documentación completa de la API se puede revisar la [Guía básica de uso de la API](http://transparenciapresupuestaria.gob.mx/work/models/PTP/programas/OpenDataDay/Resultados/Guia%20_uso_API_contrataciones%20_abiertas.pdf)
> donde se detallan las opciones específicas de filtrado.

Para realizar la acción de descarga y para manipular un poco los datos utilizaremos las herramientas: [cURL](https://es.wikipedia.org/wiki/CURL)
y [jq](https://es.wikipedia.org/wiki/Jq).

> El comando `curl` nos permitirá descargar la información de forma automática mientras el comando `jq` nos ayudará a
> darle un formato manejable a los datos JSON.
> Más adelante en este manual se incluye una breve introducción a `jq`.

--- 
Se pueden instalar ambos programas de forma local, por ejemplo para Linux Ubuntu con una instrucción como:
```
sudo apt-get install -y curl jq
```
Para Windows o Mac, tendríamos que descargar los archivos ejecutables por separado, pero también tenemos la opción de usar el
*contenedor docker* incluido en el presente código, para ello solo tenemos que ejecutar el siguiente comando de docker:
```
docker run --rm -it -v $HOME/Descargas:/input --entrypoint=bash logstash-sfp-compranet-ocds
```
> Recuerda que `$HOME/` es una abreviación propia de sistemas Linux y Mac, en Windows usaremos `%HOMEPATH%\`

Al ejecutar éste comando obtendremos una nueva línea de comandos, que debe lucir como:
```
bash-4.2$
```
En esta [línea de comando]((https://es.wikipedia.org/wiki/Bash) ya podremos ejecutar los comandos presentados a continuación.

---

Para descargar los últimos 100 procesos de contratación y guardarlo en un archivo `.json`:
```
curl https://api.datos.gob.mx/v2/contratacionesabiertas | jq -crM ".results" > contratacionesabiertas_ultimos_100.json
```

> Hay que considerar que para conservar los archivos creados dentro del contenedor deberemos moverlos o crearlos en las
> carpetas compartidas entre la computadora y el contenedor. De lo contrario, estos archivos se perderán al momento de
> "apagar" el contenedor.

Para descargar los procesos de contratación que involucran a una unidad compradora determinada (limitado a 1000, pero se puede cambiar)
```
curl https://api.datos.gob.mx/v2/contratacionesabiertas?records.compiledRelease.parties.name=Servicio%20de%20Administraci%C3%B3n%20Tributaria&pageSize=1000&page=1 | jq -crM ".results"  > contratacionesabiertas_SAT_1000.json
```

Para comprender mejor este último comando, vamos a detallarlo parte por parte:
* Primero se invoca a `curl`
* Luego se incluye la dirección URL base de la API: [https://api.datos.gob.mx/v2/contratacionesabiertas](https://api.datos.gob.mx/v2/contratacionesabiertas)
* A continuación los parámetros de filtrado:
    - `records.compiledRelease.parties.name`: filtra por el valor de ese campo, es decir, el nombre de alguna de las partes del contrato.
    - `pageSize`: especifica cuántos resultados devolverá en cada pedido
    - `page`: permite ir pidiendo las páginas siguientes en caso de que haya más de una.
* Luego usamos el comando `jq` para extraer únicamente la parte de los resultados.
* Finalmente indicamos que el resultado de la operación debe ser almacenado en un archivo, es importante que este nombre
  de archivo represente la consulta realizada para simplificar luego el archivado.

> Estos archivos deben almacenarse y tratarse de la misma forma que en la sección anterior, poniéndolos en la carpeta de
> descargas, para poder continuar con el próximo paso.
