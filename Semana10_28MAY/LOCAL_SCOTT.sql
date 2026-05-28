-- Operador de asignación

declare
    a number;
    b number;
begin
    a := 10;
    b := fnsuma(4,5);
    
    dbms_output.put_line('a = ' || a);
    dbms_output.put_line('b = ' || b);

end;
/


declare
    planilla number(15,2);
begin
    SELECT SUM(salary) into planilla 
    FROM employees;
    
    -- SELECT NVL(SUM(salary), 0) INTO planilla FROM employees;
    
    dbms_output.put_line('Planilla=' || planilla);
    
end;
/

SELECT NVL(SUM(salary), 0) FROM employees;


declare
    planilla employees.salary%TYPE;
begin
    SELECT SUM(salary) into planilla 
    FROM employees;
    
    -- SELECT NVL(SUM(salary), 0) INTO planilla FROM employees;
    
    dbms_output.put_line('Planilla=' || planilla);
    
end;
/

create or replace function fn101(p_deptno departments.department_id%type)
return departments.department_name%type
is
    v_dname departments.department_name%type;
begin
    select department_name into v_dname from departments 
    where department_id = p_deptno;
    return(v_dname);
end;
/

select hr.fn101(20) from dual;

select * from departments;



create or replace function fn105(n number) return varchar2
is
    rpta varchar2(30);
begin
    case n
        when 1 then
            rpta := 'Uno';
        when 2 then
            rpta := 'Dos';
        else
            rpta := 'None';
    end case;
    return rpta;
end;
/


select fn105(2) from dual;


create or replace function fn105V2(n number) return varchar2
is
    rpta varchar2(30);
begin
    case 
        when n=1 then
            rpta := 'Uno';
        when n=2 then
            rpta := 'Dos';
        else
            rpta := 'None';
    end case;
    return rpta;
end;
/

select fn105(2) from dual;



create or replace function fn106(v_empno emp.empno%type) 
return varchar2 is
    v_msg varchar2(40);
    v_sal emp.sal%type;
    v_cont number(3);
begin
    -- Validacion
    select count(1) into v_cont from emp where empno = v_empno;
    if(v_cont=0) then
        return 'No existe.';
    end if;
    -- Proceso
    select sal into v_sal from emp where empno = v_empno;
    case
        when (v_sal > 0 and v_sal <= 2500) then
            v_msg := 'Salario Bajo';
        when (v_sal > 2500 and v_sal <= 4000) then
            v_msg := 'Salario Regular';
        when (v_sal > 4000) then
            v_msg := 'Salario Bueno';
        else
            v_msg := 'Caso Desconocido';
    end case;
    v_msg := to_char(v_sal,0.0) || ' - ' || v_msg;
    return v_msg;
end;
/

select * from emp;

select fn106(99999) from dual;






