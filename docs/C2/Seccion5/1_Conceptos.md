# Conceptos Basicos para Pipelines de Logstash

## Sintaxis

Las definiciones de Pipelines para Logstash utilizan un lenguaje similar a bloques de código de programación
simplificado.

Cada filtro o plugin es definido por un bloque:
```
bloque {

}
```

Algunas veces estos bloques pueden estar vacios
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

[Siguiente](2_Entrada.md)
