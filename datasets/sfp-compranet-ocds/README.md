# Datos Gob MX / SFP - Compranet - Contratos en formato OCDS (Open Contracting)

Datos descargables en: [Datos Gob MX](https://datos.gob.mx/busca/dataset/concentrado-de-contrataciones-abiertas-de-la-apf)

Se recomienda descargar los [datos por paquetes](https://datos.gob.mx/busca/dataset/concentrado-de-contrataciones-abiertas-de-la-apf/resource/ed1ec7e5-61ae-4d00-8adc-67c77844e75c)

La documentacion del esquema OCDS se puede encontrar en: [Open Contracting](http://standard.open-contracting.org/latest/en/getting_started/)

## ElasticSearch

- **Indice**: `poder-sfp-compranet-ocds`

### Dependencias

- Docker

### Instrucciones para usar este script

1. Descargar los paquetes de datos, deben consistir de uno o varios archivos .json
1. Extraer los archivos .json en la carpeta `input`

Ejecutar en esta carpeta los siguientes comandos:

1. `docker build . -t sfp-compranet-ocds:latest`
    Esto generará nuestro contenedor para correr el proceso con todas las dependencias necesarias.
    **Este comando solo tendremos que ejecutarlo una vez**

1. `docker run --rm -it -v $PWD/input:/input sfp-compranet-ocds`
    - Esto ejecutará el proceso utilizando los datos encontrados en la carpeta `input` de esta carpeta
    - Por default los datos son enviados a un cluster ElasticSearch en `http://elastic:elastic@localhost:9200` si deseamos enviarlo a otro cluster podemos usar:
    ```
    docker run --rm -it -v $PWD/input:/input sfp-compranet-ocds http://user:pass@hostname:port
    ```

1. Al finalizar este procedimiento en la carpeta `input` podremos encontrar archivos .log donde podremos validar el resultado de la carga, de la misma forma deberiamos encontrar todos los datos cargados en el cluster ES especificado.
