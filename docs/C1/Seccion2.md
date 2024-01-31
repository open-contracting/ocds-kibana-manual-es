Si bien la mayoría de la información en este manual puede ser utilizada para el análisis de cualquier conjunto de datos, nuestros esfuerzos  están orientados a analizar datos de Contrataciones Abiertas publicadas por la Secretaría de Hacienda y Crédito Público.

## Datos de Contrataciones Abiertas
Desde hace muchos años existen datos abiertos sobre contrataciones en México, un historial de los mismos se puede encontrar en el sitio de [CompraNet](http://compranet.funcionpublica.gob.mx/), que dispone de información en formato Excel desde el año 2002. Estos datos han sido objeto de múltiples análisis a lo largo del tiempo y están disponibles en una variedad de plataformas de tecnología cívica que simplifican su análisis. Para enumerar algunas de las que están actualmente disponibles:
* [QuiénEsQuién.Wiki](https://www.quienesquien.wiki)
* [ContratoBook](http://contratobook.org/#/contratos)
* [CompranNetFacil](http://compranetfacil.com/)
* [Data Analytics for Procurement](http://mexico.procurement-analytics.org/#/analysis/summary)

## Datos mexicanos en OCDS
Desde el año 2015 hay diferentes proyectos en la administración pública mexicana para publicar datos en el estándar de contrataciones abiertas OCDS. El primero que estuvo disponible fue el sitio de la [Ciudad de México](http://www.contratosabiertos.cdmx.gob.mx/contratos). La fuente de datos gubernamentales en OCDS la publica [la Secretaría de Hacienda y Crédito Público](https://www.gob.mx/contratacionesabiertas/home) y son los datos que se usan en este manual. 

Adicionalmente hay que destacar el esfuerzo para traducir el OCDS al español realizado por la [Alianza para las contrataciones Abiertas de México](https://www.contratacionesabiertas.mx/); otros organismos que publican en OCDS son el [Instituto Nacional de Acceso a la Información y Protección de Datos](http://contratacionesabiertas.inai.org.mx), el Grupo Aeroportuario de la Ciudad de México que publica [los contratos en para la construcción del Nuevo Aeropuerto](https://datos.gob.mx/nuevoaeropuerto/), la Secretaría de Comunicaciones y Transportes pública los [contratos relacionados con el proyecto Red Compartida](https://datos.gob.mx/redcompartida/) y a nivel subnacional está la [Secretaría de Planificación, Administración y Finanzas del Gobierno de Jalisco](https://contratacionesabiertas.jalisco.gob.mx/contratosabiertos/). 

## Datos en OCDS en América Latina y el resto del mundo

Además de México en América Latina y el resto del mundo hay varios países que publican conjuntos de datos en formato OCDS. La Alianza para el gobierno antiene un listado completo de [Publicadores de OCDS](https://data.open-contracting.org/es/).

Además, [OCDS Kingfisher Collect](https://kingfisher-collect.readthedocs.io) permite descargarlos e importarlos a una base de datos.

## Los datos para este manual
Como se dijo en el apartado anterior en este manual vamos a estar utilizando los datos publicados por el área de Transparencia Presupuestaria de la Secretaría de Hacienda y Crédito Público disponibles aquí: [https://www.gob.mx/contratacionesabiertas](https://www.gob.mx/contratacionesabiertas)

En particular vamos a trabajar con el concentrado de contrataciones abiertas de la Administración Pública Federal en formato JSON, obtenido desde esta URL: [https://datos.gob.mx/busca/dataset/concentrado-de-contrataciones-abiertas-de-la-apf/resource/0252e19f-bdd6-43de-af7b-106d4c7a82c8](https://datos.gob.mx/busca/dataset/concentrado-de-contrataciones-abiertas-de-la-apf/resource/0252e19f-bdd6-43de-af7b-106d4c7a82c8)

Este dataset incluye datos de contrataciones realizadas por todas las dependencias del gobierno federal, organismos autónomos, empresas paraestatales y aquellos contratos de nivel estatal y municipal que cuentan con aportes del gobierno federal. Los datos disponibles en este formato son a partir del año 2017 y se actualizan continuamente. Si bien la frecuencia de actualización del archivo en el portal de datos no está explicitada, y al momento de la escritura la última versión es de principios de 2018, sí se pueden obtener datos más nuevos mediante el uso de la API descripta en este documento: [http://transparenciapresupuestaria.gob.mx/work/models/PTP/programas/OpenDataDay/Resultados/Guia%20_uso_API_contrataciones%20_abiertas.pdf](http://transparenciapresupuestaria.gob.mx/work/models/PTP/programas/OpenDataDay/Resultados/Guia%20_uso_API_contrataciones%20_abiertas.pdf)

Adicionalmente, fuimos capaces de obtener un volcado completo de los datos en OCDS por solicitud directa al área responsable.

En el siguiente capítulo profundizaremos sobre las herramientas necesarias para realizar análisis sobre estos datos y cómo importarlos.
