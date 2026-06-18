
CREATE OR REPLACE PACKAGE testpackage as
  function suma( n1 in number, n2 in number ) return number;
END testpackage;
/


CREATE OR REPLACE PACKAGE BODY testpackage as

  function suma( n1 in number, n2 in number ) return number
  as
      rtn number;
  begin
      rtn := n1 + n2;
      return rtn;
  end;

END testpackage;
/

select testpackage.suma(10,15) from dual;


