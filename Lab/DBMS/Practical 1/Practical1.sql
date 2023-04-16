CREATE TABLE REGION(
    REGION_CODE NUMBER(1) NOT NULL,
    REGION_DESC VARCHAR2(10) NOT NULL,
    CONSTRAINT REGION_PK_REGION_CODE PRIMARY KEY (REGION_CODE),
    CONSTRAINT REGION_CK_REGION_DESC CHECK (REGION_DESC IN ('East', 'West', 'North', 'South'))
);

CREATE TABLE EMP(
    EMP_CODE NUMBER(2) NOT NULL,
    EMP_FNAME VARCHAR2(15) NOT NULL,
    EMP_LNAME VARCHAR2(15) NOT NULL,
    EMP_DOB DATE NOT NULL,
    STORE_CODE NUMBER(2) NOT NULL,
    SALARY NUMBER(5) NOT NULL,
    CONSTRAINT EMP_PK_EMP_CODE PRIMARY KEY (EMP_CODE),
    CONSTRAINT EMP_CK_SALARY CHECK (SALARY >= 1000)
);

CREATE TABLE STORE(
    STORE_CODE NUMBER(2) NOT NULL,
    STORE_NAME VARCHAR2(25) NOT NULL, 
    YID_SALES  NUMBER(9,2) DEFAULT 0 NOT NULL,
    REGION_CODE NUMBER(1) NOT NULL,
    EMP_CODE NUMBER(2),
    CONSTRAINT STORE_PK_STORE_CODE PRIMARY KEY (STORE_CODE),
    CONSTRAINT STORE_FK_REGION_CODE FOREIGN KEY (REGION_CODE) REFERENCES REGION(REGION_CODE),
    CONSTRAINT STORE_FK_EMP_CODE FOREIGN KEY (EMP_CODE) REFERENCES EMP(EMP_CODE)
);

INSERT INTO REGION VALUES(1, 'East');
INSERT INTO REGION VALUES(2, 'West');
INSERT INTO REGION VALUES(3, 'North');
INSERT INTO REGION VALUES(4, 'South');

INSERT INTO EMP VALUES(11, 'Kashish', 'Shukla', TO_DATE('1966-05-25','yyyy-mm-dd'), 21, 45000);

INSERT INTO STORE VALUES(21, 'Success Joint', 1000555.76, 2, 11);
INSERT INTO STORE VALUES(22, 'Hexa Fountain', 1420000.34, 2, 11);
INSERT INTO STORE VALUES(11, 'Citizen Avenue', 986785.40, 1, 11);
INSERT INTO STORE VALUES(31, 'Lifestyle corner', 944568.66, 3, 11);
INSERT INTO STORE VALUES(12, 'Central Deluge', 2930098.35, 1, 11);
INSERT INTO STORE VALUES(41, 'Curiosity cluster', 568000.00, 4, 11); 

ALTER TABLE EMP
ADD CONSTRAINT EMP_FK_STORE_CODE FOREIGN KEY (STORE_CODE) REFERENCES STORE(STORE_CODE);

INSERT INTO EMP VALUES(12, 'Aaron', 'Rocque', TO_DATE('2002-08-11','yyyy-mm-dd'), 41, 36000);
INSERT INTO EMP VALUES(13, 'Gazhal', 'Singh', TO_DATE('1961-10-02','yyyy-mm-dd'), 11, 48000);
INSERT INTO EMP VALUES(14, 'Mohana', 'Seth', TO_DATE('1971-06-01','yyyy-mm-dd'), 22, 27000);
INSERT INTO EMP VALUES(15, 'Shashwat', 'Puri', TO_DATE('1959-06-23','yyyy-mm-dd'), 11, 25000);
INSERT INTO EMP VALUES(16, 'Simon', 'Parera', TO_DATE('1960-09-03','yyyy-mm-dd'), 12, 25000);
INSERT INTO EMP VALUES(17, 'Vikrant', 'Gokhale', TO_DATE('1962-07-31','yyyy-mm-dd'), 12, 38000);
INSERT INTO EMP VALUES(18, 'Aarya', 'Mujumdar', TO_DATE('2001-12-06','yyyy-mm-dd'), 31, 38000);
INSERT INTO EMP VALUES(19, 'Aparjita', 'Rakshak', TO_DATE('1968-09-10','yyyy-mm-dd'), 21, 30000);
INSERT INTO EMP VALUES(20, 'Radhika', 'Ganesan', TO_DATE('1966-03-06','yyyy-mm-dd'), 11, 31000);
INSERT INTO EMP VALUES(21, 'Pampa', 'Roy', TO_DATE('1974-12-11','yyyy-mm-dd'), 41, 36000);
INSERT INTO EMP VALUES(22, 'Chanchal', 'Bhati', TO_DATE('1974-09-08','yyyy-mm-dd'), 22, 40000);
INSERT INTO EMP VALUES(23, 'Srinivas', 'Reddy', TO_DATE('1964-08-25','yyyy-mm-dd'), 31, 26000);
INSERT INTO EMP VALUES(24, 'Vallabh', 'Roy', TO_DATE('1974-12-11','yyyy-mm-dd'), 41, 32000);
INSERT INTO EMP VALUES(25, 'Bahar', 'Mirpuri', TO_DATE('1969-02-09','yyyy-mm-dd'), 22, 29000);

SELECT EMP_FNAME, EMP_LNAME, SALARY FROM EMP WHERE SALARY<35000;  

SELECT EMP_FNAME, EMP_LNAME, EMP_DOB, STORE.REGION_CODE 
FROM EMP JOIN STORE USING(STORE_CODE) 
WHERE EMP_DOB<'01-JAN-1972' AND STORE.REGION_CODE=2;

SELECT EMP.EMP_FNAME, EMP.EMP_LNAME, STORE.STORE_NAME 
FROM STORE JOIN EMP USING(STORE_CODE) 

SELECT STORE.STORE_NAME, EMP.EMP_FNAME, EMP.EMP_LNAME, STORE.YID_SALES
FROM STORE JOIN EMP USING(STORE_CODE) 

SELECT STORE.STORE_CODE, STORE.STORE_NAME, REGION.REGION_DESC 
FROM STORE JOIN REGION USING(REGION_CODE);

SELECT EMP.EMP_FNAME, EMP.EMP_LNAME, STORE.STORE_NAME
FROM STORE JOIN EMP USING(STORE_CODE) 
WHERE EMP.EMP_CODE = STORE.EMP_CODE;

UPDATE STORE 
	SET EMP_CODE=22 	
	WHERE STORE_CODE=22; 

UPDATE STORE 
	SET EMP_CODE=13	
	WHERE STORE_CODE=11;

UPDATE STORE 
	SET EMP_CODE=18 	
	WHERE STORE_CODE=31;

UPDATE STORE 
	SET EMP_CODE=17	
	WHERE STORE_CODE=12;

UPDATE STORE 
	SET EMP_CODE=12 	
	WHERE STORE_CODE=41;