# Transformación (filter)

Este bloque le indica a Logstash qué debe hacer con cada uno de los registros que ha leido desde el modulo de Entrada.

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

Este bloque se compone por una serie de filtros que actuan de forma secuencial, en este caso solo ocupamos un filtro: ruby

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
Al final la propiedad `compiledRelease` es removida de la misma forma que `releases`, `host` y `path.

## Importante

Al finalizar este bloque cada linea JSON ya habrá sido transformada en el formato deseado y estará aun almacenada en
memoria de Logstash lista para ser enviada al siguiente bloque: La salida o [output](4_Salida.md)
