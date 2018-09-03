# Salida (output)

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

Aqui realizamos dos cosas:
1. Guardar en un archivo log todos los documentos procesados, uno por cada línea.
1. Enviar los documentos a ElasticSearch.

Para lo primero utilizamos el Plugin [Output File](https://www.elastic.co/guide/en/logstash/current/plugins-outputs-file.html)
y en las opciones especificamos el nombre del archivo log, que debe ser creado si no existe y que debe sobreescribir lo existente.

Para enviar los documentos a ElasticSearch usamos otro plugin que dispone de multiples opciones, en nuestro caso especificamos tres
pero recomendamos consultar el manual.

[Output ElasticSearch](https://www.elastic.co/guide/en/logstash/current/plugins-outputs-elasticsearch.html)

Las opciones utilizadas son las siguientes:
- `index`: Indica el nombre del indice al que vamos a enviar el documento.
- `hosts`: Indica el `hostname` del servidor ElasticSearch.
- `document_id`: Esta opción es **MUY** importante ya que permite que Logstash identifique el documento con un
  identificador único, que a su vez permitará a ElasticSearch saber cuando un documento ya existía previamente. En este
  caso el documento OCDS tiene un id unico llamado `ocid`

[Regresar](../Seccion5.md)
