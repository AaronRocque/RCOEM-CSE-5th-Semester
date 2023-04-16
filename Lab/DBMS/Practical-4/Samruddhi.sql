--subquery
--general structure of select statement
SELECT<attributelist>
  from <operand relations>
  [WHERE <filtering predicate for each row>]
  [GROUP BY <aggregate functions >]
  [HAVING <filtering predicate for groups>]
  [ORDER BY <sequence on some field>]
 
CREATE VIEW SOME_VW AS
  SELECT P_CODE,DESCRIPT AS PARTICULARS,V_CODE AS SUPPLIER--subquery
  FROM PRODUCT
  WHERE V_CODE IS NOT NULL;

View created.

SELECT COUNT(*) FROM PRODUCT;
SELECT COUNT(*) FROM VENDOR;
SELECT COUNT(*) FROM INVOICE;
SELECT COUNT(*) FROM CUSTOMER;
SELECT COUNT(*) FROM LINE;
SELECT COUNT(*) FROM SOME_VW;

--REPLACE WITH  EMPTY VIEW
CREATE OR REPLACE VIEW SOME_VW AS
  SELECT P_CODE,DESCRIPT AS PARTICULARS,V_CODE AS SUPPLIER--subquery
  FROM PRODUCT
  WHERE 1=2;

View created.

SELECT COUNT(*) FROM SOME_VW;

--print names of vendors who have supplied some hammer
--product and vendor tables are required
SELECT P_CODE,DESCRIPT,V_CODE,V_NAME
	FROM PRODUCT JOIN VENDOR 
	ON PRODUCT.V_CODE=VENDOR.V_CODE;
-- V_CODE IN ATTRIBUTE LIST IS AMBIGUOUS
--FIRST SOLUTION
SELECT P_CODE,DESCRIPT,PRODUCT.V_CODE,V_NAME
	FROM PRODUCT JOIN VENDOR 
	ON PRODUCT.V_CODE=VENDOR.V_CODE
	AND
	UPPER(DESCRIPT) LIKE '%HAMMER%';
--SECOND SOLUTION
SELECT P_CODE,DESCRIPT,V_CODE,V_NAME
	FROM PRODUCT JOIN VENDOR 
	USING(V_CODE)
	WHERE UPPER(DESCRIPT) LIKE '%HAMMER%';

P_COD DESCRIPT                           V_CODE V_NAME
----- ------------------------------ ---------- ------------------------------
HW15X HiVeld Hammer                       24992 Indian Masters
CH10X Claw Hammer                         21225 Bryson, Inc.

-- USING WHERE CLAUSE SUBQUERY WITHOUT CP SO MORE FEASIBLE
SELECT V_CODE,V_NAME --INDEPENDENT OF PRODUCT
	FROM  VENDOR 
	WHERE V_CODE IN 
	(SELECT V_CODE FROM PRODUCT --INNER SUBQUERY
			WHERE UPPER(DESCRIPT) LIKE '%HAMMER%');

    V_CODE V_NAME
---------- ------------------------------
     21225 Bryson, Inc.
     24992 Indian Masters

--FROM CLAUSE SUBQUERY
SELECT DISTINCT DESCRIPT,V_NAME
	FROM (SELECT V_CODE,DESCRIPT FROM PRODUCT) JOIN
	(SELECT * FROM VENDOR WHERE V_CODE IS NOT NULL)
	 USING(V_CODE);

DESCRIPT                       V_NAME
------------------------------ ------------------------------
PVC Pipe                       Indian Masters
Claw Hammer                    Bryson, Inc.
Hrd. Spring 1/2in              Blackman Sisters
Jigsaw 8in Blade               Justin Stores
7.25in Saw Blade               Gomez Sons
Jigsaw 12in Blade              Justin Stores
Cordless Drill                 HighEnd Supplies
Steel Malting Mesh             HighEnd Supplies
Power Drill                    HighEnd Supplies
HiVeld Hammer                  Indian Masters
Metal Screw                    Bryson, Inc.

DESCRIPT                       V_NAME
------------------------------ ------------------------------
2.5in wide Screw               GnB Supply
Rat Tail File                  Gomez Sons
9.00 in Saw Blade              Gomez Sons
Hrd. Spring 1/4in              Blackman Sisters
Power Drill                    Indian Masters
Hicut Chain Saw                Justin Stores

17 rows selected.

--ATTRIBUTE LIST QUERY
--PRINT AVERAGE BALANCE FOR CUSTOMER AS TOT_BALANCE
SELECT C_CODE,INV_NUM,(SELECT SUM(BALANCE) FROM CUSTOMER) AS TOT_BAL
	FROM INVOICE;


    C_CODE    INV_NUM    TOT_BAL
---------- ---------- ----------
     10014       1001    2589.28
     10011       1002    2589.28
     10012       1003    2589.28
     10018       1004    2589.28
     10011       1005    2589.28
     10014       1006    2589.28
     10015       1007    2589.28
     10011       1008    2589.28
     10020       1009    2589.28

9 rows selected.

=====QUERY01=====
CREATE TABLE PART AS
  SELECT P_CODE AS PT_CODE,DESCRIPT AS PT_DESC,P_PRICE AS PT_PRICE,V_CODE
  FROM PRODUCT
  WHERE 1=2;

Table created.

--POPULATE PART TABLE WITH CONTENTS OF PRODUCT
INSERT INTO PART
	SELECT P_CODE,DESCRIPT,P_PRICE,V_CODE
	FROM PRODUCT;

19 rows created.


DESC PRODUCT;
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 P_CODE                                    NOT NULL CHAR(5)
 DESCRIPT                                  NOT NULL VARCHAR2(30)
 P_DATE                                    NOT NULL DATE
 QTY                                       NOT NULL NUMBER(4)
 P_MIN                                     NOT NULL NUMBER(3)
 P_PRICE                                   NOT NULL NUMBER(6,2)
 P_DISC                                    NOT NULL NUMBER(2,2)
 V_CODE                                             NUMBER(5)


DESC PART;

Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 PT_CODE                                   NOT NULL CHAR(5)
 PT_DESC                                   NOT NULL VARCHAR2(30)
 PT_PRICE                                  NOT NULL NUMBER(6,2)
 V_CODE                                             NUMBER(5)

SELECT TABLE_NAME,CONSTRAINT_NAME,CONSTRAINT_TYPE
      ,DELETE_RULE
      FROM USER_CONSTRAINTS
      WHERE TABLE_NAME IN ('PART');

TABLE_NAME                     CONSTRAINT_NAME                C DELETE_RU
------------------------------ ------------------------------ - ---------
PART                           SYS_C0012067                   C
PART                           SYS_C0012068                   C
PART                           SYS_C0012069                   C

--EI AND RI CONSTRAINTS ARE NOT COPIED INTO NEW TABLE only checked constraints are copied
--SELECT PART-19 ROWS
=====QUERY-02=====
--what is actually asked in question
SELECT DISTINCT V_CODE FROM PART--PRODUCT
	WHERE V_CODE IS NOT NULL;

 V_CODE
----------
     25595
     23119
     24992
     21231
     21225
     24288
     21344

7 rows selected.
--to get expected output :(
SELECT  V_CODE FROM PART--PRODUCT
	WHERE V_CODE IS NOT NULL;
 V_CODE
----------
     24992
     24992
     24992
     25595
     21344
     21344
     23119
     23119
     24288
     24288
     25595
     21225
     21344
     24288
     21225
     21231
     25595

17 rows selected.

SET PAGESIZE 30

SELECT  V_CODE,V_NAME,P_CODE,P_PRICE,QTY 
	FROM VENDOR 
	JOIN PRODUCT USING(V_CODE)
	WHERE QTY>10
	;

    V_CODE V_NAME                         P_COD    P_PRICE        QTY
---------- ------------------------------ ----- ---------- ----------
     21225 Bryson, Inc.                   CH10X       9.95         23
     21225 Bryson, Inc.                   MC001       6.99        172
     21231 GnB Supply                     WC025       8.45        237
     21344 Gomez Sons                     RF100       4.99         43
     21344 Gomez Sons                     SB725      14.99         32
     21344 Gomez Sons                     SB900      17.49         18
     23119 Blackman Sisters               CL025      39.95         15
     23119 Blackman Sisters               CL050      43.99         23
     24288 Justin Stores                  HC100     256.99         11
     24992 Indian Masters                 PP102      15.25         50
     24992 Indian Masters                 AB111        125         15
     24992 Indian Masters                 HW15X       17.5         60
     25595 HighEnd Supplies               SM48X     119.95         18
     25595 HighEnd Supplies               CD00X      38.95         12

14 rows selected.


=====QUERY-03=====
--FROM CLAUSE SUB QUERY
--expected is this solution only not the second
SELECT DISTINCT P_CODE,DESCRIPT,P_PRICE AS PRICE
FROM PRODUCT
WHERE P_PRICE=(SELECT MAX(P_PRICE) FROM PRODUCT)
UNION
SELECT DISTINCT P_CODE,DESCRIPT,P_PRICE AS PRICE
FROM PRODUCT
WHERE P_PRICE=(SELECT MIN(P_PRICE) FROM PRODUCT)
;

P_COD DESCRIPT                            PRICE
----- ------------------------------ ----------
HC100 Hicut Chain Saw                    256.99
RF100 Rat Tail File                        4.99

--second solution

SELECT * FROM 
(SELECT DISTINCT P_CODE,DESCRIPT,P_PRICE AS PRICE
FROM PRODUCT
WHERE P_PRICE=(SELECT MAX(P_PRICE) FROM PRODUCT)
UNION
SELECT DISTINCT P_CODE,DESCRIPT,P_PRICE AS PRICE
FROM PRODUCT
WHERE P_PRICE=(SELECT MIN(P_PRICE) FROM PRODUCT)
)
ORDER BY PRICE;

P_COD DESCRIPT                            PRICE
----- ------------------------------ ----------
RF100 Rat Tail File                        4.99
HC100 Hicut Chain Saw                    256.99


--PART B 
--:(
SELECT P_CODE,DESCRIPT,(L_UNITS*L_PRICE) AS INV_VAL
FROM PRODUCT NATURAL JOIN 
=====QUERY-04=====
COLUMN  DESCRIPT FORMAT A20;
COLUMN QTY  FORMAT 999;
COLUMN P_MIN  FORMAT 999;
COLUMN P_DISC  FORMAT 99999;

SELECT * FROM PRODUCT
WHERE P_PRICE > (SELECT AVG(P_PRICE) FROM PRODUCT);

P_COD DESCRIPT             P_DATE     QTY P_MIN    P_PRICE P_DISC     V_CODE
----- -------------------- --------- ---- ----- ---------- ------ ----------
AB111 Power Drill          18-SEP-22   15     5        125      0      24992
AB112 Power Drill          03-NOV-19    8     5     109.99      0      25595
JB012 Jigsaw 12in Blade    30-DEC-19    8     5     109.92      0      24288
JB008 Jigsaw 8in Blade     24-DEC-19    6     5      99.87      0      24288
HC100 Hicut Chain Saw      07-FEB-20   11     5     256.99      0      24288
SM48X Steel Malting Mesh   17-JAN-20   18     5     119.95      0      25595

6 rows selected.

--NUMBER OF PRODUCTS SUPPLIED BY EACH VENDOR
SELECT V_CODE,COUNT(*) FROM PRODUCT GROUP BY (V_CODE)
HAVING V_CODE IS NOT NULL;

 V_CODE   COUNT(*)
---------- ----------
     25595          3
     23119          2
     24992          3
     21231          1
     21225          2
     24288          3
     21344          3

7 rows selected.
--CHECK IF ABOVE QUERY IS CORRECT:(

=====QUERY-05=====
SELECT V_CODE,COUNT(*) FROM PRODUCT GROUP BY(V_CODE)
HAVING (SELECT AVG(P_PRICE) FROM PRODUCT ) <10;
--:(
SELECT COUNT(*) FROM PRODUCT P INNER JOIN
(SELECT V_CODE FROM PRODUCT GROUP BY(V_CODE)
 HAVING AVG(P_PRICE)<10) S 
 WHERE P.V_CODE=S.V_CODE;
 
 
 
--RIYA WILL SEND
SELECT COUNT(*),V_CODE FROM PRODUCT GROUP BY(V_CODE) 
HAVING AVG(P_PRICE)<10;

 COUNT(*)     V_CODE
---------- ----------
         1      21231
         2      21225

--SELECT COUNT(*),V_CODE ,SUM(P_PRICE) AS TOT_COST FROM PRODUCT GROUP BY(V_CODE) 
--HAVING SUM(P_PRICE)>400.00 
--ORDER BY (V_CODE) DESC;	 

 --COUNT(*)     V_CODE   TOT_COST
------------ ---------- ----------
--         3      24288     466.78
		 
SELECT V_CODE, SUM(P_PRICE*QTY) AS TOT_COST FROM PRODUCT 
WHERE V_CODE IS NOT NULL
GROUP BY V_CODE HAVING SUM(P_PRICE*QTY)>400
ORDER BY TOT_COST ASC;

    V_CODE   TOT_COST
---------- ----------
     21344    1009.07
     21225    1431.13
     21231    2002.65
     23119    2121.16
     25595    2121.16
     24992     3687.5
     24288    4305.47

7 rows selected.
=====QUERY-06=====
CREATE OR REPLACE VIEW PRODUCT_STATS AS
SELECT V_CODE, SUM(P_PRICE) AS TOT_COST ,MAX(QTY) AS MX_QTY,MIN(QTY) AS MN_QTY
,AVG(QTY) AS AV_QTY
FROM PRODUCT GROUP BY(V_CODE) HAVING V_CODE IS NOT NULL;

View created.

SELECT * FROM PRODUCT_STATS;

 
    V_CODE   TOT_COST     MX_QTY     MN_QTY     AV_QTY
---------- ---------- ---------- ---------- ----------
     25595     268.89         18          8 12.6666667
     23119      83.94         23         15         19
     24992     157.75         60         15 41.6666667
     21231       8.45        237        237        237
     21225      16.94        172         23       97.5
     24288     466.78         11          6 8.33333333
     21344      37.47         43         18         31

7 rows selected.

=====QUERY-07=====
--CONCAT does not work in group BY
--BELOW QUERY DOESNT WORK :(
SELECT  C_CODE,BALANCE,SUM(L_UNITS*L_PRICE) AS SUM_PURCHASE FROM
CUSTOMER  NATURAL JOIN INVOICE  NATURAL JOIN LINE 
GROUP BY (C_CODE);

--SECOND APPROACH
--HOW  TO PRINT BALANCE?
SELECT DISTINCT C_CODE,SUM(TOT_PUR) AS AGG_PUR FROM 
(SELECT C_CODE,INV_NUM,L_UNITS*L_PRICE AS TOT_PUR 
FROM LINE NATURAL JOIN INVOICE) NATURAL JOIN CUSTOMER
GROUP BY(C_CODE);

C_CODE    AGG_PUR
---------- ----------
     10015      34.97
     10014     422.77
     10011     479.57
     10012     153.85
     10018      34.87
     10020        350

6 rows selected.

--SIR SOLUTION
SELECT C_CODE,LNAME,FNAME,TOT_INV,BALANCE 
FROM CUSTOMER NATURAL JOIN(
	SELECT C_CODE,SUM(TOT_LINE)TOT_INV
	FROM INVOICE NATURAL JOIN (
		SELECT INV_NUM,SUM(L_UNITS*L_PRICE) TOT_LINE
			FROM LINE
			GROUP BY INV_NUM)TT
	GROUP BY C_CODE
	)
ORDER BY C_CODE;

    C_CODE LNAME      FNAME         TOT_INV    BALANCE
---------- ---------- ---------- ---------- ----------
     10011 Johnson    Elena          479.57          0
     10012 Smith      Kathy          153.85     345.86
     10014 Johnson    Bill           422.77          0
     10015 Samuels    Julia           34.97          0
     10018 Lee        Ming            34.87     216.55
     10020 Samruddhi  Tatiwar           350        500

6 rows selected.
=====QUERY-08=====
SELECT DISTINCT C_CODE,SUM(TOT_PUR) AS AGG_PUR,COUNT(L_NUM) AS NUM_PUR FROM 
(SELECT C_CODE,INV_NUM,L_UNITS*L_PRICE AS TOT_PUR ,L_NUM
FROM LINE NATURAL JOIN INVOICE) NATURAL JOIN CUSTOMER
GROUP BY(C_CODE);

  C_CODE    AGG_PUR    NUM_PUR
---------- ---------- ----------
     10015      34.97          2
     10014     422.77          6
     10011     479.57          5
     10012     153.85          3
     10018      34.87          2
     10020        350          1

6 rows selected.

=====QUERY-09=====
--A
SELECT INV_NUM ,SUM(L_UNITS*L_PRICE)FROM LINE GROUP BY(INV_NUM);

--B 
SELECT C_CODE,SUM(L_UNITS*L_PRICE) FROM 
INVOICE NATURAL JOIN LINE
GROUP BY(C_CODE);

 C_CODE SUM(L_UNITS*L_PRICE)
---------- --------------------
     10015                34.97
     10014               422.77
     10011               479.57
     10012               153.85
     10018                34.87
     10020                  350

6 rows selected.

--C 
SELECT C_CODE,COUNT(INV_NUM) ,SUM(L_UNITS*L_PRICE) FROM
LINE NATURAL JOIN INVOICE 
 GROUP BY(C_CODE);
 --:(
 
=====QUERY-10===== 
SELECT C_CODE,BALANCE FROM CUSTOMER  
WHERE C_CODE  NOT IN
(SELECT DISTINCT C_CODE FROM INVOICE);

  C_CODE    BALANCE
---------- ----------
     10010          0
     10013     536.75
     10016     221.19
     10017     768.93
     10019          0

SELECT MAX(BALANCE) AS MAX_BAL,MIN(BALANCE) AS MIN_BAL,
AVG(BALANCE) AS AVG_BAL
FROM CUSTOMER  
WHERE C_CODE IN
(SELECT DISTINCT C_CODE FROM INVOICE);

MAX_BAL    MIN_BAL    AVG_BAL
---------- ---------- ----------
       500          0 177.068333
	   
=====QUERY-11===== 
CREATE TABLE INV_CUSTOMER AS
(SELECT INV_NUM AS QUOTE_ID,INV_DATE AS QUOTE_DT, FNAME|| ' '||LNAME AS C_NAME
FROM CUSTOMER NATURAL JOIN INVOICE
WHERE 1=2)
;

Table created.

--ENSURING THAT TABLE IS EMPTY
SELECT * FROM INV_CUSTOMER;
no rows selected

ALTER TABLE INV_CUSTOMER
ADD CONSTRAINT INV_CUS_PK PRIMARY KEY(QUOTE_ID);

Table altered.

--Checking if constraint is enforced
SELECT TABLE_NAME,CONSTRAINT_NAME,CONSTRAINT_TYPE,DELETE_RULE
	FROM USER_CONSTRAINTS
	WHERE TABLE_NAME='INV_CUSTOMER'
	AND 
	CONSTRAINT_TYPE='P'
	;


TABLE_NAME                     CONSTRAINT_NAME                C DELETE_RU
------------------------------ ------------------------------ - ---------
INV_CUSTOMER                   INV_CUS_PK                     P


--INSERT INTO table_name [ (column1 [, column2 ]) ]
-- SELECT [ *|column1 [, column2 ]
--FROM table1 [, table2 ]
--[ WHERE VALUE OPERATOR ]

INSERT INTO INV_CUSTOMER
SELECT INV_NUM AS QUOTE_ID,INV_DATE AS QUOTE_DT,FNAME|| ' '||LNAME AS C_NAME
FROM CUSTOMER NATURAL JOIN INVOICE;

9 rows created.

=====QUERY-12=====
CREATE OR REPLACE VIEW INV_CUSTOMER_VW AS
SELECT  QUOTE_ID, QUOTE_DT, C_NAME
FROM INV_CUSTOMER
WHERE 1=2;

View created.
--CHECKING IF TABLE IS EMPTY
SELECT * FROM INV_CUSTOMER_VW;

no rows selected
--TRYING TO POPULATE THE VIEW
INSERT INTO INV_CUSTOMER_VW
SELECT QUOTE_ID,QUOTE_DT,C_NAME
FROM INV_CUSTOMER;

ERROR at line 1:
ORA-00001: unique constraint (CS5A20.INV_CUS_PK) violated
--actual query
INSERT INTO INV_CUSTOMER_VW
	(SELECT INV_NUM, INV_DATE,I.C_CODE           
	FROM INVOICE I INNER JOIN CUSTOMER C ON C.C_CODE=I.C_CODE
	);
ERROR at line 1:
ORA-01733: virtual column not allowed here
--
DROP VIEW INV_CUSTOMER_VW;

View dropped.
--CREATING AND POPULATING AT THE SAME TIME
CREATE OR REPLACE VIEW INV_CUSTOMER_VW AS
SELECT  QUOTE_ID, QUOTE_DT, C_NAME
FROM INV_CUSTOMER
;
View created.

DESC INV_CUSTOMER_VW;

SELECT * FROM INV_CUSTOMER_VW;

  QUOTE_ID QUOTE_DT  C_NAME
---------- --------- ---------------------
      1005 17-JAN-20 Elena Johnson
      1008 17-JAN-20 Elena Johnson
      1002 16-JAN-20 Elena Johnson
      1003 16-JAN-20 Kathy Smith
      1006 17-JAN-20 Bill Johnson
      1001 16-JAN-20 Bill Johnson
      1007 17-JAN-20 Julia Samuels
      1004 17-JAN-20 Ming Lee
      1009 10-JAN-20 Tatiwar Samruddhi

9 rows selected.

INSERT INTO INV_CUSTOMER_VW VALUES(1011,'12-Mar-2020','Jagat Narayan');
1 row created.
--ACTUAL QUERYINSERT INTO INV_CUSTOMER_VW VALUES(1011, 'Jagat Narayan', 12-Mar-2020);

ERROR at line 1:
ORA-00984: column not allowed here

--p_code,desc,p_date,qty,p_min,p_price,p_disc,v_code
INSERT INTO PRODUCT
VALUES('SH200','Sledge Hammer','05-Jul-2020',10,3,25.8,0,NULL);
1 row created.

INSERT INTO PRODUCT
VALUES('ZZ999','Cordless Drill','10-Jul-2020',200,40,25.5,0,24992);
1 row created.

INSERT INTO PRODUCT
VALUES('AB212','Power Drill','03-Aug-2020',15,3,275.0,0,24992);
1 row created.

=====QUERY-13=====

SELECT V_CODE,V_NAME FROM VENDOR 
WHERE V_CODE IN ( SELECT DISTINCT V_CODE FROM PRODUCT WHERE V_CODE IS NOT NULL
  );

 V_CODE V_NAME
---------- ------------------------------
     21225 Bryson, Inc.
     21231 GnB Supply
     21344 Gomez Sons
     23119 Blackman Sisters
     24288 Justin Stores
     24992 Indian Masters
     25595 HighEnd Supplies

7 rows selected.

=====QUERY-14=====
--CHECKING AVG OF ALL PRODUCTS
SELECT AVG(P_PRICE) FROM PRODUCT;

AVG(P_PRICE)
------------
  55.8152632

select count(p_code) from product; --yaha 22 aana chahiye
COUNT(P_CODE)
-------------
           19
		   
--COUNT OF PRODUCTS WITH SAME NAME
SELECT DESCRIPT,COUNT(*) FROM PRODUCT GROUP BY (DESCRIPT);

DESCRIPT                         COUNT(*)
------------------------------ ----------
Hrd. Spring 1/4in                       1
Hicut Chain Saw                         1
7.25in Saw Blade                        1
9.00 in Saw Blade                       1
Hrd. Spring 1/2in                       1
Jigsaw 12in Blade                       1
Jigsaw 8in Blade                        1
Metal Screw                             1
2.5in wide Screw                        1
Rat Tail File                           1
PVC Pipe                                2
Sledge Hammer                           1
HiVeld Hammer                           1
Power Drill                             2
Claw Hammer                             1
Steel Malting Mesh                      1
Cordless Drill                          1

17 rows selected.

--OR

select descript,count(p_code) from product
group by(descript) having count(p_code)>0;

DESCRIPT                       COUNT(P_CODE)
------------------------------ -------------
Hrd. Spring 1/4in                          1
Hicut Chain Saw                            1
7.25in Saw Blade                           1
9.00 in Saw Blade                          1
Hrd. Spring 1/2in                          1
Jigsaw 12in Blade                          1
Jigsaw 8in Blade                           1
Metal Screw                                1
2.5in wide Screw                           1
Rat Tail File                              1
PVC Pipe                                   2
Sledge Hammer                              1
HiVeld Hammer                              1
Power Drill                                2
Claw Hammer                                1
Steel Malting Mesh                         1
Cordless Drill                             1

17 rows selected.

=====QUERY-15=====
SELECT P_CODE,DESCRIPT,P_PRICE FROM PRODUCT
WHERE P_PRICE >= (SELECT AVG(P_PRICE) FROM PRODUCT);

P_COD DESCRIPT                          P_PRICE
----- ------------------------------ ----------
AB111 Power Drill                           125
AB112 Power Drill                        109.99
JB012 Jigsaw 12in Blade                  109.92
JB008 Jigsaw 8in Blade                    99.87
HC100 Hicut Chain Saw                    256.99
SM48X Steel Malting Mesh                 119.95

6 rows selected.
--7 AANI CAHIYE:(


=====QUERY-16=====
SELECT V_CODE,V_NAME,V_CONTACT FROM VENDOR 
WHERE V_CODE NOT IN ( SELECT DISTINCT V_CODE FROM PRODUCT 
WHERE V_CODE IS NOT NULL);

 V_CODE V_NAME                         V_CONTACT
---------- ------------------------------ --------------------
     21226 SuperLoo, Inc.                 Ching Ming
     22587 Downing, Inc.                  Simon Singh
     24004 Almeda House                   Almeda Brown
     25443 Super Systems                  Ted Hwang
     25501 Silvermines Ltd.               Anne White

=====QUERY-17=====
UPDATE PRODUCT
SET P_PRICE =(SELECT AVG(P_PRICE) FROM PRODUCT)
WHERE V_CODE IN
(SELECT V_CODE FROM VENDOR WHERE V_STATE NOT IN ('TN','KY'));

5 rows updated.

INSERT INTO LINE VALUES(1003,4,'ZZ999',10,25.5);
1 row created.

select * from line;

 INV_NUM      L_NUM P_COD    L_UNITS    L_PRICE
---------- ---------- ----- ---------- ----------
      1009          1 HW15X         20       17.5
      1001          1 SB725          1      14.99
      1001          2 CH10X          1       9.95
      1002          1 RF100          2       4.99
      1003          1 CD00X          1      38.95
      1003          2 CD00X          1      39.95
      1003          3 SB725          5      14.99
      1004          1 RF100          3       4.99
      1004          2 CH10X          2       9.95
      1005          1 PP101         12       5.87
      1006          1 MC001          3       6.99
      1006          2 JB012          1     109.92
      1006          3 CH10X          1       9.95
      1006          4 HC100          1     256.99
      1007          1 SB725          2      14.99
      1007          2 RF100          1       4.99
      1008          1 PP101          5       5.87
      1008          2 SM48X          3     119.95
      1008          3 CH10X          1       9.95
      1003          4 ZZ999         10       25.5

20 rows selected.

=====QUERY-18=====
--PART A
SELECT DISTINCT C_CODE,FNAME,LNAME FROM CUSTOMER 
	WHERE C_CODE IN
		(SELECT C_CODE FROM INVOICE
			WHERE INV_NUM IN 
				(SELECT INV_NUM FROM LINE 
					WHERE P_CODE IN
					(SELECT P_CODE FROM PRODUCT WHERE 
					UPPER(DESCRIPT) LIKE '%BLADE%')
		         )
        );

 C_CODE FNAME      LNAME
---------- ---------- ----------
     10015 Julia      Samuels
     10014 Bill       Johnson
     10012 Kathy      Smith
	 
--PART B 
SELECT C_CODE ,FNAME,LNAME FROM CUSTOMER WHERE
C_CODE IN 
(SELECT C_CODE FROM INVOICE WHERE INV_NUM IN 
	(SELECT INV_NUM FROM LINE 
		WHERE P_CODE IN
		(SELECT P_CODE FROM PRODUCT WHERE DESCRIPT='Power Drill')
	)
);

no rows selected

=====QUERY-19=====
SELECT C_CODE,FNAME,LNAME FROM CUSTOMER WHERE C_CODE IN 
(SELECT C_CODE FROM INVOICE 
	WHERE INV_NUM IN
	(SELECT INV_NUM FROM LINE 
		WHERE P_CODE IN
			(SELECT P_CODE FROM PRODUCT WHERE 
			UPPER(DESCRIPT) LIKE '%DRILL%' OR
			UPPER(DESCRIPT) LIKE'%HAMMER%' OR
			UPPER(DESCRIPT) LIKE'%SAW%'
			)
	)
);

    C_CODE FNAME      LNAME
---------- ---------- ----------
     10011 Elena      Johnson
     10012 Kathy      Smith
     10014 Bill       Johnson
     10015 Julia      Samuels
     10018 Ming       Lee
     10020 Tatiwar    Samruddhi

6 rows selected.

=====QUERY-20=====
SELECT P_CODE FROM PRODUCT WHERE
	QTY> (SELECT AVG(QTY) FROM PRODUCT)GROUP BY (P_CODE);

P_COD DESCRIPT
----- ------------------------------
HW15X HiVeld Hammer
PP102 PVC Pipe
PP101 PVC Pipe
MC001 Metal Screw
WC025 2.5in wide Screw

--sir query
--samiksha ko pucho
SELECT SUM(L_UNITS) AS TOTAL_SUM,P_CODE FROM LINE WHERE 
L_UNITS >(SELECT AVG(L_UNITS) FROM LINE)
GROUP BY P_CODE;

=====QUERY-21=====
SELECT C_CODE,FNAME,LNAME FROM CUSTOMER 
	WHERE C_CODE IN 
		(SELECT C_CODE FROM INVOICE 
			WHERE INV_NUM IN
				((SELECT INV_NUM FROM LINE 
				WHERE P_CODE IN
				(SELECT P_CODE FROM PRODUCT WHERE P_CODE IN('HC100' , 'JB012'))
				))
		);

  C_CODE FNAME      LNAME
---------- ---------- ----------
     10014 Bill       Johnson

=====QUERY-22=====

SELECT P_PRICE,AVG(P_PRICE),P_PRICE-AVG(P_PRICE) AS DIFF 
FROM PRODUCT GROUP BY(P_PRICE);

   P_PRICE (SELECTAVG(P_PRICE)FROMPRODUCT)       DIFF
---------- ------------------------------- ----------
    109.99                         54.2995          0
     43.99                         54.2995          0
     38.95                         54.2995          0
    256.99                         54.2995          0
     15.25                         54.2995          0
      17.5                         54.2995          0
     17.49                         54.2995          0
     39.95                         54.2995          0
      4.99                         54.2995          0
      8.45                         54.2995          0
      25.5                         54.2995          0
      5.87                         54.2995          0
       125                         54.2995          0
      9.95                         54.2995          0
      6.99                         54.2995          0
    119.95                         54.2995          0
     99.87                         54.2995          0
      14.4                         54.2995          0
     14.99                         54.2995          0
    109.92                         54.2995          0

20 rows selected.

--FOR ALL ,GROUP BY 
SELECT P_CODE,AVG(P_PRICE),(SELECT (P_PRICE - AVG(P_PRICE)) FROM PRODUCT) 
FROM PRODUCT 
GROUP BY (P_CODE);
--:(

=====QUERY-23=====
SELECT 



