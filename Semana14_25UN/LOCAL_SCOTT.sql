CREATE OR REPLACE TRIGGER tr_test_emp
AFTER INSERT OR DELETE OR UPDATE ON emp
FOR EACH ROW 
BEGIN
  IF INSERTING THEN
    DBMS_OUTPUT.PUT_LINE('nuevo empleado se ha insertado');
  ELSIF UPDATING THEN
    DBMS_OUTPUT.PUT_LINE('un empleado se ha modificado');
  ELSIF DELETING THEN
    DBMS_OUTPUT.PUT_LINE('un empleado se ha eliminado');
  END IF;
END tr_test_emp;
/

select * from emp;

update emp set sal = 5000;

select * from emp;



CREATE TABLE Sal_History (
    EmpNo     NUMBER(4)    NOT NULL,
    SalOld    NUMBER(7,2)  NULL,
    SalNew    NUMBER(7,2)  NULL,
    StartDate DATE         NOT NULL,
    SetUser   VARCHAR2(30) NOT NULL
);


CREATE OR REPLACE TRIGGER tr_UpdateEmpSal
AFTER INSERT OR UPDATE ON Emp
FOR EACH ROW
BEGIN
    INSERT INTO Sal_History
        (EmpNo, SalOld, SalNew, StartDate, SetUser)
    VALUES
        (:NEW.EmpNo, :OLD.Sal, :NEW.Sal, SYSDATE, USER);
END tr_UpdateEmpSal;
/

select * from emp 
where empno = 7369;

select * from sal_history;

UPDATE emp SET sal = 1200
WHERE empno = 7369;


CREATE OR REPLACE TRIGGER tr_deny_drop
BEFORE DROP ON SCHEMA
BEGIN
    RAISE_APPLICATION_ERROR(-20000,
        'No es posible borrar objetos.');
END tr_deny_drop;
/


drop table emp;

select * from emp;


SELECT object_name,
       original_name,
       droptime
FROM recyclebin;

FLASHBACK TABLE emp TO BEFORE DROP;

CREATE OR REPLACE TRIGGER tr_deny_drop
BEFORE DROP ON DATABASE
BEGIN
   RAISE_APPLICATION_ERROR(
      -20000,
      'No es posible borrar objetos.'
   );
END;
/


EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE deptno = 80;

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);

SELECT PLAN_TABLE_OUTPUT
FROM TABLE(DBMS_XPLAN.DISPLAY);

