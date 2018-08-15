# Entrada (input)

Este componente le indica a Logstash de dónde y cómo leera los datos originales.

```
input {
  file {
    path => "/etc/datasets/ptp-pef-ofdp/input/*.csv"
    start_position => "beginning"
    sincedb_path => "/dev/null"
    ignore_older => 864000000
    close_older => 2
    max_open_files => 16
  }
}
```
Encontramos que este pipeline utiliza el filtro de entrada (*Input filter*) para archivos: `file`

## [Filtro File](https://www.elastic.co/guide/en/logstash/current/plugins-inputs-file.html)
Se ha configurado para leer archivos CSV (`*.csv`) de la carpeta `/etc/datasets/ptp-pef-ofdp/input/`
> La carpeta `/etc/` es generada y utilizada por el *Contenedor Procesador*, debería ser invisible para nuestros procesos.

Las opciones `start_position`, `sincedb_path`, `ignore_older`, `close_older`, `max_open_files` sirven para indicarle al filtro que:
- Debe leer desde el inicio del archivo.
- Solo debe leer este archivo una vez.
    > Recordemos que Logstash está diseñado para leer nuevas lineas en los mismos archivos
- Debe mantener abierto el archivo lo más posible, esto es para mejorar el rendimiento del proceso.

## Importante

Al finalizar este bloque cada linea CSV estará almacenada en memoria de Logstash y será enviada al siguiente bloque: [filter](3_Transformacion.md)
