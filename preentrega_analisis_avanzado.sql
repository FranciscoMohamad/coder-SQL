-- CTE 1: agrupa los ingresos de ventas por mes y categoria.
-- El importe de cada venta se obtiene multiplicando la cantidad por el precio.
WITH ventas_mensuales AS (
    SELECT
        DATE_TRUNC('month', v.fecha)::date AS mes,
        c.nombre AS categoria,
        SUM(v.cantidad * p.precio) AS venta_total
    FROM ventas AS v
    INNER JOIN productos AS p ON p.producto_id = v.producto_id
    INNER JOIN categorias AS c ON c.categoria_id = p.categoria_id
    GROUP BY
        DATE_TRUNC('month', v.fecha)::date,
        c.nombre
),
-- CTE 2: calcula la posicion mensual de cada categoria, su acumulado historico
-- y el promedio mensual necesario para la comparacion final.
metricas_ventana AS (
    SELECT
        vm.mes,
        vm.categoria,
        vm.venta_total,
        RANK() OVER (
            PARTITION BY vm.mes
            ORDER BY vm.venta_total DESC
        ) AS ranking_mensual,
        SUM(vm.venta_total) OVER (
            PARTITION BY vm.categoria
            ORDER BY vm.mes
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS venta_acumulada,
        AVG(vm.venta_total) OVER (
            PARTITION BY vm.categoria
        ) AS promedio_historico
    FROM ventas_mensuales AS vm
)
-- Consulta final: compara cada venta mensual con el promedio historico de su
-- categoria y devuelve las etiquetas solicitadas por la consigna.
SELECT
    mv.mes,
    mv.categoria,
    mv.venta_total,
    mv.ranking_mensual,
    mv.venta_acumulada,
    CASE
        WHEN mv.venta_total >= mv.promedio_historico THEN 'Exitoso'
        ELSE 'Bajo el promedio'
    END AS comparativa
FROM metricas_ventana AS mv
ORDER BY mv.mes, mv.ranking_mensual, mv.categoria;