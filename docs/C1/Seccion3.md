Si bien la mayoría de la información en este libro puede ser utilizada para el análisis de cualquier conjunto de datos,
nuestros esfuerzos  están orientados a analizar datos de Contrataciones Abiertas publicadas por la Secretaría de la Función Pública
de México.

## Datos de Contrataciones Abiertas
Desde hace muchos años existen datos abiertos sobre contrataciones en México, un historial de los mismos se puede encontrar en el
sitio de CompraNet (http://compranet.funcionpublica.gob.mx/), que dispone de información en formato Excel desde el año 2002.
Estos datos han sido objeto de múltiples análisis a lo largo del tiempo y están disponibles en una variedad de plataformas de 
tecnología cívica que simplifican su análisis. Para enumerar algunas de las que están actualmente disponibles:
* https://www.quienesquien.wiki
* https://contratobook.com.mx
* https://contratafacil.mx
* http://mexico.procurement-analytics.org/

## Datos mexicanos en OCDS
Desde el año 2015 hay diferentes proyectos en la administración pública mexicana para publicar datos en el estándar de contrataciones
abiertas OCDS. El primero que estuvo disponible fué el sitio de la Ciudad de México (http://www.contratosabiertos.cdmx.gob.mx/contratos).
La Secretaría de la Función Pública comenzó en 2017 a publicar datos en el estándar OCDS, del cual realizaron una traducción al español
disponible aquí: https://www.contratacionesabiertas.mx/

Adicionalmente hay datos en estándard OCDS publicados por el Instituto Nacional de Acceso a la Información (http://contratacionesabiertas.inai.org.mx)
y los contratos en relación la construcción del Nuevo Aeropuerto (https://datos.gob.mx/nuevoaeropuerto/)

## Los datos para este manual
En este manual vamos a estar utilizando los datos publicados por el área de Transparencia Presupuestaria de la Secretaría de la Función Pública
disponibles aquí: https://www.gob.mx/contratacionesabiertas

En particular vamos a trabajar con el concentrado de contrataciones abiertas de la Administración Pública Federal
en formato JSON, obtenido desde esta URL: https://datos.gob.mx/busca/dataset/concentrado-de-contrataciones-abiertas-de-la-apf/resource/0252e19f-bdd6-43de-af7b-106d4c7a82c8

Este dataset incluye datos de contrataciones realizadas por todas las dependencias del gobierno federal, organismos autónomos,
empresas paraestatales y aquellos contratos de nivel estatal y municipal que cuentan con aportes del gobierno federal. Los datos
disponibles en este formato son a partir del año 2017 y se actualizan continuamente. Si bien la frecuencia de actualización del archivo
en el portal de datos no está explicitada, y al momento de la escritura la última versión es de principios de 2018, si se pueden
obtener datos más nuevos mediante el uso de la API descripta en este documento: http://transparenciapresupuestaria.gob.mx/work/models/PTP/programas/OpenDataDay/Resultados/Guia%20_uso_API_contrataciones%20_abiertas.pdf

Adicionalmente, fuimos capaces de obtener un volcado completo de los datos en OCDS por solicitud directa al área responsable.

En el siguiente capítulo profundizaremos sobre las herramientas necesarias para realizar análisis sobre estos datos y cómo importarlos.
