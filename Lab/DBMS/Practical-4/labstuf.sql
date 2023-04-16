column descript format a20 wrap
column qty format 9999
column pmin format 9999
column p_min format 9999
column p_disc format 9999
column v_name format a20
SET PAGESIZE 50;


SELECT * FROM CUSTOMER;
SELECT * FROM INVOICE;
SELECT * FROM LINE;
SELECT * FROM PRODUCT;
SELECT * FROM VENDOR;

SELECT <attribute_list>
	FROM <operand relations>
	[WHERE <filtering predicate for each row>]
	[GROUP BY <aggregate functions>]
	[HAVING <filtering predicate for groups>]
	[ORDER BY <sequence on some field>]
-- [] means optional stuff

CREATE VIEW SOME_VW AS --Querey 
	SELECT P_CODE, DESCRIPT AS PARTICULARS, V_CODE AS SUPPLIER --Sub Querey
	FROM PRODUCT 
	WHERE V_CODE IS NOT NULL;
	
SELECT COUNT(*) FROM PRODUCT; --19
SELECT COUNT(*) FROM VENDOR; --12
SELECT COUNT(*) FROM INVOICE; --9
SELECT COUNT(*) FROM LINE; --19
SELECT COUNT(*) FROM CUSTOMER; --11

--If you dont want to populate table in the beginning
CREATE OR REPLACE VIEW SOME_VW AS --Querey 
	SELECT P_CODE, DESCRIPT AS PARTICULARS, V_CODE AS SUPPLIER --Sub Querey
	FROM PRODUCT 
	WHERE 1=2; --Condition that is always false
	
SELECT COUNT(*) FROM SOME_VW;

---------------------------------------------------------------------------------

--Print names of vendors who supplied some HAMMER
--PRODUCT & VENDOR NEEDED

--Gives error... cause of V_CODE in first line, don't know which V_CODE to use?
SELECT P_CODE, DESCRIPT, V_CODE, V_NAME
	FROM PRODUCT JOIN VENDOR
	ON PRODUCT.V_CODE = VENDOR.V_CODE;
	
SELECT P_CODE, DESCRIPT, PRODUCT.V_CODE, V_NAME
	FROM PRODUCT JOIN VENDOR
	ON PRODUCT.V_CODE = VENDOR.V_CODE
	AND UPPER(DESCRIPT) LIKE '%HAMMER%';

--OR

SELECT P_CODE, DESCRIPT, V_CODE, V_NAME
	FROM PRODUCT JOIN VENDOR
	USING(V_CODE)
	WHERE UPPER(DESCRIPT) LIKE '%HAMMER%';
	
--OR

SELECT V_CODE, V_NAME
	FROM VENDOR JOIN PRODUCT 
	USING (V_CODE)
	WHERE UPPER(DESCRIPT) LIKE '%HAMMER%';
	
--Writing same querey without JOIN
	
SELECT V_CODE, V_NAME
	FROM VENDOR
	WHERE V_CODE IN 
		(SELECT V_CODE --Where clause sub querey 
			FROM PRODUCT 
				WHERE UPPER(DESCRIPT) LIKE '%HAMMER%');
	
SELECT DESCRIPT, V_NAME
	FROM (SELECT V_CODE, DESCRIPT FROM PRODUCT) JOIN 
		 (SELECT * FROM VENDOR WHERE V_CODE IS NOT NULL)
	USING (V_CODE);
	
------------------------------------------------------------------

--Print average balance for customer as TOT_BALANCE

SELECT INV_NUM, C_CODE, 
		(SELECT SUM(BALANCE) FROM CUSTOMER) --Attribute list sub querey
	FROM INVOICE;
	
--Hierarchical querey



