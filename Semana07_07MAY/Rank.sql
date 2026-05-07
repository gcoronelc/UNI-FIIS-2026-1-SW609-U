SELECT
    e.employee_id,
    e.first_name || ' ' || e.last_name  AS empleado,
    d.department_name                    AS departamento,
    j.job_title                          AS puesto,
    e.salary,
    RANK() OVER (ORDER BY e.salary DESC) AS rank_global
FROM
    hr.employees  e
    JOIN hr.departments d ON e.department_id = d.department_id
    JOIN hr.jobs        j ON e.job_id        = j.job_id
ORDER BY
    rank_global;
    
    
SELECT
    e.employee_id,
    e.first_name || ' ' || e.last_name  AS empleado,
    d.department_name                    AS departamento,
    j.job_title                          AS puesto,
    e.salary,
    RANK()       OVER (ORDER BY e.salary DESC) AS rank_global,
    DENSE_RANK() OVER (ORDER BY e.salary DESC) AS dense_rank_global
FROM
    hr.employees  e
    JOIN hr.departments d ON e.department_id = d.department_id
    JOIN hr.jobs        j ON e.job_id        = j.job_id
ORDER BY
    rank_global;   
    
    
SELECT
    e.employee_id,
    e.first_name || ' ' || e.last_name  AS empleado,
    d.department_name                    AS departamento,
    e.salary,
    RANK() OVER (
        PARTITION BY e.department_id
        ORDER BY e.salary DESC
    ) AS rank_en_depto,
    DENSE_RANK() OVER (
        PARTITION BY e.department_id
        ORDER BY e.salary DESC
    ) AS dense_rank_en_depto 
FROM
    hr.employees  e
    JOIN hr.departments d ON e.department_id = d.department_id
ORDER BY
    d.department_name,
    rank_en_depto;    
    

SELECT
    e.employee_id,
    e.first_name || ' ' || e.last_name  AS empleado,
    d.department_name                    AS departamento,
    e.salary,
    RANK() OVER (
        PARTITION BY e.department_id
        ORDER BY e.salary DESC
    ) AS rank_en_depto,
    DENSE_RANK() OVER (
        PARTITION BY e.department_id
        ORDER BY e.salary DESC
    ) AS dense_rank_en_depto,          -- coma aquí
    ROUND(
        e.salary / SUM(e.salary) OVER (PARTITION BY e.department_id) * 100, 2
    )                                    AS pct_masa_salarial_depto       -- columna restaurada
FROM
    hr.employees  e
    JOIN hr.departments d ON e.department_id = d.department_id
ORDER BY
    d.department_name,
    rank_en_depto;    
    

SELECT
    employee_id,
    empleado,
    departamento,
    salary,
    rank_en_depto
FROM (
    SELECT
        e.employee_id,
        e.first_name || ' ' || e.last_name  AS empleado,
        d.department_name                    AS departamento,
        e.salary,
        DENSE_RANK() OVER (
            PARTITION BY e.department_id
            ORDER BY e.salary DESC
        )                                    AS rank_en_depto
    FROM
        hr.employees    e
        JOIN hr.departments d ON e.department_id = d.department_id
)
WHERE rank_en_depto <= 3
ORDER BY
    departamento,
    rank_en_depto;
    
    
    
    
    