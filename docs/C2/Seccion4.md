# Procesamiento de datos con Logstash

Ahora que hemos logrado poner en marcha la plataforma podemos ahondar en los detalles técnicos de la colección,
procesamiento e indexación de los datos, que como habiamos revisado con anterioridad es la tarea realizada por la
herramienta Logstash.

**IMPORTANTE**
Todo lo mencionado a continuación está abstraido en el código incluido en los contenedores Docker

Recordemos que Logstash utiliza procesos llamados Pipelines, para contextualizar lo logrado con los datos OCDS
utilizaremos el pipeline de ese dataset a manera de ejemplo.

Algunas veces es necesario realizar un tratamiento inicial de los datos
- [Preparación](Seccion4/0_Preparacion.md)

Ahora que estamos listos para enviar los datos a Logstash, revisemos algunos conceptos requeridos para entender mejor
las mecánicas de Logstash.
- [Conceptos Iniciales](Seccion4/1_Conceptos.md)

### Pipeline

En el archivo [pipeline.conf](/pipeline/pipeline.conf) podemos encontrar
el pipeline ya diseñado para este dataset, revisemos cada uno de los bloques que lo componen.

- [Entrada](Seccion4/2_Entrada.md)
- [Transformación](Seccion4/3_Transformacion.md)
- [Salida](Seccion4/4_Salida.md)

Como pudimos constatar la creación de un pipeline para procesamiento con Logstash es la codificación de un proceso
lógico determinado. Cada dataset puede requerir distintos procesos, pero ahí radica el poder de Logstash que nos permite
plasmar estos pasos de forma concisa y ordenada.

[Inicio](../README.md) | [Anterior: Instalación y puesta en marcha de la herramienta](Seccion3.md) | [Siguiente: Resúmen](Seccion5.md)
