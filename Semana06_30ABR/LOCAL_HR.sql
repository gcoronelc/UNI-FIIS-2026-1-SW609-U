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


select * from employees;



/*
Se necesita saber quien es el empleado con mayor salario
por departamento, incluir los empates.
*/

-- Caso 1

select * from employees
where (department_id, salary) in 
( select department_id, max(salary) Maximo
  from employees
  group by department_id)
order by department_id;


-- Caso 2

select e.* 
from employees e
join ( select department_id, max(salary) maximo
          from employees
          group by department_id) t
on e.department_id=t.department_id
and e.salary = t.maximo
order by e.department_id;


-- Caso 3

with
t as (
    select department_id, max(salary) maximo
    from employees
    group by department_id
)
select e.* 
from employees e join t
on e.department_id=t.department_id
and e.salary = t.maximo
order by e.department_id;



-- Caso 4

select e.* 
from employees e
where e.salary = (
    select max(salary)
    from employees x
    where x.department_id = e.department_id
)
order by e.department_id;

