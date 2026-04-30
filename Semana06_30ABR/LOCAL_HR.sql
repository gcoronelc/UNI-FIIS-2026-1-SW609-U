select * from employees
where salary > 15000;

select 
    sum(salary) planilla,
    sum(salary * 1.20) planilla_proyectada                                                                                                                                                                  
from employees;

select * from departments;

select 
    sum(salary) planilla,
    sum(salary * 1.20) planilla_proyectada                                                                                                                                                                  
from employees
where department_id = 80;

select * from jobs;

select 
    sum(salary) planilla,
    sum(salary * 1.20) planilla_proyectada                                                                                                                                                                  
from employees
where department_id = 80
and job_id = 'SA_REP';


-- PLANILLA POR DEPARTAMENTO

-- Caso 1: Con una sola tabla

select department_id, sum(salary) planilla 
from employees
where department_id is not null
group by department_id
order by 1;


-- Caso 2: Con 2 tablas

select d.department_name, sum(salary) planilla 
from departments d
join employees e on d.department_id = e.department_id
group by d.department_name
order by 1;


-- Caso 3: Con CTE

with 
t1 as (
    select department_id, sum(salary) planilla 
    from employees
    where department_id is not null
    group by department_id
)
select d.department_name, t1.planilla 
from t1
join departments d on t1.department_id = d.department_id;

