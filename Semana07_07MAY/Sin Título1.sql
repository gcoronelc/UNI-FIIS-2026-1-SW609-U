SELECT
    e.employee_id,
    e.first_name || ' ' || e.last_name AS empleado,
    e.hire_date,
    TRUNC(MONTHS_BETWEEN(SYSDATE, e.hire_date)/12)  AS meses_en_empresa,
    CASE
        WHEN TRUNC(MONTHS_BETWEEN(SYSDATE, e.hire_date)/12) < 3 THEN 'Junior'
        WHEN TRUNC(MONTHS_BETWEEN(SYSDATE, e.hire_date)/12) BETWEEN 3 AND 10 THEN 'Senior'
        ELSE 'Veterano'
    END AS categoria,
    e.salary * 12 AS salario_anual
FROM
    hr.employees e
ORDER BY
    meses_en_empresa DESC;