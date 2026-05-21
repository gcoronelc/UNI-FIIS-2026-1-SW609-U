-- Pregunta 1
-- =================================================

/*
Esquema: ALMACEN
- PRODUCTOS

Esquema: FACTURACION
- DETALLE_FACTURA

2.1 Respuesta: REFERENCES

-- Con el rol DBA
GRANT REFERENCES ON ALMACEN.PRODUCTOS TO FACTURACION;

-- Como usuario ALMACEN
GRANT REFERENCES ON PRODUCTOS TO FACTURACION;

2.2 Sentencia DDL

CREATE TABLE DETALLE_FACTURA(
    id_linea NUMBER PRIMARY KEY,
    id_factura NUMBER NOT NULL,
    id_producto NUMBER NOT NULL,
    cantidad NUMBER(8) NOT NULL,
    precio_unitario NUMBER(12,2) NOT NULL,
    CONSTRAINT FK_DETALLE_PRODUCTOS
        FOREIGN KEY(id_producto)
        REFERENCES ALMACEN.PRODUCTOS
);
*/

-- Pregunta 2
-- =================================================

-- 2.1 ROL: DBA

SELECT owner, table_name, tablespace_name
FROM dba_tables
WHERE owner in ('SCOTT','HR','EDUCA')
ORDER BY 1, 2;

-- 2.2 USUARIO: VENTAS

SELECT owner, table_name 
FROM all_tables
order by 1, 2;


-- Pregunta 3
-- =================================================

WITH
t1 AS (
    SELECT department_id, CAST(AVG(salary) as number(10,2)) sprom
    FROM employees
    GROUP BY department_id
)
SELECT 
    e.employee_id, e.first_name, e.last_name,
    e.department_id, e.salary, t1.sprom
FROM employees e
JOIN t1 on e.department_id = t1.department_id
WHERE e.salary > t1.sprom;

-- Pregunta 4
-- =================================================
/*
4.1 El error esta en la definición del indice, se trata de un indice 
compuesto por 2 columnas,  y la primera columna, la columna lider no se
esta utilizando en el filtro, clausula WHERE.

4.2 La solución es crear un indice por la columna salario.

CREATE INDEX idx_emp_sal
ON hr.employees (salary);
*/


-- Pregunta 5
-- =================================================

WITH
t1 as (
    SELECT department_id, sum(salary) salario
    FROM employees
    where department_id is not null
    group by department_id
)
select 
    d.department_id, d.department_name, 
    nvl(t1.salario,0.0) suma_salarios
from departments d
left join t1 on d.department_id = t1.department_id
order by 1;













