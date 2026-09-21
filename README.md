# Coder SQL

Proyecto de base de datos retail realizado en PostgreSQL.

## Archivos

- `retail_project.sql`: creación de la base, tablas, restricciones, datos iniciales y operaciones de mantenimiento.
- `pre-entrega-modulo4.sql`: consultas de rentabilidad por categoría, clientes sin compras y producto más comprado por cliente.
- `preentrega_analisis_avanzado.sql`: reporte mensual por categoría con ranking, ventas acumuladas y comparación contra el promedio histórico.

## Cómo ejecutar

1. Ejecutar `CREATE DATABASE retail_project;` desde una conexión a PostgreSQL.
2. Conectarse a la base `retail_project`.
3. Ejecutar el archivo `retail_project.sql` desde la sección de creación de tablas en adelante.
4. Ejecutar `pre-entrega-modulo4.sql` para obtener los análisis de negocio.
5. Ejecutar `preentrega_analisis_avanzado.sql` para obtener el análisis mensual con funciones de ventana.

El esquema relaciona `clientes`, `categorias`, `productos` y `ventas` mediante claves primarias y foráneas. También utiliza restricciones `CHECK`, carga datos de prueba dentro de una transacción y deja un cliente sin compras para comprobar el análisis correspondiente.

## Estructura

```text
coder-SQL/
├── retail_project.sql
├── pre-entrega-modulo4.sql
├── preentrega_analisis_avanzado.sql
└── README.md
```
