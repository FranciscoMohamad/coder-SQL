-- PROYECTO RETAIL
-- Pre-entrega: Tablas principales con restricciones y datos iniciales

-- Crear la base desde una conexión a PostgreSQL:
CREATE DATABASE retail_project;

-- Luego conectarse a retail_project y ejecutar desde aquí.

CREATE TABLE clientes (
    cliente_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    edad INT NOT NULL CHECK (edad >= 18)
);

CREATE TABLE productos (
    producto_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    precio DECIMAL(10,2) NOT NULL CHECK (precio > 0),
    stock INT NOT NULL CHECK (stock >= 0)
);

CREATE TABLE ventas (
    venta_id SERIAL PRIMARY KEY,
    cliente_id INT NOT NULL,
    producto_id INT NOT NULL,
    cantidad INT NOT NULL CHECK (cantidad > 0),
    fecha DATE NOT NULL,
    CONSTRAINT fk_ventas_cliente FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id),
    CONSTRAINT fk_ventas_producto FOREIGN KEY (producto_id) REFERENCES productos(producto_id)
);

-- Carga inicial: todos los INSERT están dentro de una transacción.
BEGIN;

INSERT INTO clientes (nombre, email, edad) VALUES ('Juan Pérez', 'juan.perez@email.com', 28);
INSERT INTO clientes (nombre, email, edad) VALUES ('María González', 'maria.gonzalez@email.com', 35);
INSERT INTO clientes (nombre, email, edad) VALUES ('Lucas Rodríguez', 'lucas.rodriguez@email.com', 22);
INSERT INTO clientes (nombre, email, edad) VALUES ('Sofía Martínez', 'sofia.martinez@email.com', 31);
INSERT INTO clientes (nombre, email, edad) VALUES ('Carlos Fernández', 'carlos.fernandez@email.com', 45);

INSERT INTO productos (nombre, categoria, precio, stock) VALUES ('Notebook Lenovo', 'Tecnología', 850000.00, 10);
INSERT INTO productos (nombre, categoria, precio, stock) VALUES ('Mouse inalámbrico', 'Tecnología', 25000.00, 30);
INSERT INTO productos (nombre, categoria, precio, stock) VALUES ('Teclado mecánico', 'Tecnología', 75000.00, 15);
INSERT INTO productos (nombre, categoria, precio, stock) VALUES ('Remera básica', 'Indumentaria', 18000.00, 40);
INSERT INTO productos (nombre, categoria, precio, stock) VALUES ('Zapatillas deportivas', 'Indumentaria', 95000.00, 20);

INSERT INTO ventas (cliente_id, producto_id, cantidad, fecha) VALUES (1, 1, 1, '2026-09-01');
INSERT INTO ventas (cliente_id, producto_id, cantidad, fecha) VALUES (2, 2, 2, '2026-09-02');
INSERT INTO ventas (cliente_id, producto_id, cantidad, fecha) VALUES (3, 3, 1, '2026-09-03');
INSERT INTO ventas (cliente_id, producto_id, cantidad, fecha) VALUES (4, 4, 3, '2026-09-04');
INSERT INTO ventas (cliente_id, producto_id, cantidad, fecha) VALUES (5, 5, 1, '2026-09-05');

COMMIT;

-- Verificación previa
SELECT * FROM productos WHERE categoria = 'Tecnología';

-- UPDATE preciso por categoría
UPDATE productos
SET precio = precio * 1.10
WHERE categoria = 'Tecnología';

SELECT * FROM productos WHERE categoria = 'Tecnología';

-- DELETE preciso de una venta
SELECT * FROM ventas WHERE venta_id = 5;

DELETE FROM ventas
WHERE venta_id = 5;

SELECT * FROM ventas WHERE venta_id = 5;
