# Extras

## Crear muestras de archivos originales

Para la creacion de archivos mas pequenos y manejables se ha usado [shuf](https://en.wikipedia.org/wiki/Shuf)

Como:
```
shuf -n NUMERO_ENTRADAS_DESEADAS -o OUTPUTFILE INPUTFILE
```

Ejemplo:
```
shuf -n 1000 -o pef.sample.csv pef.full.csv
```
