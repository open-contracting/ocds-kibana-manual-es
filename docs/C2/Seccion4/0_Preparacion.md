# Preparación de los datos OCDS por paquetes

## Formato disponible y formato requerido

El archivo obtenido desde gob.mx se presenta en formato de colección de [Paquete de
Registros](http://standard.open-contracting.org/latest/es/schema/record_package/)

> El esquema de paquete de registros (record package) describe la estructura del contenedor para publicar registros. Los
> contenidos de un registro se basan en el esquema de entregas (releases). El paquete contiene metadatos importantes.

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

Para poder trabajar con este documento necesitaremos convertirlo a un format donde cada linea del archivo sea un
documento OCDS.
```
{ documento ocds }
{ documento ocds }
```

De esta forma podremos procesarlo con Logstash para despues enviar los documentos uno a uno a ElasticSearch.

## Convertiendo el formato con la herramienta `jq`

Para poder trabajar con archivos JSON existe una herramienta disponible llamada [jq](https://stedolan.github.io/jq/) de
código libre y licencia MIT.

Esta herramienta nos permitirá manipular el documento JSON y llevarlo al formato requerido. Una vez que tenemos
instalada esta herramienta y disponible el comando `jq` podemos usar un comando como:
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
### El filtro jq y la estructura de datos

El filtro es la parte más importante de este comando para entenderlo debemos revisar con cuidado la estructura de datos
presentada en el archivo original.
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
Para efectos de este proyecto nos interesa obtener cada documento ocds por separado, de acuerdo a la notacion de
documentos JSON una ruta para acceder a ellos sería:
1. Entremos a cada elemento del arreglo raíz: `.[]`
1. De cada elemento, entremos a la propiedad records: `.records`
1. Obtengamos cada elemento de este arreglo: `.records[]`

Uniendo todas las instrucciones y en notacion de filtro de jq obtenemos: `.[].records[]`

Los archivos producidos por este comando son adecuados para procesarlos con Logstash, así que continuemos con la
creación del pipeline, pero primero revisemos algunos conceptos importantes.

[Siguiente](1_Conceptos.md)
