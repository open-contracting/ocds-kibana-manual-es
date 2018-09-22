# Panel de administración (Management)

El panel de administración de datos de Kibana permite modificar las propiedades de los datos importados, reformatearlos o crear nuevos campos calculados.

En la primera pantalla de «Management» podemos administrar tanto la base de datos de «Elaticsearch» como la visualización en «Kibana». En este Manual solo abordaremos la parte de «Index Patterns», que nos permite tanto reconfigurar las propiedades de los campos como crear campos calculados. Para expandir los conocimientos de la administración de Kibana se recomienda [consultar el manual oficial](https://www.elastic.co/guide/en/kibana/current/management.html).

## Reconfigurar un campo (Field)

Al entrar encontraremos una tabla con un buscador con todos los campos de cada uno de los íindices. En cada campo hay información del tipo, del formato (se da de forma individual), si es buscables, agregable (verán que los strings terminados en *keyword* son agregables) y si lo hemos excluíido. Al final de cada renglón aparece un síimbolo de edición, dónde podremos reformatearlo.

Un caso de uso sería que importamos un identificador que solo tiene números (award ID, cóodigo postal, partidas presupuestarias, etc.) y está identificado como número y no como string. Para modificarlos solo deberíamos entrar en la pantalla y en la parte de «format» ponerle el nuevo formato y cómo queremos que se visualice.

## Campos calculados (Scripted filds)

Kibana permite crear nuevos campos a partir de cálculos y que los podamos usarpoder usarlos de forma permanente en la aplicación. Para explicar cóomo funcionan, calcularemos la cantidad de días transcurridos desde la publicación de licitación hasta la recepción de oferta.

En la pantalla «Index patterns» hay tres pestañas, «Fields», «Scripted filds» y «Source Fields»;, cliquearemos en «Sripted fields» donde aparecen los campos calculados y luego en el botón «Add scripted field» para empezar a calcular.

!["Scripted Fields"](ScriptedFields.png "Scripted Fields")

Antes de empezar hemos de detectar los campos con los que vamos a trabajar; en nuestro caso serán `tender.awardPeriod.startDate` y `tender.awardPeriod.endDate` que ambos son fechas y Kibana las reconoce como fechas. El resultado que queremos es el número de días de diferencia. 

Siguiendo el formulario de la imagen:

1. **Name:** El nombre con el que identificaremos nuestro campo, por ejemplo `tender.awardPeriod.duration` para seguir con el mismo lenguaje del dataset de OCDS. 
1. **Language:** Es un desplegable con las opciones "painless" y "expresión", se sugiere trabajar con painless ya que es la sintaxis con la que nos familiarizamos en Discover y la que seguro va ser soportada en próximas versiones. 
1. **Type:** Desplegable pare elegir el tipo de campo que vamos a generar, en este caso usaremos "Number".
1. **Format:** Definiremos el número como "Duration", y allí nos aparecen dos desplegables más. El "Input format" donde seleccionaremos "Milliseconds" (porque así lo definimos en la fórmula) y el "Output format" como "Days" ya que estamos buscando la cantidad de días (Nota: la opción "Human Redable" dificulta las queries sobre el campo). También tenemos un campo numérico para los decimales, seguiremos con 2 decimiales por preferencias del autor. 
1. **Popularity:** Este campo numérico Kibana lo va calculando a partir del uso para mostrar los campos destacados en varias pantallas de la aplicación. Si queremos tenerlo destacado desde que terminamos se sugiere ponerle un valor alto, en este caso le pondremos un 10. 
1. **Script:** Este es el campo donde haremos nuestros cálculo; para una comprensión profunda sobre como hacer scripts se sugiere leer [la guía oficial](https://www.elastic.co/guide/en/elasticsearch/reference/6.x/search-request-script-fields.html). El sript que vamos a usar será:
    ```
    (doc['tender.awardPeriod.endDate'].value.getMillis() - doc['tender.awardPeriod.startDate'].value.getMillis())
    ```
    El sript lo que hace es llamar a los campos de inicio y fin de la apertura de licitación, mostrar sus valores, convertirlos a milisegundos y restar el fin del inicio. Para hacer este resultado usable y que podamos trabajar en el resto de la plataforma lo hemos formateado a días con dos decimales. 

    Analizando al detalle los elementos del sript: 
    * `doc['Nombre.Campo']` Sirve para llamar al campo de nuestra base datos. 
    * El `.value` nos devuelve el valor que nos servirá para hacer operaciones matemáticas. 
    * `.getMillis()` convierte el valor en milesegundos
    * ` - ` Es el operador de resta, se pueden usar otros operadores matemáticos. 

    Para más detalles [consultar la sintaxis completa.](https://www.elastic.co/guide/en/elasticsearch/painless/master/painless-api-reference.html)

7. **Create field:** Este es el botón final que crea el campo para toda la aplicación. En caso que el sript dé error, nos saltará un mensaje de advertencia y no lo procesará en la aplicación. 
