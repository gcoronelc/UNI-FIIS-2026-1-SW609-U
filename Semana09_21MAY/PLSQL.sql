-- Ejemplo 1

DECLARE
    saludo VARCHAR2(100);
BEGIN
    saludo := 'Hola amigos.';
    dbms_output.put_line(saludo);
END;
/

-- Ejemplo 2

Declare
  sFecha Varchar2(40);
Begin
  select to_char(sysdate,'dd/MON/yyyy hh24:mm:ss')
    into sFecha from dual;
  dbms_output.put_line( 'Hoy es: ' || sFecha );
End;
/


SELECT 4+3 FROM DUAL;

SELECT * FROM DUAL;

-- Función

create or replace function fnSuma( a number, b number ) return number
is
  c number;
begin
  c := a + b;
  return c;
end;
/

select fnsuma(6,7) suma from dual;

-- Procedimiento

create or replace procedure prSuma( a number, b number )
is
  c number;
begin
  c := a + b;
  dbms_output.put_line( c );
end;
/

begin
   prSuma(34,67);
end;
/










