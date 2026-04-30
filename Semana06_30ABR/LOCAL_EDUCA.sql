/*
Desarrolle una sentencia SELECT para obtener un listado que incluya el nombre del
curso con sus respectivos nombres de alumnos. 
Esquema: EDUCA.
*/

SELECT 
    c.cur_nombre CURSO,
    a.alu_nombre ALUMNO
FROM curso C
JOIN matricula M ON c.cur_id=m.alu_id
JOIN alumno A ON m.alu_id = a.alu_id;

select * from curso;
select * from matricula;
select * from pago;


with 
t1 as (
    select cur_id, sum(mat_precio) esperado
    from matricula
    group by cur_id
),
t2 as (
    select cur_id, sum(pag_importe) recaudado
    from pago
    group by cur_id
)
select 
    c.cur_nombre, c.cur_matriculados, 
    t1.esperado, nvl(t2.recaudado,0.0) recaudado,
    t1.esperado - nvl(t2.recaudado,0.0) falta
from curso c
join t1 on c.cur_id = t1.cur_id
left join t2 on c.cur_id = t2.cur_id


















