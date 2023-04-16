BEGIN
	DBMS_OUTPUT.PUT_LINE('To Begin, Begin!');
END;
/ -- / is for executing
--Doesn't give desired output

SET SERVEROUTPUT ON
SHOW SERVEROUTPUT

BEGIN
	DBMS_OUTPUT.PUT_LINE('To Begin, Begin!');
END;
/
--Now gives correct output

------------------------------------------------------------------------

DECLARE 
	T_DATE TIMESTAMP;
BEGIN
	SELECT SYSDATE INTO T_DATE FROM DUAL;
	DBMS_OUTPUT.PUT_LINE('Today is '|| T_DATE); 
END;
/

------------------------------------------------------------------------

DECLARE 
	NUM NUMBER(2);
BEGIN	
	NUM := &NUM_IN;
	IF MOD(NUM, 2) = 0 THEN 
		DBMS_OUTPUT.PUT_LINE(NUM || 'IS AN EVEN NUMBER');
	ELSE 
		DBMS_OUTPUT.PUT_LINE(NUM || 'IS AN ODD NUMBER');
	END IF;
	DBMS_OUTPUT.PUT_LINE('SUCCESSFUL!');
END;
/

-----------------------------------------------------------------------

DECLARE 
	NUM NUMBER(2);
BEGIN	
	NUM := &NUM_IN;
	IF MOD(NUM, 2) = 0 THEN 
		DBMS_OUTPUT.PUT_LINE(NUM || 'IS AN EVEN NUMBER');
	ELSE 
		DBMS_OUTPUT.PUT_LINE(NUM || 'IS AN ODD NUMBER');
	END IF;
	DBMS_OUTPUT.PUT_LINE('SUCCESSFUL!');
	EXCEPTION 
		WHEN VALUE_ERROR THEN
			DBMS_OUTPUT.PUT_LINE('DATA AREA IS TOO SMALL.');
END;
/
	
-----------------------------------------------------------------------

DECLARE 
	NUM NUMBER(2);
BEGIN	
	NUM := &NUM_IN;
	IF MOD(NUM, 2) = 0 THEN 
		DBMS_OUTPUT.PUT_LINE(NUM || 'IS AN EVEN NUMBER');
	ELSE 
		DBMS_OUTPUT.PUT_LINE(NUM || 'IS AN ODD NUMBER');
	END IF;
	DBMS_OUTPUT.PUT_LINE('SUCCESSFUL!');
	EXCEPTION 
		WHEN OTHERS THEN
			DBMS_OUTPUT.PUT_LINE('SOME ERROR HAS OCCURED.');
END;
/

-----------------------------------------------------------------------

--Looping 

DECLARE
	VAL CONSTANT NUMBER(2) := 99;
	IN_DATE NUMBER(3) := &USER_INPUT;
	OUT_DATA NUMBER(5);
BEGIN 
	OUT_DATA := IN_DATA + VAL;
	DBMS_OUTPUT.PUT_LINE('MAGIC NUMBER: ' || OUT_DATA);
END;
/

--ERROR!

-----------------------------------------------------------------------

DESC EMPLOYEE

--TO DISPLAY CONTENTS OF EMPLOYEE TABLE (ENO, FNAME)

DECLARE
	V_ENO NUMBER(4);
	V_FNAME VARCHAR2(10);
	V_KNT NUMBER(2) := 1;
BEGIN
	LOOP
		SELECT ENO, FNAME
			INTO V_ENO, V_FNAME
			FROM EMPLOYEE
			WHERE ENO = (V_KNT + 7100);
		DBMS_OUTPUT.PUT_LINE(V_ENO || ' '|| V_FNAME);
		V_KNT := V_KNT + 1;
		EXIT WHEN V_KNT > 17;
	END LOOP;
	DBMS_OUTPUT.PUT_LINE(V_KNT-1 ||' ROWS SELECTED');
END;
/

-----------------------------------------------------------------------

DECLARE
	V_ENO NUMBER(4);
	V_FNAME VARCHAR2(10);
	V_KNT NUMBER(2) := 1;
BEGIN
	LOOP
		SELECT ENO, FNAME
			INTO V_ENO, V_FNAME
			FROM EMPLOYEE
			WHERE ENO = (V_KNT + 7100);
		DBMS_OUTPUT.PUT_LINE(RPAD(V_KNT,2)||' '||V_ENO||' '||V_FNAME);
		V_KNT := V_KNT + 1;
		EXIT WHEN V_KNT > 17;
	END LOOP;
	DBMS_OUTPUT.PUT_LINE(V_KNT-1 ||' ROWS SELECTED');
END;
/

-----------------------------------------------------------------------

SELECT SALARY, ENO FROM EMPLOYEE WHERE SALARY = 30000;

-- NAME THE PERSON WHO HAS SALARY 30000

DECLARE
	V_NAME EMPLOYEE,FNAME%TYPE;
BEGIN
	SELECT FNAME INTO V_NAME
		FROM EMPLOYEE WHERE 