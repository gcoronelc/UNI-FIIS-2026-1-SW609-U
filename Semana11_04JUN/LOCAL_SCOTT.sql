create or replace function fn107 (n number) return number
is
  f number := 1; -- Para el factorial
  cont number := n;
begin
  loop
    exit when (cont<=0);
    f := f * cont;
    cont := cont - 1;
  end loop;
  return f;
end;
/

select fn107(5) from dual;

select fn107(-2) from dual;

create SEQUENCE sqtest;

create global temporary table test (
  id number primary key,
  dato varchar2(30)
) on commit preserve rows;

select * from test;

create or replace procedure pr102 (n number)
is
  k number := 0;
begin
  while (k<n) loop
    insert into test( id, dato )
      values( sqtest.nextval, 'Gustavo Coronel' );
    k := k + 1;
  end loop;
  commit;
  dbms_output.put_line('Proceso Ejecutado');
end;
/

execute pr102(100);

begin
    pr102(100);
end;
/


