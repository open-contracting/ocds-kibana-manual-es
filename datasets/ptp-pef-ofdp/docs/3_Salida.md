# Salida (output)

Esta sección le indica a Logstash que debe hacer con los nuevos documentos, en nuestro caso queremos que los resultado sean enviados a ElasticSearch que tenemos operando en nuestra computadora local.

```
output {
  if "_csvparsefailure" in [tags] {
    file {
      path => "/etc/datasets/ptp-pef-ofdp/logs/failure.log"
      create_if_deleted => true
    }
  } else {
    file {
      path => "/etc/datasets/ptp-pef-ofdp/logs/success.log"
      codec => line { format => "%{message}" }
      create_if_deleted => true
    }
    elasticsearch {
      index => "poder-ptp-pef-ofdp"
      hosts => ["elasticsearch:9200"]
      template => "/etc/datasets/ptp-pef-ofdp/template.json"
      template_name => "poder-ptp-pef-ofdp"
      template_overwrite => true
      document_id => "%{CICLO}-%{GPO_FUNCIONAL}-%{ID_AI}-%{ID_CAPITULO}-%{ID_CLAVE_CARTERA}-%{ID_CONCEPTO}-%{ID_ENTIDAD_FEDERATIVA}-%{ID_FF}-%{ID_FUNCION}-%{ID_MODALIDAD}-%{ID_PARTIDA_ESPECIFICA}-%{ID_PARTIDA_GENERICA}-%{ID_PP}-%{ID_RAMO}-%{ID_SUBFUNCION}-%{ID_TIPOGASTO}-%{ID_UR}"
      user => logstash_poder
      password => logstash
    }
  }
}
```

Aqui resulta evidente que estamos condicionando el flujo con la etiqueta antes mencionada `_csvparsefailure`.
Si encontramos la etiqueta en el documento, el mismo será escrito a un archivo llamado `failure.log`, el documento será escrito en su forma JSON.

En caso de no encontrar esta etiqueta, procedemos a hacer dos cosas:

1. Agregarlo a un log llamado `success.log`
    > Podemos ver que a diferencia de los registros con error, aqui utilizamos la opcion
        `codec => line { format => "${message}" }`
    > que le indica a logstash que debe escribir el campo `message` del documento en el archivo.
    > El campo `message` contiene la linea CSV original.
1. Enviarlo a ElasticSearch

En este ultimo caso utilizamos distintas opciones que vale la pena revisar.

## [Output ElasticSearch](https://www.elastic.co/guide/en/logstash/current/plugins-outputs-elasticsearch.html)

```
 elasticsearch {
  index => "poder-ptp-pef-ofdp"
  hosts => ["elasticsearch:9200"]
  template => "/etc/datasets/ptp-pef-ofdp/template.json"
  template_name => "poder-ptp-pef-ofdp"
  template_overwrite => true
  document_id => "%{CICLO}-%{GPO_FUNCIONAL}-%{ID_AI}-%{ID_CAPITULO}-%{ID_CLAVE_CARTERA}-%{ID_CONCEPTO}-%{ID_ENTIDAD_FEDERATIVA}-%{ID_FF}-%{ID_FUNCION}-%{ID_MODALIDAD}-%{ID_PARTIDA_ESPECIFICA}-%{ID_PARTIDA_GENERICA}-%{ID_PP}-%{ID_RAMO}-%{ID_SUBFUNCION}-%{ID_TIPOGASTO}-%{ID_UR}"
  user => logstash_poder
  password => logstash
}
```
Las opciones utilizadas son las siguientes:
- `index`: Indica el nombre del indice al que vamos a enviar el documento.
- `hosts`: Indica donde se encuentra el servidor ElasticSearch en espera.
    > En este caso la dirección `elasticsearch` está configurada en los contenedores. Pero podriamos cambiarla por algun dominio o dirección IP como sea necesario.
- `user` y `password`: son opciones a veces necesarias para comunicarse con el servidor ElasticSearch si este tiene habilitado la identificación por usuario.
- `document_id`: Esta opción es **MUY** importante ya que permite que Logstash identifique el documento con un identificador único, que a su vez permitará a ElasticSearch saber cuando un documento ya existía previamente.
    > En este ejemplo estamos formando un ID unico con los valores de distintos campos/columnas del documento. Si el dataset incluye un campo o columna que sea identificado unico desde el origen, podemos usar ese valor.
- `template`, `template_name` y `template_overwrite` son opciones que le indican a Logstash que al momento de comunicarse con ElasticSearch, si el indice no ha sido creado debe utilizar el template proporcionado para hacerlo.
    > No siempre es necesario hacer esto.

[Regresar](../Seccion5.md)
