-- Paso 1

SELECT index_name, index_type, uniqueness, status
FROM   user_indexes
WHERE  table_name = 'EMPLOYEES';

select * from employees;

SELECT employee_id, first_name, last_name, salary
FROM   hr.employees
WHERE first_name = 'Diana';
--WHERE  last_name = 'King';

SELECT employee_id, first_name, last_name, salary
FROM   hr.employees
WHERE salary > 10000.00;

select * from table(dbms_xplan.display_cursor(sql_id=>'bgfszr4br19nc', format=>'ALLSTATS LAST'));



-- Creación: columnas en orden (leading column primero)
CREATE INDEX idx_emp_dept_sal
  ON hr.employees (department_id, salary);

-- CASO 1: Usa el índice (department_id es leading column)
SELECT * FROM hr.employees WHERE department_id = 60;

-- CASO 2: Usa el índice (ambas columnas del índice presentes)
SELECT * FROM hr.employees
WHERE  department_id = 60 AND salary > 5000;

-- CASO 3: NO usa el índice (solo columna no-leading)
SELECT * FROM hr.employees WHERE salary > 5000;
-- Para este caso necesitaría un índice separado sobre SALARY

-- Ejemplo con esquema SCOTT:
CREATE INDEX idx_emp_deptno_sal ON scott.emp (deptno, sal);
SELECT ename, sal FROM scott.emp WHERE deptno = 10 AND sal > 2000;




