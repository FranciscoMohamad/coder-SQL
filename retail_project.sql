--Tablas principales con restricciones y datos iniciales

-- Crear la base desde una conexión a PostgreSQL:
CREATE DATABASE retail_project;

-- Luego conectarse a retail_project y ejecutar desde aquí.

CREATE TABLE clientes (
    cliente_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    edad INT NOT NULL CHECK (edad >= 18)
);

CREATE TABLE categorias (
    categoria_id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE productos (
    producto_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    categoria_id INT NOT NULL,
    precio DECIMAL(10,2) NOT NULL CHECK (precio > 0),
    stock INT NOT NULL CHECK (stock >= 0),
    CONSTRAINT fk_productos_categoria FOREIGN KEY (categoria_id) REFERENCES categorias(categoria_id)
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

-- Carga inicial:
BEGIN;

INSERT INTO clientes (nombre, email, edad) VALUES ('Juan Pérez', 'juan.perez@email.com', 33);
INSERT INTO clientes (nombre, email, edad) VALUES ('María González', 'maria.gonzalez@email.com', 25);
INSERT INTO clientes (nombre, email, edad) VALUES ('Lucas Rodríguez', 'lucas.rodriguez@email.com', 22);
INSERT INTO clientes (nombre, email, edad) VALUES ('Sofía Martínez', 'sofia.martinez@email.com', 31);
INSERT INTO clientes (nombre, email, edad) VALUES ('Carlos Fernández', 'carlos.fernandez@email.com', 40);

INSERT INTO categorias (nombre) VALUES ('Tecnología');
INSERT INTO categorias (nombre) VALUES ('Indumentaria');

INSERT INTO productos (nombre, categoria_id, precio, stock) VALUES ('Notebook Lenovo', 1, 950000.00, 10);
INSERT INTO productos (nombre, categoria_id, precio, stock) VALUES ('Mouse inalámbrico', 1, 45000.00, 30);
INSERT INTO productos (nombre, categoria_id, precio, stock) VALUES ('Teclado mecánico', 1, 65000.00, 15);
INSERT INTO productos (nombre, categoria_id, precio, stock) VALUES ('Remera básica', 2, 38000.00, 40);
INSERT INTO productos (nombre, categoria_id, precio, stock) VALUES ('Zapatillas deportivas', 2, 95000.00, 20);

INSERT INTO ventas (cliente_id, producto_id, cantidad, fecha) VALUES (1, 1, 1, '2026-09-01');
INSERT INTO ventas (cliente_id, producto_id, cantidad, fecha) VALUES (2, 2, 2, '2026-09-02');
INSERT INTO ventas (cliente_id, producto_id, cantidad, fecha) VALUES (3, 3, 1, '2026-09-03');
INSERT INTO ventas (cliente_id, producto_id, cantidad, fecha) VALUES (4, 4, 3, '2026-09-04');
INSERT INTO ventas (cliente_id, producto_id, cantidad, fecha) VALUES (5, 5, 1, '2026-09-05');

COMMIT;

-- Verificación previa
SELECT p.*
FROM productos AS p
INNER JOIN categorias AS c ON c.categoria_id = p.categoria_id
WHERE c.nombre = 'Tecnología';

-- UPDATE
UPDATE productos
SET precio = precio * 1.10
WHERE categoria_id = (
    SELECT c.categoria_id
    FROM categorias AS c
    WHERE c.nombre = 'Tecnología'
);

SELECT p.*
FROM productos AS p
INNER JOIN categorias AS c ON c.categoria_id = p.categoria_id
WHERE c.nombre = 'Tecnología';

-- DELETE
SELECT * FROM ventas WHERE venta_id = 5;

DELETE FROM ventas
WHERE venta_id = 5;

SELECT * FROM ventas WHERE venta_id = 5;
