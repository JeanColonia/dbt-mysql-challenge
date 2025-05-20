# 📊 Análisis de Datos con Python, dbt y MySQL
### (Medallion Architecture & Kimball Dimensional Modeling)

## 🔗 Repositorio en GitHub

Puedes acceder al código fuente completo de este proyecto en el siguiente repositorio:

👉 [https://github.com/JeanColonia/dbt-mysql-challenge](https://github.com/JeanColonia/dbt-mysql-challenge)   


> Incluye todos los modelos DBT, pruebas, macros personalizadas, documentación y ejemplos de análisis de datos usando MySQL y Python siguiendo una arquitectura **Medallion** con enfoque **Kimball**.    

#### Author:
     Jean Colonia - jean.colonia@encora.com

  
## 📌 Descripción del Proyecto

Este proyecto implementa un flujo completo de análisis de datos, siguiendo una arquitectura moderna tipo **Medallion (Bronze, Silver, Gold)** combinada con el enfoque de modelado dimensional de **Kimball** (diseño dimensional con tablas **dimension**, **fact** y **aggregate**).

El objetivo es transformar datos sin procesar en información valiosa, estructurada y confiable para soportar decisiones estratégicas del negocio.


## 🧰 Herramientas Utilizadas
- **Python** – para análisis y limpieza preliminar
- **MySQL** – base de datos relacional
- **dbt (data build tool)** – para la transformación modular y controlada de datos
- **dbt-utils** – conjunto de macros reutilizables de validación y transformación
- **Visual Studio Code / dbt Cloud** – como entorno de desarrollo
- **GitHub** – para control de versiones   

 ---

## 🏗️ Arquitectura Medallion

El flujo de transformación de datos se divide en tres capas:

- **🔹 Bronze:** Datos sin procesar (raw) extraídos de las fuentes
- **⚪ Silver:** Datos limpios, normalizados y enriquecidos
- **🟡 Gold:** Datos listos para el análisis (hechos, dimensiones, reportes agregados)

### ➕ Metodología Kimball

- **Modelos Dimensionales (dim_):** Información descriptiva de entidades (clientes, productos)
- **Modelos de Hechos (fct_):** Datos cuantificables (ventas, transacciones)
- **Modelos Agregados (agg_ / report_):** Métricas por categoría, por día, por región, etc.

---

![Arquitectura del Proyecto](./demo/media/img/img.jpeg)


## 🧪 Testing y Calidad de Datos
Se aplican pruebas automáticas usando dbt tests:

* **Pruebas Genéricas**
  - Uniqueness
  - Not Null
  - Accepted Values: validación de dominios (ej. segmentos, categorías).
  - Relationships: integridad referencial entre dimensiones y hechos.
  - date_later_than_today: Valida si hay fechas mayores al presente (fecha de hoy).
  - id_correct_format: Valida que los ids tengan un correcto formato
  - values_less_than_zero: Valida que los valores no sean menores a cero.
  - dbt_utils.accepted_range:  Validar si los valores están acorde a un rango aceptable.
  - dbt_utils.not_empty_string: Validar si nos valores de tipo string no están vacíos.

* **Pruebas unitarias**
  - price_less_than_zero: Valida si hay precios de products menores que cero.

Accepted Values: validación de dominios (ej. segmentos, categorías).

Macros personalizadas: para validar emails, estandarizar fechas, aplicar lógica condicional, etc.

## 🧩 Macros

El proyecto incluye un conjunto de macros personalizadas definidas en la carpeta [`macros/`](./macros), diseñadas para:

- **Estandarizar transformaciones**: como formatos de fecha, validaciones de campos o generación de claves.
- **Reducir repetición** de código en modelos y pruebas.
- **Aplicar lógica condicional** de negocio reutilizable, como la segmentación de clientes o clasificación de ventas.

Estas macros permiten que las transformaciones sean más limpias, reutilizables y fáciles de mantener, siguiendo las buenas prácticas de modelado de datos en dbt.

### Ejemplos destacados

- ✅ is_valid_mail_format: Validación de formato de correo electrónico  
- 📅 is_standard_date_format: Conversión y estandarización de fechas  
- 🧠classification_by_spent: Clasificación de clientes por gasto   (Standard, Silver, Gold, Premium)
- 🔑 Generación de claves sustitutas (`surrogate keys`)  

Para ver ejemplos específicos, consulta la carpeta [`macros/`](./macros).

## Estructura del Proyecto

```plaintext
dbt-mysql-demo/
├── models/                     # Modelos de dbt
│   ├── schema.yml              # Definición de fuentes, modelos y pruebas
│   ├── bronze/                 # Datos crudos (raw) extraídos de fuentes
│
│   ├── silver/                 
│          └── staging/         # Modelos intermedios (stg_) Limpieza de datos, deduplicados, formatos, etc.
│          └── dimensions/      #  # Modelos dim_ según Kimball (califican y categorizan los datos de las tablas de hechos, id artificial - surrogate key)
│
│   └── gold/                   
│
│          └── facts/           # Modelos con métricas cuantitativas o medidas de los eventos de negocio
│          └── aggregates/      # Modelos con resúmenes precalculados de los datos de las tablas de hechos
│
├── seeds/                      # Datos estáticos (archivos CSV)
│
├── tests/                      # Pruebas genericas y unitarias
│   └── generic/                # Pruebas genericas aplicadas a diferentes modelos.
│   └── unit/                   # Pruebas unitarias aplicadas a modelos especificos.
│
├── macros/                     # Macros personalizadas (ej. validaciones, formateos)              
│
├── media/                      # Evidencia de ejecución y documentación
│   ├── video/                  # Videos de ejecución (`dbt run`, `dbt test`, etc.)
│   └── img/                    # Imágenes de `dbt docs` o visualizaciones
│
├── dbt_project.yml             # Configuración principal del proyecto dbt
├── packages.yml                # Configuración de paquetes adicionales (dbt_utils, etc)
├── bd-script.sql               # Script SQL auxiliar para desarrollo
└── README.md                   # Documentación del proyecto (este archivo)

``` 

### Explicación de cada carpeta

- **models/**: Contiene los modelos de dbt que se utilizan para transformar los datos. 
  - **bronze/**: Modelos para cargar los datos sin ninguna transformación.
  - **silver/**: Datos parcialmente transformados que se usarán en las siguientes etapas de modelado.
  - **gold/**: Modelos listos para ser usados en análisis de datos, con transformaciones y agregaciones finales.

- **seeds/**: Contiene los archivos de datos (por ejemplo archivos CSV como products, customers y sales) que se utilizarán en los modelos de dbt.

- **tests/**: Aquí se definen y ejecutan las pruebas para los modelos de dbt (pruebas aplicadas de forma generica o especifica para algunas columnas de tablas pero no declaradas dentro de un schema.yml ya que se ejecutan de forma automática)

- **dbt_project.yml**: Archivo de configuración del proyecto dbt, donde se definen parámetros como los nombres de las bases de datos, rutas y  configuraciones del modelo.

- **packages.yml**: Archivo de configuración de paquetes del proyecto dbt (por ejemplo dbt.utils, etc).

## Requisitos

1. Tener **Python** y **MySQL** instalados.
2. Tener **dbt** instalado. Si no lo tienes, puedes instalarlo con:   
    
    Instalar dbt:
    ```bash
    pip install dbt
     ```
    Instalar mysql para dbt:
    ```
    pip install dbt-mysql
    ```

## Configuración Inicial

1. Descarga la carpeta que contiene el repositorio del proyecto desde Sharepoint:

2. Navega a la carpeta del proyecto:
    ```bash
    cd dbt
    ```
    Para ejecutar los comandos asegure se ingresar a la carpeta ./dbt/demo/
    ```bash
    cd demo
    ```

3. Configura tu conexión a la base de datos MySQL en el archivo `profiles.yml`. ubicado en la ruta C:\Users\< Tu usuario> \.dbt.\profile.yml
```
    mysql:
   target: dev
   outputs:
     dev:
       type: mysql 
       server: localhost 
       port:  3306 (opcional -> modificar de ser necesario)
       schema: dbt_demo_db (Crear una base de datos con dicho nombre o cambiar según lo requiera)
       username: root (Ingresar usuario de MySQL según se configuró al instalar)
       password: admin (Ingresar pass de MySQL según se configuró al instalar)
       driver: MySQL ODBC 8.0 ANSI Driver (No cambiar)
```
4. Configurar archivos dbt_project.yml y schema.yml según sea requerido:
   - **Archivo dbt_project.yml**
   ```
      models:
        demo:
          bronze:
            +materialized: view (Creación de vista para todo lo incluido en la carpeta raw)
          silver: 
            +materialized: view (Creación de vista para todo lo incluido en la carpeta staging)
          gold:
            +materialized: table (Creación de vista para todo lo incluido en la carpeta marts)
    ```


## Comandos de dbt

- **Construir el proyecto**:
    ```bash
    dbt build
    ```

- **Construir y ejecutar seeds** (si tienes archivos CSV):
    ```bash
    dbt seed
    ``` 

- **Ejecutar modelos**:
   Comando general: 
    ```bash
    dbt run
    ```

   Comando especifo: 
     ```bash
    dbt run --select nombre_archivo
    ```

- **Ejecutar pruebas**:
    Comando general:
    ```bash
    dbt test
    ```
    Comando especifico:
    ```bash
    dbt test --select nombre_archivo
    ```
- **Generar y visualizar documentación del proyecto**:   
    Comando para generar el documento:
    ```bash
    dbt docs generate
    ```

    Comando para abrir el documento con serve:
    ```bash
    dbt docs serve
    ```
