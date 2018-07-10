# Datos Gob MX / SFP - Compranet - Contratos en formato OCDS (Open Contracting)

Datos descargables en: [Datos Gob MX](https://datos.gob.mx/busca/dataset/concentrado-de-contrataciones-abiertas-de-la-apf)

Se recomienda descargar los [datos por paquetes](https://datos.gob.mx/busca/dataset/concentrado-de-contrataciones-abiertas-de-la-apf/resource/ed1ec7e5-61ae-4d00-8adc-67c77844e75c)

La documentacion del esquema OCDS se puede encontrar en: [Open Contracting](http://standard.open-contracting.org/latest/en/getting_started/)

## ElasticSearch

- **Indice**: `poder-sfp-compranet-ocds`

## Script

El script para cargar los datos se puede encontrar en `./run.sh`

### Dependencias

- Python 2.7
- PIP
    - python-elasticsearch
- [python-jsonpyes](https://github.com/mxcoder/jsonpyes)

### Instrucciones para usar el Script

1. Descargar los paquetes de datos, deben consistir de uno o varios archivos .json
1. Asegurarse de tener todas las dependencias instaladas y/o descargadas
1. Una vez descargados los paquetes de datos iniciar el script `run.sh`
