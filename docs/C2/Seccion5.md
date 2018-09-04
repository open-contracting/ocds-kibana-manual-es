# Procesamiento de datos con Logstash

Ahora que ya tenemos ElasticSearch y Kibana disponibles, concentrémonos en la tarea más importante del proyecto que es la colección, procesamiento e indexación de los datos.

## Datasets y pipelines incluidos

Para ejemplificar hemos incluido dos datasets distintos en este proyecto:

- [PTP - Presupuesto de Egresos de la Federacion - Formato OFDP](/datasets/ptp-pef-ofdp/README.md)
- [Datos Gob MX / SFP - Compranet - Contratos Ingresados a Compranet](/datasets/sfp-compranet-contratos/README.md)

Ambos son similares y nos permitiran explorar de forma didáctica como construir un pipeline para Logstash.

Por ahora usaremos el primero *PTP - PEF - Formato OFDP*, en la pagina de instrucciones del mismo podremos encontrar la página donde podemos descargar los datos oficiales ya que los incluid en la carpeta `datasets/ptp-pef-ofdp/input` son solo muestras.

### Los datos originales, el formato OFDP

Este formato consiste en una representación de valores separados por comas con las siguientes columnas definidas.

```
ciclo, desc_ai, desc_capitulo, desc_concepto, desc_ff, desc_funcion, desc_gpo_funcional, desc_modalidad, desc_partida_especifica, desc_partida_generica, desc_pp, desc_ramo, desc_subfuncion, desc_tipogasto, desc_ur, entidad_federativa, gpo_funcional, id_ai, id_capitulo, id_clave_cartera, id_concepto, id_entidad_federativa, id_ff, id_funcion, id_modalidad, id_partida_especifica, id_partida_generica, id_pp, id_ramo, id_subfuncion, id_tipogasto, id_ur, monto_adefas, monto_aprobado, monto_devengado, monto_ejercicio, monto_ejercido, monto_modificado, monto_pagado
```

Por lo general este formato presenta pocas fallas y errores, pero siempre es bueno contar con validaciones y recuperación de errores cuando se trata de procesar datasets de este tamaño.

### Pipeline

En el archivo [/datasets/ptp-pef-ofdp/pipeline.conf](/datasets/ptp-pef-ofdp/pipeline.conf) podemos encontrar el pipeline ya diseñado para este dataset, revisemos cada uno de los bloques que lo componen.

- [Conceptos Iniciales](Seccion5/1_Conceptos.md)
- [Entrada](Seccion5/2_Entrada.md)
- [Transformación](Seccion5/3_Transformacion.md)
- [Salida](Seccion5/4_Salida.md)


[Inicio](../README.md) | [Anterior: Instalación y puesta en marcha de la herramienta](Seccion4.md) | [Siguiente: Visualización de datos en ElasticSearch y Kibana](Seccion6.md)
