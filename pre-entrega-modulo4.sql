-- 1. Rentabilidad por categoría
-- Problema de negocio: permite detectar las categorías con suficiente volumen de
-- ventas para priorizar su reposición y comparar los ingresos que generan.
-- Umbral definido en 2 unidades porque descarta categorías con ventas aisladas
-- y conserva las que muestran una demanda relevante en este conjunto de datos.
SELECT
    c.nombre AS categoria,
    SUM(v.cantidad) AS unidades_vendidas,
    SUM(v.cantidad * p.precio) AS ingreso_total
FROM ventas AS v
INNER JOIN productos AS p ON p.producto_id = v.producto_id
INNER JOIN categorias AS c ON c.categoria_id = p.categoria_id
GROUP BY c.categoria_id, c.nombre
HAVING SUM(v.cantidad) > 2
ORDER BY ingreso_total DESC;

-- 2. Clientes sin compras
-- Problema de negocio: identifica clientes registrados que todavía no compraron
-- para dirigirles acciones de activación. El LEFT JOIN los conserva aunque no
-- tengan ventas y COALESCE muestra 0 unidades en lugar de NULL.
SELECT
    c.cliente_id,
    c.nombre AS cliente,
    COALESCE(SUM(v.cantidad), 0) AS unidades_compradas
FROM clientes AS c
LEFT JOIN ventas AS v ON v.cliente_id = c.cliente_id
GROUP BY c.cliente_id, c.nombre
HAVING COUNT(v.venta_id) = 0
ORDER BY c.nombre;

-- 3. Top de compras por cliente
-- Problema de negocio: muestra el producto adquirido en mayor cantidad por cada
-- cliente para personalizar ofertas, junto con la fecha de su transacción más
-- reciente para medir qué tan actual es su relación comercial.
WITH compras_por_producto AS (
    SELECT
        c.cliente_id,
        c.nombre AS cliente,
        p.producto_id,
        p.nombre AS producto,
        SUM(v.cantidad) AS unidades_compradas,
        MAX(v.fecha) AS ultima_compra_producto
    FROM clientes AS c
    INNER JOIN ventas AS v ON v.cliente_id = c.cliente_id
    INNER JOIN productos AS p ON p.producto_id = v.producto_id
    GROUP BY c.cliente_id, c.nombre, p.producto_id, p.nombre
), ranking_compras AS (
    SELECT
        cpp.cliente_id,
        cpp.cliente,
        cpp.producto_id,
        cpp.producto,
        cpp.unidades_compradas,
        MAX(cpp.ultima_compra_producto) OVER (
            PARTITION BY cpp.cliente_id
        ) AS ultima_transaccion,
        ROW_NUMBER() OVER (
            PARTITION BY cpp.cliente_id
            ORDER BY cpp.unidades_compradas DESC, cpp.producto_id
        ) AS posicion
    FROM compras_por_producto AS cpp
)
SELECT
    rc.cliente,
    rc.producto AS producto_mas_comprado,
    rc.unidades_compradas,
    rc.ultima_transaccion
FROM ranking_compras AS rc
WHERE rc.posicion = 1
ORDER BY rc.cliente;