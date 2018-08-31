## Introducción al Estandar de Datos de Contrataciones Abiertas

> *Esta introducción es una traducción del capítulo [An introduction to the Open Contracting Data Standard](https://github.com/rparrapy/ocds-r-manual/blob/master/manual.Rmd#an-introduction-to-the-open-contracting-data-standard) del Manual [Analyzing Open Contracting data using the R programming language](https://github.com/rparrapy/ocds-r-manual/blob/master/manual.Rmd) de [Rodrigo Parra](https://github.com/rparrapy)*

Se considera un dato abierto aquel que está en un formato estructurado, reutilizable y legible por máquina; más allá de los requerimientos técnicos los datos abiertos abren nuevas oportunidades para la participación y la rendición de cuentas ciudadana. El [Estándar de Datos de Contrataciones Abiertas (OCDS por sus siglas en inglés)](https://www.open-contracting.org/data-standard/?lang=es) fue creado para aplicar estos principios a los datos relacionados con el ciclo de vida completo de contratación, que incluye planificación, convocatoria, adjudicación, contratación e implementación.

El estándar de datos, diseñado y desarrollado mediante un proceso abierto por la [Open Contrancting Parnertship (OCP)](https://www.open-contracting.org/?lang=es), facilita a los gobiernos y ciudades de todo el mundo compartir sus datos de contratación, permitiendo una mayor transparencia en la contratación pública y respaldando el análisis accesible y en profundidad de la eficiencia, efectividad, equidad e integridad de los sistemas de contratación pública. 

La intención de esta sección es presentar al lector el estándar, los casos de uso para los que fue diseñado y los conceptos básicos necesarios para aplicarlo. La mayoría del contenido fue tomado de la documentación oficial del estándar; para obtener una introducción más completa, consulte la [guia de inicio rapida de la OCP](http://standard.open-contracting.org/latest/en/getting_started/).

### Usuarios y casos de uso

El estándar fue diseñado para satisfacer las cuatro necesidades principales que se dectectaron en los ususarios: 

* Lograr poner en valor el gasto gubernamental
* Fortalecimiento de la transparencia, la rendición de cuentas y la integridad de la contratación pública
* Permitir que el sector privado compita de forma justa por los contratos públicos
* Monitoreo de la efectividad de la prestación del servicio contratado

Para saber quién está publicando datos que cumplen con OCDS y cómo lo están haciendo, consulte el la web de [OCP](https://www.open-contracting.org/?lang=es). Cuatro posibles casos de uso para los datos de contratación abierta son:

* Valor para el dinero en la adquisición: ayudar a los funcionarios a obtener una buena relación calidad-precio durante el proceso de adquisición, y analizar si estos objetivos se lograron después.
* Detección de fraude y corrupción: identificación de banderas rojas que podrían indicar corrupción mediante el estudio de adquisiciones individuales o redes basadas en fondos, propiedad e intereses.
* Competir por contratos públicos: permitir que las empresas privadas comprendan el potencial de las oportunidades de adquisición al observar información relacionada con adquisiciones pasadas y actuales.
* Supervisión de la prestación de servicios: ayuda a los actores interesados a aprovechar la trazabilidad en el proceso de adquisición para fines de supervisión, vinculando los presupuestos y los datos de los donantes con los contratos y los resultados.

### El proceso de contratación

El estándar define un proceso de contratación como:

> Toda la información de planificación, publicación de la convocatoria, adjudicaciones, contratos e implementación de contratos relacionada con un solo proceso de iniciación.

El estándar cubre todas las etapas de un proceso de contratación, aunque algunos procesos pueden no incluir todos los pasos posibles. Las etapas del proceso de adquisición, con objetos de ejemplo que pueden estar asociados a cada uno, se representan en la figura a continuación.


```{r, echo=FALSE, fig.cap="Stages of the procurement process."}
knitr::include_graphics("procurement-stages.png")
```

Para fines de identificación, a todos los procesos de contratación se les asigna un Id. de contratación abierta único (ocid), que se puede utilizar para unir datos de diferentes etapas. Para evitar clústeres de ocid entre editores, un editor puede anteponer un prefijo a los identificadores generados localmente. Se anima a los editores a registrar su prefijo [aquí](http://standard.open-contracting.org/latest/en/implementation/registration/).



### Documentos

Los procesos de contratación se representan como **documentos** en el OCDS. Cada documento se compone de varias **secciones**, que se mencionan a continuación:

* metadatos de lanzamiento: información contextual sobre cada lanzamiento de datos;
     * participantes: información sobre las organizaciones y otros actores involucrados en el proceso de contratación;
     * planificación: información sobre los objetivos, presupuestos y proyectos relacionados con un proceso de contratación;
     * convocatoria: información sobre cómo se realizará o se llevará a cabo una licitación;
     * adjudicación: información sobre las adjudicaciones realizadas como parte de un proceso de contratación;
     * contrato: información sobre contratos firmados como parte de un proceso de contratación;
     * implementación: información sobre el progreso de cada contrato hacia la finalización.

Un ejemplo de fragmento de JSON compatible con esta estructura se ve de la siguiente manera:

```{json}
{
   "language": "en",
   "ocid": "contracting-process-identifier",
   "id": "release-id",
   "date": "ISO-date",
   "tag": ["tag-from-codelist"],
   "initiationType": "tender",
   "parties": {},
   "buyer": {},
   "planning": {},
   "tender": {},
   "awards": [ {} ],
   "contracts":[ {
       "implementation":{}
   }]
}
```

Hay dos tipos de documentos definidos en el estándar:

* **Releases** son inmutables y representan actualizaciones sobre el proceso de contratación. Por ejemplo, se pueden usar para notificar a los usuarios de nuevas convocatorias, premios, contratos y otras actualizaciones. Como tal, un único proceso de contratación puede tener muchos lanzamientos.

* **Registros** son instantáneas del estado actual de un proceso de contratación. Un registro debe actualizarse cada vez que se publique una nueva versión asociada a su proceso de contratación; por lo tanto, solo debe haber un solo registro por proceso de contratación.

### Campos

Cada sección puede contener varios **campos** especificados en el estándar, que se utilizan para representar datos. Estos objetos pueden aparecer varias veces en diferentes secciones del mismo documento; por ejemplo, los artículos pueden presentarse en convocatoria (para indicar los artículos que un comprador desea comprar), en un objeto de adjudicación (para indicar los artículos para los que se ha realizado una adjudicación) y en un objeto contractual (para indicar los artículos enumerados en el contrato). Algunos campos de ejemplo, acompañados por los fragmentos de JSON correspondientes, se presentan a continuación.

#### Participantes (Organizaciones)

```{json, eval=FALSE}
{
    "address": {
        "countryName": "United Kingdom",
        "locality": "London",
        "postalCode": "N11 1NP",
        "region": "London",
        "streetAddress": "4, North London Business Park, Oakleigh Rd S"
    },
    "contactPoint": {
        "email": "procurement-team@example.com",
        "faxNumber": "01234 345 345",
        "name": "Procurement Team",
        "telephone": "01234 345 346",
        "url": "http://example.com/contact/"
    },
    "id": "GB-LAC-E09000003",
    "identifier": {
        "id": "E09000003",
        "legalName": "London Borough of Barnet",
        "scheme": "GB-LAC",
        "uri": "http://www.barnet.gov.uk/"
    },
    "name": "London Borough of Barnet",
    "roles": [ ... ]
}
```

#### Valores

```{json, eval=FALSE}
{
    "amount": 11000000,
    "currency": "GBP"
}
```

#### Items

```{json, eval=FALSE}
{
    "additionalClassifications": [
       {
            "description": "Cycle path construction work",
            "id": "45233162-2",
            "scheme": "CPV",
            "uri": "http://cpv.data.ac.uk/code-45233162.html"
        }
    ],
    "classification": {
        "description": "Construction work for highways",
        "id": "45233130",
        "scheme": "CPV",
        "uri": "http://cpv.data.ac.uk/code-45233130"
    },
    "description": "string",
    "id": "0001",
    "quantity": 8,
    "unit": {
        "name": "Miles",
        "value": {
            "amount": 137000,
            "currency": "GBP"
        }
    }
}
```

#### Periodos de tiempo

```{json, eval=FALSE}
{
    "endDate": "2011-08-01T23:59:00Z",
    "startDate": "2010-07-01T00:00:00Z"
}
```

#### Documentos

```{json, eval=FALSE}
{
    "datePublished": "2010-05-10T10:30:00Z",
    "description": "Award of contract to build new cycle lanes to AnyCorp Ltd.",
    "documentType": "notice",
    "format": "text/html",
    "id": "0007",
    "language": "en",
    "title": "Award notice",
    "url": "http://example.com/tender-notices/ocds-213czf-000-00001-04.html"
}
```

#### Hitos

```{json, eval=FALSE}
{
    "description": "A consultation period is open for citizen input.",
    "dueDate": "2015-04-15T17:00:00Z",
    "id": "0001",
    "title": "Consultation Period"
}
```


### Extensiones y listas de códigos

Además de los campos regulares, el esquema OCDS define algunos campos que solo se pueden usar en ciertas secciones, p. *títulos* y *descripciones* de licitaciones, premios y contratos. En algunos casos, los editores pueden requerir campos que no son proporcionados por el esquema central; una **extensión** permite definir nuevos campos que se pueden usar en estos casos. Una lista de extensiones disponibles está disponible [aquí](http://standard.open-contracting.org/latest/en/extensions); si ninguna extensión existente satisface las necesidades de un editor, se alienta al editor a colaborar en la creación de una nueva extensión de comunidad.

Otro concepto que vale la pena mencionar es el de las listas de códigos. Las listas de códigos son conjuntos de cadenas sensibles a mayúsculas y minúsculas con etiquetas asociadas, disponibles en cada idioma en el que se ha traducido OCDS. Los editores deben usar valores de lista de códigos siempre que sea posible para mapear sus sistemas de clasificación existentes; si es necesario, los campos de detalles pueden usarse para proporcionar información de clasificación más detallada. Hay dos tipos de listas de códigos:

* **Las listas de códigos cerradas** son conjuntos de valores fijos. Si un campo está asociado con una lista de códigos cerrada, solo debe aceptar una opción de la lista publicada.
* **Las listas de códigos abiertas** son conjuntos de valores recomendados. Si un campo está asociado con una lista de códigos abierta, acepta opciones de la lista, pero también otros valores.


El OCDS se mantiene utilizando [esquema JSON](http://json-schema.org). En esta sección, hemos introducido y descrito las secciones principales y los objetos comunes utilizados en el esquema, proporcionando fragmentos JSON como ejemplos de estos bloques básicos. Si está interesado en la referencia completa del esquema JSON, consulte la [documentación oficial](http://standard.open-contracting.org/latest/en/schema/).
