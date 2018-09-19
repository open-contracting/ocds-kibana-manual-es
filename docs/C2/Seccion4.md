# Procesamiento de datos con Logstash

Ahora que hemos logrado poner en marcha la plataforma podemos ahondar en los detalles técnicos de la colección, procesamiento e indexación de los datos, que como habíamos revisado con anterioridad es la tarea realizada por la herramienta Logstash.

**IMPORTANTE**
Todo lo mencionado a continuación está abstraído en el código incluido en los contenedores Docker

Recordemos que Logstash utiliza procesos llamados Pipelines, para contextualizar lo logrado con los datos OCDS utilizaremos el pipeline de ese dataset a manera de ejemplo.

### Preparación de los datos OCDS por paquetes

#### Formato disponible y formato requerido

El archivo obtenido desde gob.mx se presenta en formato de colección de [Paquete de
Registros](http://standard.open-contracting.org/latest/es/schema/record_package/)

> El esquema de paquete de registros (record package) describe la estructura del contenedor para publicar registros. Los contenidos de un registro se basan en el esquema de entregas (releases). El paquete contiene metadatos importantes.

```
[
    { paquete de registros ocds },
    { paquete de registros ocds },
]
```

Esto se traduce en una estructura como la siguiente:

```
[
    {
        "uri": "..."
        "version": "..."
        ... otros meta datos ...
        "records": [
            { documento ocds },
            { documento ocds },
            ...
        ]
    },
    {
        "uri": "..."
        "version": "..."
        ... otros meta datos ...
        "records": [
            { documento ocds },
            { documento ocds },
            ...
        ]
    }
]
```

Para poder trabajar con este documento necesitaremos convertirlo a un formato donde cada linea del archivo sea un documento OCDS.
```
{ documento ocds }
{ documento ocds }
```

De esta forma podremos procesarlo con Logstash para después enviar los documentos uno a uno a ElasticSearch.

#### Convirtiendo el formato con la herramienta `jq`

Para poder trabajar con archivos JSON existe una herramienta disponible llamada [jq](https://stedolan.github.io/jq/) de código libre y licencia MIT.

Esta herramienta nos permitirá manipular el documento JSON y llevarlo al formato requerido. Una vez que tenemos instalada esta herramienta y disponible el comando `jq` podemos usar un comando como:
```
jq -crM ".[].records[]" "archivo.json" > "archivo.ocds_por_linea"
```
> Recomendamos ampliamente consultar el manual de `jq` pero a continuación explicaremos que hace este comando específico.

```
jq
    -c = Presenta el documento JSON de forma compacta
    -r = Presenta el documento JSON con valores sin formatos especiales
    -M = Sin color (Monocromatico)
    ".[].records[]" = Filtro de jq
    "archivo.json" = El archivo por leer
    "archivo.ocds_por_linea" = El archivo generado con el resultado
```
##### El filtro jq y la estructura de datos

El filtro es la parte más importante de este comando para entenderlo debemos revisar con cuidado la estructura de datos presentada en el archivo original.
```
[
    {
        "uri": "..."
        "version": "..."
        ... otros meta datos ...
        "records": [
            { documento ocds },
            { documento ocds },
            ...
        ]
    },
    ...
]
```
Para efectos de este proyecto nos interesa obtener cada documento ocds por separado, de acuerdo a la notación de documentos JSON una ruta para acceder a ellos sería:
1. Entremos a cada elemento del arreglo raíz: `.[]`
1. De cada elemento, entremos a la propiedad records: `.records`
1. Obtengamos cada elemento de este arreglo: `.records[]`

Uniendo todas las instrucciones y en notación de filtro de jq obtenemos: `.[].records[]`

Los archivos producidos por este comando son adecuados para procesarlos con Logstash, así que continuemos con la
creación del pipeline, pero primero revisemos algunos conceptos importantes.


### Conceptos básicos para Pipelines de Logstash

Ahora que estamos listos para enviar los datos a Logstash, revisemos algunos conceptos requeridos para entender mejor
las mecánicas de Logstash.

#### Sintaxis

Las definiciones de Pipelines para Logstash utilizan un lenguaje similar a bloques de código de programación
simplificado.

Cada filtro o plugin es definido por un bloque:
```
bloque {

}
```

Algunas veces estos bloques pueden estar vacíos
```
bloque { }
```

Pero comúnmente utilizaremos opciones y argumentos para estos bloques, y esto se define como:
```
bloque { opcion => valor }
```

Los valores de las opciones pueden ser de distintos tipos:

- Texto `opcion => "Texto"`
- Numerico `opcion => 123`
- Boolean (Verdadero / Falso) `opcion => true` o `opcion => false`
- Arreglos `opcion => [ "Texto", 123, false ]`
    > Los arreglos son conjuntos de otros tipos

## Pipeline

En el archivo [pipeline.conf](https://github.com/ProjectPODER/ManualKibanaOCDS/blob/master/pipeline/pipeline.conf) podemos encontrar el pipeline ya diseñado para este dataset, revisemos cada uno de los bloques que lo componen.


### Entrada (input)

Este componente le indica a Logstash de dónde y cómo leera los datos originales.

```
input {
  stdin {
    codec => "json"
  }
}
```
Para este pipeline hemos decidido leer el archivo desde la entrada estándar del programa, por cada linea de texto que
reciba el programa esta será tratada como un documento JSON y almacenada en memoria para el siguiente paso.

### Transformación (filter)

Este bloque le indica a Logstash qué debe hacer con cada uno de los registros que ha leído desde el modulo de Entrada.

```
filter {
  ruby {
    code => '
      event.get("[compiledRelease]").each do |k, v|
        event.set(k, v)
      end
    '
    remove_field => [ "releases", "compiledRelease", "host", "path" ]
  }
}
```

Este puede ser el proceso más complicado del Pipeline, y también el más interesante y poderoso para nuestras tareas.

Este bloque se compone por una serie de filtros que actúan de forma secuencial, en este caso solo ocupamos un filtro: ruby

### [Filtro Ruby](https://www.elastic.co/guide/en/logstash/current/plugins-filters-ruby.html)

> Este filtro es más avanzado y requiere de conocimientos de programación en lenguaje Ruby.

El objetivo de esta sección es tomar de cada documento JSON recibido la propiedad `compiledRelease`, y a su vez, leer
cada propiedad que lo compone, y copiarla sobre la raíz del documento.

**Ejemplo**
```
{
  "compiledRelease": {
    "a": "A",
    "bc": [ "B", "C" ],
    "tercero": {
      "a": "3.A",
      "b": "3.B"
    }
  }
}
```
Sería transformado como:
```
{
  "a": "A",
  "bc": [ "B", "C" ],
  "tercero": {
    "a": "3.A",
    "b": "3.B"
  }
}
```
Al final la propiedad `compiledRelease` es removida de la misma forma que `releases`, `host` y `path`.

### Salida (output)

Esta sección le indica a Logstash que debe hacer con los nuevos documentos, en nuestro caso queremos que los resultado
sean enviados a ElasticSearch.

```
output {
  file {
    path => "/logs/sfp-compranet-ocds-pipeline.log"
    create_if_deleted => true
    write_behavior => "overwrite"
  }
  elasticsearch {
    index => "${ES_INDEX}"
    hosts => ["${ES_HOST}"]
    document_id => "%{ocid}"
  }
}

```

Aquí realizamos dos cosas:
1. Guardar en un archivo log todos los documentos procesados, uno por cada línea.
1. Enviar los documentos a ElasticSearch.

Para lo primero utilizamos el Plugin [Output File](https://www.elastic.co/guide/en/logstash/current/plugins-outputs-file.html)
y en las opciones especificamos el nombre del archivo log, que debe ser creado si no existe y que debe sobrescribir lo existente.

Para enviar los documentos a ElasticSearch usamos otro plugin que dispone de múltiples opciones, en nuestro caso especificamos tres
pero recomendamos consultar el manual [Output ElasticSearch](https://www.elastic.co/guide/en/logstash/current/plugins-outputs-elasticsearch.html).

Las opciones utilizadas son las siguientes:
- `index`: Indica el nombre del indice al que vamos a enviar el documento.
- `hosts`: Indica el `hostname` del servidor ElasticSearch.
- `document_id`: Esta opción es **MUY** importante ya que permite que Logstash identifique el documento con un
  identificador único, que a su vez permitirá a ElasticSearch saber cuando un documento ya existía previamente. En este
  caso el documento OCDS tiene un id único llamado `ocid`.

Como pudimos constatar la creación de un pipeline para procesamiento con Logstash es la codificación de un proceso
lógico determinado. Cada dataset puede requerir distintos procesos, pero ahí radica el poder de Logstash que nos permite
plasmar estos pasos de forma concisa y ordenada.
