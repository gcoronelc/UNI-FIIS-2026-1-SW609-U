WITH ranking_salarios AS (
    SELECT
        e.employee_id,
        e.first_name || ' ' || e.last_name  AS empleado,
        d.department_name                    AS departamento,
        e.salary,
        RANK() OVER (
            ORDER BY e.salary DESC
        )                                    AS rank_en_depto
    FROM
        hr.employees    e
        JOIN hr.departments d ON e.department_id = d.department_id
)
SELECT *
FROM   ranking_salarios
WHERE  rank_en_depto <= 3
ORDER BY
    departamento,
    rank_en_depto;