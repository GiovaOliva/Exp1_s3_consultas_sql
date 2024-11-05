-- Caso 1: Gestión de inventario y pedidos

-- Lista el nombre de cada producto agrupado por categoría. Ordena los resultados por precio de mayor a menor.
SELECT categoria, 
       nombre, 
       precio 
FROM productos
GROUP BY categoria, nombre, precio
ORDER BY precio DESC;

-- Calcula el promedio de ventas mensuales (en cantidad de productos) y muestra el mes y año con mayores ventas.
SELECT TO_CHAR(fecha, 'MM-YYYY') AS mes_anio,
       AVG(cantidad) AS promedio_ventas_mensual
FROM ventas
GROUP BY TO_CHAR(fecha, 'MM-YYYY')
ORDER BY promedio_ventas_mensual DESC
FETCH FIRST 1 ROW ONLY;

-- Encuentra el ID del cliente que ha gastado más dinero en compras durante el último año.
-- Asegúrate de considerar clientes que se registraron hace menos de un año.

SELECT v.cliente_id, 
       SUM(p.precio * v.cantidad) AS total_gastado
FROM ventas v
JOIN productos p ON v.producto_id = p.producto_id
JOIN clientes c ON v.cliente_id = c.cliente_id group by v.cliente_id
WHERE v.fecha >= ADD_MONTHS(SYSDATE, -12)
  AND c.fecha_registro >= ADD_MONTHS(SYSDATE, -12)
GROUP BY v.cliente_id
ORDER BY total_gastado DESC
FETCH FIRST 1 ROW ONLY;


-- Caso 2: Gestión de Recursos Humanos

-- Determina el salario promedio, el salario máximo y el salario mínimo por departamento.

SELECT departamento_id, 
       AVG(salario) AS salario_promedio, 
       MAX(salario) AS salario_maximo, 
       MIN(salario) AS salario_minimo
FROM empleados
GROUP BY departamento_id;

-- Utilizando funciones de grupo, encuentra el salario más alto en cada departamento.

SELECT departamento_id, 
       MAX(salario) AS salario_mas_alto
FROM empleados
GROUP BY departamento_id;

-- Calcula la antigüedad en años de cada empleado y muestra aquellos con más de 10 años en la empresa.

SELECT empleado_id, 
       nombre, 
       FLOOR(MONTHS_BETWEEN(SYSDATE, fecha_contratacion) / 12) AS antiguedad_en_anios
FROM empleados
WHERE FLOOR(MONTHS_BETWEEN(SYSDATE, fecha_contratacion) / 12) > 10;