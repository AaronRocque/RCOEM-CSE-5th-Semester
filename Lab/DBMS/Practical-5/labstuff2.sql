/*

14-November-2022

Rotine and Co-Routine
It is a block of code that can revert exactly one value or more than one VALUE

These blocks are called as FUNCTIONS
In Fortran, it is called SUBROUTINE
In Pascal, it is called PROCEDURE

In function you have RETURN VALUE, Procedure have NO RETURN VALUE.

SHOW ERRORS -> It tells you errors of the block

*/

----------------------------------------------------------------------------

--Function to find AREA of a circle

SET SERVEROUTPUT ON

CREATE OR REPLACE FUNCTION AREA (RADIUS NUMBER)
	RETURN NUMBER IS
		V_AREA NUMBER;
	BEGIN 
		V_AREA := (22/7) * RADIUS * RADIUS;
		RETURN V_AREA;
	END;
/

SELECT OBJECT_NAME, OBJECT_TYPE
	FROM USER_OBJECTS
	WHERE OBJECT_TYPE = 'FUNCTION';
	
COLUMN OBJECT_NAME FOR A20
COLUMN OBJECT_TYPE FOR A15
/

DESC USER_SOURCE

COLUMN NAME FOR A10
COLUMN TYPE FOR A10
COLUMN LINE HEADING "LN" FOR 99
COLUMN TEXT FOR A50
--LN = LINE

SELECT LINE, TYPE, NAME, TEXT 
	FROM USER_SOURCE 
	WHERE NAME = 'AREA';


SELECT AREA(7) AS AREA
	FROM DUAL;
	
DECLARE
	RAD NUMBER(1) := &RADIUS;
	AR NUMBER(5,1);
	BEGIN
		AR := AREA(RAD);
		DBMS_OUTPUT.PUT_LINE('Area('||rad||'):= '||ar);
	end;
/

----------------------------------------------------------------------------

--PROCEDURE for Circumference of circle

CREATE OR REPLACE PROCEDURE CIRCLE (
		RADIUS NUMBER,
		V_AREA OUT NUMBER,
		V_PERIM OUT NUMBER)
	AS 
	BEGIN
		V_AREA := AREA(RADIUS);
		V_PERIM := (22/7) * 2 * RADIUS;
	END;
/

DECLARE 
	RAD NUMBER := &RADIUS_OF_CIRCLE;
	AR NUMBER;
	PR NUMBER;
	BEGIN
		CIRCLE(RAD, AR, PR);
		DBMS_OUTPUT.PUT_LINE('RADIUS := ' ||RAD);
		DBMS_OUTPUT.PUT_LINE('AREA := ' ||AR);
		DBMS_OUTPUT.PUT_LINE('PERIMETER := ' ||PR);
	END;
/	
----------------------------------------------------------------------------
SET PAGESIZE 50
SET LINESIZE 200
COLUMN EMAIL FOR A18


CREATE OR REPLACE FUNCTION NUM_OF_PERSONS
     RETURN NUMBER AS 
	     KOUNT NUMBER;
	BEGIN  
	     SELECT COUNT(*) INTO KOUNT 
		     FROM PERSON;
		RETURN KOUNT;
    END;
/


SELECT NUM_OF_PERSONS FROM DUAL;

----------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION PERSONS_WITH_NAMES(NAME PERSON.LNAME%TYPE)
	RETURN NUMBER AS
		KOUNT NUMBER;
	BEGIN
		SELECT COUNT(*) INTO KOUNT
		FROM PERSON 
		WHERE UPPER(LNAME) = UPPER(LNAME);
	RETURN KOUNT;
END;
/

SELECT PERSONS_WITH_NAMES('Rocque') FROM DUAL;




	
----------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE PERSON_PARTICULARS(
                PNO PERSON.AADHARNO%TYPE,
				NAME OUT PERSON.LNAME%TYPE,
				PAY OUT PERSON.PINCODE%TYPE)
	AS
	BEGIN
	    SELECT AADHARNO, PINCODE INTO NAME, PAY
		     FROM PERSON
			 WHERE AADHARNO=PNO;
		DBMS_OUTPUT.PUT_LINE(RPAD(PNO,4)||' '||RPAD(NAME,25)||' '||PAY);
	EXCEPTION 
	    WHEN NO_DATA_FOUND THEN
		     NAME := ' ';
			 PAY := 0;
			 DBMS_OUTPUT.PUT_LINE('PERSON DOES NOT EXIST...');
		WHEN OTHERS THEN
		     DBMS_OUTPUT.PUT_LINE('SOME ERROR OCCURED...');
	END;
/


CREATE OR REPLACE PROCEDURE JUST_SHOW
    AS 
	     V_NAME PERSON.LNAME%TYPE;
		 V_SAL PERSON.PINCODE%TYPE;
	     V_PID PERSON.AADHARNO%TYPE :=&PERSON_ID;
	BEGIN 
	     PERSON_PARTICULARS( V_PID, V_NAME, V_SAL);
		 DBMS_OUTPUT.PUT_LINE(V_PID||' '||RPAD(V_NAME,15)||' '|| LPAD(V_SAL,10));
	END;
/
			
	
----------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION HOW_MANY_ROWS(TNAME VARCHAR)
	RETURN NUMBER AS
		KNT NUMBER;
	BEGIN 
		SELECT COUNT(TABLE_NAME) INTO KNT	
			FROM USER_TABLES
			WHERE TABLE_NAME = UPPER(TNAME);
		IF KNT = 0 THEN
			DBMS_OUTPUT.PUT_LINE('TABLE/VIEW DOES NOT EXIST');
			RETURN -1;
		ELSE
			BEGIN
				SELECT COUNT(*) INTO KNT
					FROM TNAME;
				IF KNT = 0 THEN
					RETURN 0;
				ELSE
					RETURN KNT;
				END IF;
			END;
		END IF;
		DBMS_OUTPUT.PUT_LINE('.....OK.....');
	END;
/
----------------------------------------------------------------------------

--DECLARE BIND VARIABLES

VAR V_NAME VARCHAR2(15)
VAR V_SALARY NUMBER

EXEC PERSON_PARTICULARS(111, :V_NAME, :V_SALARY);
EXEC JUST_SHOW;
----------------------------------------------------------------------------

----------------------------------------------------------------------------

----------------------------------------------------------------------------

----------------------------------------------------------------------------

----------------------------------------------------------------------------

----------------------------------------------------------------------------

----------------------------------------------------------------------------

