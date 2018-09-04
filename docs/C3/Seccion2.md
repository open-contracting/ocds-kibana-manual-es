# Descubrir (Discover)

Tal y como su nombre indica este primer apartado sirve para hacer una primera exploración de los datos. La pantalla de búsquda está dividida en tres partes princpales:
* Un buscador 
* Un mapeo de campos 
* Un espacio de resultados

!["Discover"](discover.png "Discover")

Las principales acciones tanto para búscar como para configurar la visualización de la pantalla son
1. **Selector de indices**: En el desplegable se encuentran los distintos indices importados en la instancia de Kibana, este desplegable nos permite mover a través de ellos. Incluso algunos filtros se mantenen entre indices si hay campos coincidentes. 
2. **Buscador**: Nos permite hacer toda una serie de preguntas sobre nuestra base de datos, una forma de ver si nuestra query está funcionado es comprobar el recuento de "hits" que aparce justo encima del buscador. Algunas de las querys más habituales que se pueden usar:   

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

3. **Filtros**: 

A partir de aquí tenemos tres puntos que nos serviran
- Inspeccionar todos los elementos de la barra lateral. Determinar que es cada cosa, mirar si hay indices escondidos (el problema de los datos no tabulares) y configurar nuestros resultados. 
- Buscar en la barra que funciona tanto por palabras que aparecen en todo el dataset como con campos que solo aparecen en algo concreto. Listado de sintanxis basica. 
- Interfaz grafica de algunos de los filtros anteriores. 

Cualquier de estas busquedas las podemos dejar guardas y recupera
