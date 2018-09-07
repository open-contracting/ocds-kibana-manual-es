# Transformación (filter)

Este bloque le indica a Logstash qué debe hacer con cada uno de los registros que ha leido desde el modulo de Entrada.

```
filter {
  csv {
    columns => [ "CICLO","DESC_AI","DESC_CAPITULO","DESC_CONCEPTO","DESC_FF","DESC_FUNCION","DESC_GPO_FUNCIONAL","DESC_MODALIDAD","DESC_PARTIDA_ESPECIFICA","DESC_PARTIDA_GENERICA","DESC_PP","DESC_RAMO","DESC_SUBFUNCION","DESC_TIPOGASTO","DESC_UR","ENTIDAD_FEDERATIVA","GPO_FUNCIONAL","ID_AI","ID_CAPITULO","ID_CLAVE_CARTERA","ID_CONCEPTO","ID_ENTIDAD_FEDERATIVA","ID_FF","ID_FUNCION","ID_MODALIDAD","ID_PARTIDA_ESPECIFICA","ID_PARTIDA_GENERICA","ID_PP","ID_RAMO","ID_SUBFUNCION","ID_TIPOGASTO","ID_UR","MONTO_ADEFAS","MONTO_APROBADO","MONTO_DEVENGADO","MONTO_EJERCICIO","MONTO_EJERCIDO","MONTO_MODIFICADO","MONTO_PAGADO" ]
    skip_header => true
  }
  ruby {
    code => "raise('Error') unless event.to_hash.length == (39 + 5)"
    tag_on_exception => "_csvparsefailure"
  }
  if "_csvparsefailure" not in [tags] {
    mutate {
      strip => [ "CICLO","DESC_AI","DESC_CAPITULO","DESC_CONCEPTO","DESC_FF","DESC_FUNCION","DESC_GPO_FUNCIONAL","DESC_MODALIDAD","DESC_PARTIDA_ESPECIFICA","DESC_PARTIDA_GENERICA","DESC_PP","DESC_RAMO","DESC_SUBFUNCION","DESC_TIPOGASTO","DESC_UR","ENTIDAD_FEDERATIVA","GPO_FUNCIONAL","ID_AI","ID_CAPITULO","ID_CLAVE_CARTERA","ID_CONCEPTO","ID_ENTIDAD_FEDERATIVA","ID_FF","ID_FUNCION","ID_MODALIDAD","ID_PARTIDA_ESPECIFICA","ID_PARTIDA_GENERICA","ID_PP","ID_RAMO","ID_SUBFUNCION","ID_TIPOGASTO","ID_UR","MONTO_ADEFAS","MONTO_APROBADO","MONTO_DEVENGADO","MONTO_EJERCICIO","MONTO_EJERCIDO","MONTO_MODIFICADO","MONTO_PAGADO" ]
      add_tag => [ "_csvparsefailure" ]
    }
    mutate {
      convert => {
        "MONTO_ADEFAS" => "float"
        "MONTO_APROBADO" => "float"
        "MONTO_DEVENGADO" => "float"
        "MONTO_EJERCICIO" => "float"
        "MONTO_EJERCIDO" => "float"
        "MONTO_MODIFICADO" => "float"
        "MONTO_PAGADO" => "float"
      }
      remove_tag => [ "_csvparsefailure" ]
    }
    mutate {
      remove_field => [ "path", "host" ]
    }
  }
}
```

Este puede ser el proceso más complicado del Pipeline, y también el más interesante y poderoso para nuestras tareas.

## Filtros (*Filter plugins*)

```
filter {
  csv {
  }
  ruby {
  }
  if "_csvparsefailure" not in [tags] {
    mutate {
    }
    mutate {
    }
    mutate {
    }
  }
}
```

Este bloque se compone por una serie de filtros que actuan de forma secuencial, en este caso estamos ocupando tres filtros distintos: `csv`, `ruby`, `mutate`, y cómo podemos observar podemos declarar algunos de estos dentro de bloques condicionales.

### [Filtro CSV](https://www.elastic.co/guide/en/logstash/current/plugins-filters-csv.html)

Este filtro reconoce la estructura de valores separados por comas y convierte cada columna en un campo individual en el nuevo **documento**.

Ejemplo:
Una archivo CSV con los siguientes datos
```
columna1,columna2,columna3
valor1,valor2,valor3
```
se convertiría en un documento:
```
{
  columna1: valor1,
  columna2: valor2,
  columna3: valor3
}
```

Las opciones básicas para este filtro son:
- `columns` donde podemos especificar con un arreglo los nombres de las columnas que define el archivo CSV.
  `columns => ['columna1', 'columna2', 'columna3']`
- `skip_header` donde podremos indicarle a Logstash si debe *saltarse* o no la primera linea de los datos. Por lo general querremos que lo haga, pero dependerá segun el dataset.
  `skip_header => true`

### [Filtro Ruby](https://www.elastic.co/guide/en/logstash/current/plugins-filters-ruby.html)

En este Pipeline utilizaremos el bloque de este filtro para validar que siempre encontramos la misma cantidad de columnas en todos los documentos.

> Este filtro es un poco más avanzado pues requiere de conocimientos de programación en lenguaje Ruby, pero el bloque que se incluye en este pipeline debería poder ser utilizado en otros pipelines para distintos datasets, solo hay que contar el numero de columnas y reemplazar el numero `39` por el numero de columnas requeridas.

El objetivo de este filtro es que si algun documento no cuenta con las columnas necesarias significa que el dato está incorrecto, y le pediremos a Logstash que lo marque con una etiqueta especial `_csvparsefailure`, más adelante veremos para que utilizamos esta etiqueta.

### [Filtro Mutate](https://www.elastic.co/guide/en/logstash/current/plugins-filters-mutate.html)

El siguiente bloque utiliza tres veces el filtro `Mutate` de manera consecutiva y condicional:
```
if "_csvparsefailure" not in [tags] {
  mutate {
    strip ...
  }
  mutate {
    convert ...
  }
  mutate {
    remove_field ...
  }
}
```
> Si no encontramos la etiqueta que indica error el dato, aplica mutate tres veces.

Mutate es uno de los filtros más utilizados para la transformación de datos, ya que permite realizar distintas operaciones sobre los valores del documento como: renombrar campos, quitar campos, reemplazar campos y modificar sus valores.

#### [Mutate strip](https://www.elastic.co/guide/en/logstash/current/plugins-filters-mutate.html#plugins-filters-mutate-strip)

La opcion `strip` de este filtro simplemente limpia los caracteres de espacio antes y despues de los valores de los campos especificados.
```
filter {
  mutate {
     strip => ["field1", "field2"]
  }
}
```

#### [Mutate convert](https://www.elastic.co/guide/en/logstash/current/plugins-filters-mutate.html#plugins-filters-mutate-convert)

Esta opcion permite realizar converciones de tipo en los valores del documento. Esto significa que si el dato original es un texto como `"123"` con esta opción podremos convertirlo en un entero real que ElasticSearch indexará como tal.

```
filter {
  mutate {
    convert => {
      "fieldname" => "integer"
      "booleanfield" => "boolean"
    }
  }
}
```

Se recomienda ver la documentación para conocer los tipos y reglas de operación de este filtro.

## Resumen

Este proceso de transformación hace lo siguiente:

1. Una vez leída la linea de texto en formato CSV, esta será separada por columnas y transformadas en un documento JSON mediante el filtro CSV
1. Se contarán las columnas / campos en este nuevo documento, si no son la cantidad esperada de 44 se marca el registro como erróneo.
1. Si el registro no es erróneo:
    1. Se limpiarán los espacios en blanco al inicio y final de todos los valores.
    1. Se convierten los campos de Montos en tipo numero con decimales.
        > Si esta operacion falla, tambien se marca el registro como erróneo.
    1. Se eliminan los campos `path` y `host` (agregados por el filtro CSV)

## Importante

Al finalizar este bloque cada linea CSV ya habrá sido transformada en un documento JSON y estará aun almacenada en memoria de Logstash lista para ser enviada al siguiente bloque: [output](4_Salida.md)
