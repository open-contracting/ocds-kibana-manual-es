# Entrada (input)

Este componente le indica a Logstash de dónde y cómo leera los datos originales.

```
input {
  stdin {
    codec => "json"
  }
}
```
Para este pipeline hemos decidido leer el archivo desde la entrada estandar del programa, por cada linea de texto que
reciba el programa esta será tratada como un documento JSON y almacenada en memoria para el siguiente paso.

La transformación o filtro: [filter](3_Transformacion.md)
