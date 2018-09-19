# Las herramientas Elastic

## Introducción

Es un conjunto de herramientas que al combinarse crean una plataforma robusta de administración de datos permitiendo la monitorización, consolidación y análisis de los mismos.

Las herramientas que componen este sistema son: ElasticSearch, Logstash y Kibana. Y por las iniciales de estos, el conjunto también es conocido como "stack ELK" o simplemente "ELK".

Estas herramientas son creadas, mantenidas y distribuidas por la compañía [Elastic](https://www.elastic.co/) desde 2012 y han evolucionado según las necesidades del mercado. La primera de las herramientas en ser creada fue ElasticSearch en 2004 bajo el nombre de Compass, pero la primera versión oficial surge en 2010.

Elastic ofrece sus productos en dos modalidades:
- Como software de código abierto, bajo la licencia Apache 2, salvo algunas funcionalidades adicionales son distribuidos con licencia propietaria. Ofrece la oportunidad de ver, utilizar y hasta modificar las herramientas sin costo alguno, pero toda administración de las herramientas debe ser llevado a cabo personalmente.
- Como servicio de pago, Elastic Cloud pone a disposición todas las herramientas y las funcionalidades adiciones en servidores administrados por ellos.

## Las ventajas de la plataforma ELK

Hay muchas soluciones distintas para cubrir la necesidad de procesamiento, monitoreo y visualización de datos, tanto de pago como libres, pero lo que distingue a ELK sobre otras es principalmente:

- **Potencia**: Ofrece mucha funcionalidad con un bajo costo técnico, las configuraciones son mínimas para empezar. Y las optimizaciones disponibles son amplias.
- **Escalabilidad**: Elasticsearch es una herramienta diseñada para manejar terabytes de datos sin ningún problema. Su arquitectura le permite expandirse de forma rápida y fácil.
- **Flexibilidad**: La configuración es flexible y puede adaptarse a cualquier necesidad y entorno.
- **Apertura**: Elastic fomenta un ecosistema de extensiones (plugins) alrededor de sus herramientas que han creado un número importante de funcionalidades extras y gratuitas para facilitar el trabajo con ellas.
- **Código Abierto**: Hoy en día el código abierto ofrece ventajas competitivas sobre otras plataformas porque permite la rápida corrección de errores gracias a la comunidad, la creación de extensiones e incluso incremente la base de usuarios al permitir utilizar las herramientas sin requerir pago alguno, lo que incrementa el conocimiento compartido de las herramientas.

## Los componentes

ELK está compuesta por tres pilares fundamentales: Elasticsearch, Logstash y Kibana.

![Plataforma ELK](elk.png "Plataforma ELK")

Cada componente tiene una funcionalidad y arquitectura específica, veamos cómo se relacionan y como podemos usarlos como una plataforma.

## Arquitectura de la plataforma

En este capítulo vamos a profundizar en el uso de las herramientas de Elastic para el análisis de datos de Contrataciones Abiertas en México. Para eso es necesario comprender mejor cómo se relacionan las diferentes herramientas antes de explicar cómo importaremos los datos.

La plataforma ELK tiene una arquitectura lineal entre sus componentes.

![ELK Stack](elk_stack.jpg "ELK Stack")

1. Los datos son recogidos y procesados por LogStash
1. LogStash envía los datos ya procesados a ElasticSearch para ser indexados
1. ElasticSearch proporciona los datos a la interfaz de Kibana para poder ser consultados

Pero veamos un poco más a detalle cada herramienta:

- [ElasticSearch](https://manualkibanaocds.readthedocs.io/es/latest/C2/Seccion1/1_ElasticSearch.html)
- [Logstash](https://manualkibanaocds.readthedocs.io/es/latest/C2/Seccion1/2_Logstash.html)
- [Kibana](https://manualkibanaocds.readthedocs.io/es/latest/C2/Seccion1/3_Kibana.html)
