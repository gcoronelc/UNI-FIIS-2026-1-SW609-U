select * from test;

select count(*) from test;

update emp set sal = 0;

select * from emp;

rollback;

create or replace function fn108 ( n number ) return number
is
  f number := 1;
begin
  for k in 2 .. n loop
    f := f * k;
  end loop;
  return f;
end;
/

select fn108(5) from dual;


create or replace procedure pr103 ( n number, msg varchar2 )
is
  k number := 1000;
begin
  for k in 1 .. n loop
    dbms_output.put_line( k || ' - ' || msg  || ', ' || pr103.k );
  end loop;
  dbms_output.put_line( 'k = ' || k );
end;
/

execute pr103(5,'Estudia y trinfuras.');


create or replace procedure pr106( cod dept.deptno%type )
is
  r dept%rowtype;
  cont number(3,0);
begin
  select count(1) into cont
    from dept where deptno = cod;
  if (cont = 0) then
    dbms_output.put_line('Codigo no existe!!');
    return;
  end if;
  select * into r
    from dept where deptno = cod;
  dbms_output.put_line('Codigo: ' || r.deptno);
  dbms_output.put_line('Nombre: ' || r.dname);
  dbms_output.put_line('Localización: ' || r.loc);
end;
/

EXECUTE pr106(10);


create or replace procedure pr106( cod dept.deptno%type )
is
  r dept%rowtype;
  cont number(3,0);
begin
  select * into r
    from dept where deptno = cod;
  dbms_output.put_line('Codigo: ' || r.deptno);
  dbms_output.put_line('Nombre: ' || r.dname);
  dbms_output.put_line('Localización: ' || r.loc);
EXCEPTION
    when no_data_found then
        dbms_output.put_line('Codigo no existe!!');
end;
/

EXECUTE pr106(1000);
