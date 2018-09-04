# Procesamiento de datos con Logstash

Ahora que hemos logrado poner en marcha la plataforma podemos ahondar en los detalles técnicos de la colección,
procesamiento e indexación de los datos, que como habiamos revisado con anterioridad es la tarea realizada por la
herramienta Logstash.

**IMPORTANTE**
Todo lo mencionado a continuación está abstraido en el código incluido en los contenedores Docker

Recordemos que Logstash utiliza procesos llamados Pipelines, para contextualizar lo logrado con los datos OCDS
utilizaremos el pipeline de ese dataset a manera de ejemplo.

Algunas veces es necesario realizar un tratamiento inicial de los datos
- [Preparación](Seccion5/0_Preparacion.md)

Ahora que estamos listos para enviar los datos a Logstash, revisemos algunos conceptos requeridos para entender mejor
las mecánicas de Logstash.
- [Conceptos Iniciales](Seccion5/1_Conceptos.md)

Ambos son similares y nos permitiran explorar de forma didáctica como construir un pipeline para Logstash.

Por ahora usaremos el primero *PTP - PEF - Formato OFDP*, en la pagina de instrucciones del mismo podremos encontrar la página donde podemos descargar los datos oficiales ya que los incluid en la carpeta `datasets/ptp-pef-ofdp/input` son solo muestras.

### Los datos originales, el formato OFDP

Este formato consiste en una representación de valores separados por comas con las siguientes columnas definidas.

```
ciclo, desc_ai, desc_capitulo, desc_concepto, desc_ff, desc_funcion, desc_gpo_funcional, desc_modalidad, desc_partida_especifica, desc_partida_generica, desc_pp, desc_ramo, desc_subfuncion, desc_tipogasto, desc_ur, entidad_federativa, gpo_funcional, id_ai, id_capitulo, id_clave_cartera, id_concepto, id_entidad_federativa, id_ff, id_funcion, id_modalidad, id_partida_especifica, id_partida_generica, id_pp, id_ramo, id_subfuncion, id_tipogasto, id_ur, monto_adefas, monto_aprobado, monto_devengado, monto_ejercicio, monto_ejercido, monto_modificado, monto_pagado
```

Por lo general este formato presenta pocas fallas y errores, pero siempre es bueno contar con validaciones y recuperación de errores cuando se trata de procesar datasets de este tamaño.

### Pipeline


En el archivo [datasets/sfp-compranet-ocds/pipeline.conf](/datasets/sfp-compranet-ocds/pipeline.conf) podemos encontrar
el pipeline ya diseñado para este dataset, revisemos cada uno de los bloques que lo componen.

- [Entrada](Seccion5/2_Entrada.md)
- [Transformación](Seccion5/3_Transformacion.md)
- [Salida](Seccion5/4_Salida.md)

Como pudimos constatar la creación de un pipeline para procesamiento con Logstash es la codificación de un proceso
lógico determinado. Cada dataset puede requerir distintos procesos, pero ahí radica el poder de Logstash que nos permite
plasmar estos pasos de forma concisa y ordenada.

Para otros ejemplos puede consultar la carpeta `datasets/` donde encontrará otros dos pipelines para datasets distintos.

[Inicio](../README.md) | [Anterior: Instalación y puesta en marcha de la herramienta](Seccion4.md) | [Siguiente:
Visualización de datos en ElasticSearch y Kibana](Seccion6.md)
