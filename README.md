# Retail Project

Proyecto de base de datos retail realizado en PostgreSQL.

## Archivos

- `retail_project.sql`: creación de la base, tablas, restricciones, datos iniciales y operaciones de mantenimiento.

## Cómo ejecutar

1. Ejecutar `CREATE DATABASE retail_project;` desde una conexión a PostgreSQL.
2. Conectarse a la base `retail_project`.
3. Ejecutar el archivo `retail_project.sql` desde la sección de creación de tablas en adelante.

El script crea `clientes` y `productos` antes que `ventas`, utiliza PRIMARY KEY, FOREIGN KEY y restricciones CHECK, carga cinco registros por tabla dentro de `BEGIN ... COMMIT` y realiza un UPDATE y un DELETE mediante WHERE.

## Estructura

```text
retail-project/
├── retail_project.sql
└── README.md
```
