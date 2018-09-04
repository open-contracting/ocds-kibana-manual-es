# Descubrir (Discover)

Tal y como su nombre indica este primer apartado sirve para hacer una primera exploración de los datos. La pantalla de búsqueda está dividida en tres partes principales:
* Un buscador 
* Un mapeo de campos 
* Un espacio de resultados

!["Discover"](discover.png "Discover")

Las principales acciones tanto para buscar como para configurar la visualización de la pantalla son
1. **Selector de indices**: En el desplegable se encuentran los distintos indices importados en la instancia de Kibana, este desplegable nos permite mover a través de ellos. Incluso algunos filtros se mantienen entre indices si hay campos coincidentes. 
2. **Buscador**: Nos permite hacer toda una serie de preguntas sobre nuestra base de datos, una forma de ver si nuestra query está funcionado es comprobar el recuento de "hits" que aparece justo encima del buscador. Algunas de las querys más habituales que se pueden usar:   

| Acción | Comando | Ejemplo |
|:--|:--|:--|
| Buscar en cualquier campo | *string* | México |
| Buscar en campo espeficio | *campo:string* | buyer.name:México |
| Buscar texto especifico en campo especifico | *campo:"string"* | buyer.name:"Telecomunicaciones de México" |
| Buscar dos textos en un campo | *campo:("string" OR "string")* | buyer.name:("Telecomunicaciones de México" OR " Tecnológico Nacional de México") |
| Buscar en dos campos a la vez | *campo:"string" AND campo:"string"* | buyer.name:"Telecomunicaciones de México" AND tender.title:servicios |
| Más grande o más pequeño | *campo:>valor* | contracts.value.amount:(>100000 AND <1000000) |
| wildcards, valores desconcidos | *c?mpo* | M?exic* |
  
Para conocer más opciones leer la documentación de [Query String Query](https://www.elastic.co/guide/en/elasticsearch/reference/6.x/query-dsl-query-string-query.html#query-string-syntax) y de [Lucene Query Syntax](https://www.elastic.co/guide/en/kibana/6.x/lucene-query.html).

3. **Filtros**: Los filtros gráficos pueden hacer más o menos las mismas operaciones de filtro en el buscador, con la ventaja que se pueden sumar varios filtros con facilidad y que hay una opción para editar el filtro y hacerlo mucho más complejo siguiendo [este tutorial](https://www.elastic.co/guide/en/elasticsearch/reference/6.x/query-filter-context.html). Si se están haciendo filtros sobre campos que contienen strings verán que aparecen duplicadas, una con el nombre definida y otra que termina en *.keyword*, se recomienda usar la segunda. 

4. **Available fields**: La barra lateral sirve para poder inspeccionar las cabeceras de los datos, dar una primera visión de los datos que contienen y configurar el panel de resultados. 
    * Configuración: La ruedita que está al lado de "Availaible Fields" despliega una siere de opciones para que se muestren más o menos campos. En caso de datos no tabulares, como los de OCDS, se aconseja desmarcar "Hide missing fields", para que se muestren los campos que están dentro de otros campos. 
    * Campos: Todos los campos van acompañados de un símbolo que identifica el tipo de datos que contiene, el reloj cuando es temporal, el numeral o tecla gato para identificar numero, la t para identificar los textos o strings, un esfera mita negra significa que el campo es un booleano, y el símbolo interrogante que desconoce que tipo de campo tiene, normalmente será porque contiene a su vez más campos a su interior. Al clicar sobre un campo se desplegará un grafico que mapea los primeros 500 valores del campo. 
    * Add: El botón add, que está iluminado con por el circulo rojo, sirve para que el panel de resultados en lugar de mostrar toda la tira de datos muestre solo aquel o aquellos valores seleccionados. Desde el panel de resultados también podremos usar esos datos para ordenar los resultados. 

5. **Save**: Como se dice al principio del apartado la opción visualizar en el apartado discover sirve para una primera exploración, pero una vez ya conseguimos los resultados deseados podemos guardar esta búsqueda para graficarla o mandarla a un dashboard. 
