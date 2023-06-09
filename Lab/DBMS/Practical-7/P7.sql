DECLARE
V_DESIGNATION EMPP.DESIGNATION%TYPE := &DESIGNATION;
V_COUNT NUMBER(2):=0;
CURSOR FACULTY IS
SELECT EID , ENAME , DESIGNATION
FROM EMPP
WHERE UPPER(DESIGNATION) = UPPER(V_DESIGNATION);
EMPP_REC FACULTY%ROWTYPE;

BEGIN
OPEN FACULTY;
LOOP
FETCH FACULTY INTO EMPP_REC;
EXIT WHEN FACULTY%NOTFOUND ;
DBMS_OUTPUT.PUT_LINE(RPAD(EMPP_REC.EID , 8) ||''|| RPAD(EMPP_REC.ENAME 
, 20)||''||RPAD(EMPP_REC.DESIGNATION,23));
V_COUNT := V_COUNT + 1;
END LOOP;
IF V_COUNT = 0 THEN
DBMS_OUTPUT.PUT_LINE('NO MATCHING DATA FOUND');
ELSE
DBMS_OUTPUT.PUT_LINE('MATCHING DATA FOUND');
END IF;
CLOSE FACULTY;
DBMS_OUTPUT.PUT_LINE(CHR(10));
DBMS_OUTPUT.PUT_LINE('CURSOR PROCESSED');
END ;
/

DECLARE
V_DESIGNATION EMPP.DESIGNATION%TYPE := &DESIGNATION;
CURSOR FACULTY_CFL IS
SELECT EID , ENAME , DESIGNATION
FROM EMPP
WHERE UPPER(DESIGNATION) = UPPER(V_DESIGNATION);
BEGIN
DBMS_OUTPUT.PUT_LINE('THE CURSOR FOR LOOP.................');
DBMS_OUTPUT.PUT_LINE(CHR(10));
FOR EMPP_REC IN FACULTY_CFL
LOOP
DBMS_OUTPUT.PUT_LINE(RPAD(EMPP_REC.EID , 8) ||''|| RPAD(EMPP_REC.ENAME , 
)||''||RPAD(EMPP_REC.DESIGNATION,23));
END LOOP;
DBMS_OUTPUT.PUT_LINE(CHR(10));
DBMS_OUTPUT.PUT_LINE('THE CURSOR FOR LOOP WITH %ROWCOUNT.................');
DBMS_OUTPUT.PUT_LINE(CHR(10));
FOR EMPP_REC IN FACULTY_CFL
LOOP
DBMS_OUTPUT.PUT_LINE(RPAD(FACULTY_CFL%ROWCOUNT ,4) 
||''||RPAD(EMPP_REC.EID , 8) ||''|| RPAD(EMPP_REC.ENAME , 
)||''||RPAD(EMPP_REC.DESIGNATION,23));
END LOOP;
DBMS_OUTPUT.PUT_LINE('CURSOR PROCESSED');
END ;
/

DECLARE
V_DESIGNATION EMPP.DESIGNATION%TYPE := &DESIGNATION;
V_COUNT NUMBER(2):=&HOW_MANY_ROWS;
CURSOR FACULTY_CFL_A IS
SELECT EID , ENAME , DESIGNATION
FROM EMPP
WHERE UPPER(DESIGNATION) = UPPER(V_DESIGNATION);
BEGIN
FOR EMPP_REC IN FACULTY_CFL_A
LOOP
DBMS_OUTPUT.PUT_LINE(RPAD(FACULTY_CFL_A%ROWCOUNT ,4) 
||''||RPAD(EMPP_REC.EID, 8) 
||''|| RPAD(EMPP_REC.ENAME , 20)||''||RPAD(EMPP_REC.DESIGNATION,23));
IF(FACULTY_CFL_A%ROWCOUNT = V_COUNT) THEN
EXIT;
END IF;
END LOOP;
DBMS_OUTPUT.PUT_LINE('CURSOR PROCESSED');
END ;
/

DECLARE
V_EMPLOYEE EMPLOYEE%ROWTYPE;
V_SAL_1 EMPLOYEE.SALARY%TYPE := &SPECIFIED_SALARY;
V_SAL_2 EMPLOYEE.SALARY%TYPE := &SPECIFIED_SALARY;
V_DESIGNATION_2 EMPLOYEE.DESIGNATION%TYPE := &DESIGNATION_SALARY;
CURSOR EMP_SAL_INFO( V_SAL EMPLOYEE.SALARY%TYPE := 75000 , V_DESIGNATION 
EMPLOYEE.DESIGNATION%TYPE := 'Asst. Professor') IS
SELECT * FROM EMPLOYEE
WHERE SALARY > V_SAL AND DESIGNATION = V_DESIGNATION;

BEGIN
DBMS_OUTPUT.PUT_LINE('WITH DEFAULT VALUES.....');
DBMS_OUTPUT.PUT_LINE(CHR(10));
OPEN EMP_SAL_INFO;
LOOP
FETCH EMP_SAL_INFO INTO V_EMPLOYEE;
EXIT WHEN EMP_SAL_INFO%NOTFOUND ;
DBMS_OUTPUT.PUT_LINE(RPAD(V_EMPLOYEE.ENO , 8) ||''|| 
RPAD(V_EMPLOYEE.FNAME||' '|| V_EMPLOYEE.LNAME, 
)||''||RPAD(V_EMPLOYEE.DESIGNATION,17)
||''||RPAD(V_EMPLOYEE.SALARY,23));
END LOOP;
CLOSE EMP_SAL_INFO;
DBMS_OUTPUT.PUT_LINE(CHR(10));
DBMS_OUTPUT.PUT_LINE('WITH SOME DEFAULT VALUES.....');
DBMS_OUTPUT.PUT_LINE(CHR(10));
OPEN EMP_SAL_INFO(V_SAL_1);
LOOP
FETCH EMP_SAL_INFO INTO V_EMPLOYEE;
EXIT WHEN EMP_SAL_INFO%NOTFOUND ;
DBMS_OUTPUT.PUT_LINE(RPAD(V_EMPLOYEE.ENO , 8) ||''|| 
RPAD(V_EMPLOYEE.FNAME||' '|| V_EMPLOYEE.LNAME, 
)||''||RPAD(V_EMPLOYEE.DESIGNATION,17)
||''||RPAD(V_EMPLOYEE.SALARY,23));
END LOOP;
CLOSE EMP_SAL_INFO;

DBMS_OUTPUT.PUT_LINE('WITH SUPPLIED VALUES.....');
DBMS_OUTPUT.PUT_LINE(CHR(10));
OPEN EMP_SAL_INFO(V_SAL_2,V_DESIGNATION_2);
LOOP
FETCH EMP_SAL_INFO INTO V_EMPLOYEE;
EXIT WHEN EMP_SAL_INFO%NOTFOUND ;
DBMS_OUTPUT.PUT_LINE(RPAD(V_EMPLOYEE.ENO , 8) ||''|| 
RPAD(V_EMPLOYEE.FNAME||' '|| V_EMPLOYEE.LNAME, 
)||''||RPAD(V_EMPLOYEE.DESIGNATION,17)
||''||RPAD(V_EMPLOYEE.SALARY,23));
END LOOP;
CLOSE EMP_SAL_INFO;
END;
/


CREATE OR REPLACE PROCEDURE PRINT_EMPLOYEE(V_EMP_SALARY_INP EMPP.SALARY%TYPE)
AS
TYPE EMP_ENO IS VARRAY(100) OF EMPP.EID%TYPE;
TYPE EMP_ENAME IS VARRAY(100) OF EMPP.ENAME%TYPE;
TYPE EMP_SALARY IS VARRAY(100) OF EMPP.SALARY%TYPE;

V_EMP_ENO EMP_ENO;
V_EMP_ENAME EMP_ENAME;
V_EMP_SALARY EMP_SALARY;

CURSOR SAL_CURSOR IS
SELECT EID , ENAME , SALARY
FROM EMPP
WHERE SALARY > V_EMP_SALARY_INP;

BEGIN
OPEN SAL_CURSOR;
FETCH SAL_CURSOR
BULK COLLECT INTO V_EMP_ENO , V_EMP_ENAME , V_EMP_SALARY;
CLOSE SAL_CURSOR;
DBMS_OUTPUT.PUT_LINE('EMPLOYEE SALARY HAVING > '||''||V_EMP_SALARY_INP);
DBMS_OUTPUT.PUT_LINE(RPAD('EID',7) ||''||RPAD('ENAME',20) 
||''||RPAD('SALARY',9));
DBMS_OUTPUT.PUT_LINE('---- --------------- -----------');
FOR KNT IN V_EMP_ENO.FIRST .. V_EMP_ENO.LAST
LOOP
DBMS_OUTPUT.PUT_LINE(RPAD(V_EMP_ENO(KNT),7) ||'' 
||RPAD(V_EMP_ENAME(KNT),20)||''||RPAD(V_EMP_SALARY(KNT),16));
END LOOP;
DBMS_OUTPUT.PUT_LINE('---- --------------- -----------');
DBMS_OUTPUT.PUT_LINE('.....END BULK FETCH.....');
END;
/

EMPLOYEE SALARY HAVING > 90000
EID ENAME SALARY
---- --------------- -----------
7101 Eugene Sabatini 150000
7102 Samantha Jones 146500
7103 Alexander Lloyd 148000
7104 Simon Downing 138400
7105 Christina Mulboro 127400
7106 Dolly Silverline 127400
7107 Christov Plutnik 127400
7108 Ellena Sanchez 119700
7109 Martina Jacobson 91000
---- --------------- -----------
.....END BULK FETCH.....
Call completed.

