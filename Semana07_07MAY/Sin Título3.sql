select * from jobs;


SELECT
    e.employee_id,
    e.first_name || ' ' || e.last_name  AS empleado,
    j.job_title                          AS puesto,
    j.min_salary,
    j.max_salary,
    e.salary,
    CASE --e.salary
        WHEN e.salary < j.min_salary  THEN 'POR DEBAJO'
        WHEN e.salary > j.max_salary  THEN 'POR ENCIMA'
        ELSE                               'EN RANGO'
    END AS estado_salarial
FROM
    hr.employees  e
    JOIN hr.jobs  j ON e.job_id = j.job_id
ORDER BY
    j.job_title,
    e.salary;
    
    
    
    
SELECT
    d.department_name        AS departamento,
    COUNT(e.employee_id)     AS total_empleados,
    ROUND(AVG(e.salary), 2)  AS promedio_salarial
FROM
    hr.employees    e
    JOIN hr.departments d ON e.department_id = d.department_id
GROUP BY d.department_name 
HAVING COUNT(e.employee_id) > 5  AND AVG(e.salary) > 7000 
ORDER BY
    promedio_salarial DESC;    
    
    