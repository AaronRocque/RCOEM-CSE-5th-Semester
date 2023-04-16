/*
Script Name: "academic.sql"
===========================
    This script establishes the database for experiments in course named - Database Management Systems Lab [CSP351] of Fifth Semester B. E. [CSE] at RCOEM Nagpur.
    
    AUTHOR      : PROF. D. A. BORIKAR
    AFFILIATION : CSE, RCOEM NAGPUR
    DATE WRITTEN: 07-SEP-2022
    
NOTE: Strictly for use within RCOEM Nagpur for CSP351. Not to be circulated or forwarded further.

*/

REM CONFIGURING ACADEMIC DATABASE

SET ECHO OFF
SET FEEDBACK OFF
SET VERIFY OFF
SET PAGESIZE 25
SET LINESIZE 80

DROP TABLE STAFF CASCADE CONSTRAINTS PURGE;
DROP TABLE DEPT CASCADE CONSTRAINTS PURGE;
DROP TABLE STUDENT CASCADE CONSTRAINTS PURGE;

CLEAR SCR;
PROMPT
PROMPT
PROMPT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
PROMPT |                                                                             |
PROMPT |            DATABASE MANAGEMENT SYSTEMS LAB [CSP351] [2022-2023]             |
PROMPT |                                                                             |
PROMPT |                       ACADEMIC SCHEMA ESTABLISHMENT                         |
PROMPT |                                                                             |
PROMPT |                                                   BY: PROF. D. A. BORIKAR   |
PROMPT |                                                                             |
PROMPT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
PROMPT                                                                              
PROMPT  ~~~  ACADEMIC SCHEMA IS BEING ESTABLISHED ... PLEASE WAIT...        
PROMPT             

CREATE TABLE DEPT (
	DNAME VARCHAR2(25) NOT NULL,
	BRANCH VARCHAR2(4) NOT NULL,
	INTAKE NUMBER(2) NOT NULL,
	YR_EST NUMBER(4) NOT NULL,
	HOD NUMBER(3) DEFAULT 101 NOT NULL,
	CONSTRAINTS DEPT_PK_BRANCH PRIMARY KEY(BRANCH),
	CONSTRAINTS DEPT_CK_BRANCH CHECK (BRANCH IN ('CSE','DAT','AIML','CSEC')),
	CONSTRAINTS DEPT_CK_INTAKE CHECK (INTAKE IN (20,30,40)),
	CONSTRAINTS DEPT_CK_YR_EST CHECK (YR_EST > 2004)
);

CREATE TABLE STAFF(
	SID NUMBER(3) NOT NULL,
	NAME VARCHAR2(25) NOT NULL,
	BRANCH VARCHAR(4) NOT NULL,
	DESG VARCHAR2(9) NOT NULL,
	JOIN_DT DATE NOT NULL,
	CONSTRAINTS STAFF_PK_SID PRIMARY KEY(SID),
	CONSTRAINTS STAFF_FK_DEPT FOREIGN KEY(BRANCH) REFERENCES DEPT(BRANCH),
	CONSTRAINTS STAFF_CK_SID CHECK (SID > 100),
	CONSTRAINT STAFF_CK_DESG CHECK(DESG IN ('Professor','Assistant','Associate'))
);


CREATE TABLE STUDENT (
	ROLL NUMBER(3),
	LNAME VARCHAR2(15) NOT NULL,
	FNAME VARCHAR2(15) NOT NULL,
	EMAIL VARCHAR2(25) UNIQUE,
	ENROLL CHAR(13) UNIQUE ,
	ADVISOR NUMBER(3) NOT NULL,
    PHONE NUMBER(10),
    REG_DT DATE NOT NULL,
	CONSTRAINTS STUDENT_PK_ROLL PRIMARY KEY(ROLL),
	--CONSTRAINTS STUDENT_FK_STAFF_SID FOREIGN KEY(ADVISOR) REFERENCES STAFF(SID),
	CONSTRAINTS STUDENT_CK_ROLL CHECK (ROLL BETWEEN 1 AND 300)
);


PROMPT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
PROMPT |                                                                             |
PROMPT |                        ACADEMIC SCHEMA ESTABLISHED                          |
PROMPT |                                                                             |
PROMPT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
PROMPT
PROMPT

PAUSE DATABASE WILL BE POPULATED NOW. PRESS ANY KEY TO PROCEED.

REM POPULATING ACADEMIC DATABASE
CLEAR SCR;

PROMPT
PROMPT
PROMPT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
PROMPT |                                                                             |
PROMPT |                   DATABASE MANAGEMENT SYSTEMS LAB [CSP351]                  |
PROMPT |                                                                             |
PROMPT |                        POPULATING THE ACADEMIC SCHEMA                       |
PROMPT |                                                                             |
PROMPT |                                                   BY: PROF. D. A. BORIKAR   |
PROMPT |                                                                             |
PROMPT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
PROMPT                                                                              
PROMPT  ~~~  ACADEMIC SCHEMA IS BEING POPULATED ... PLEASE WAIT...        
PROMPT             
  

REM POPULATING DEPT TABLE
INSERT INTO DEPT VALUES('Computer Science', 'CSE', 40, 2005, 101); 
INSERT INTO DEPT VALUES('Data Analytics', 'DAT', 20, 2018, 103) ;
INSERT INTO DEPT VALUES('Cyber Security', 'CSEC', 20, 2018, 105) ;
INSERT INTO DEPT VALUES('AI and Machine Learning', 'AIML', 20, 2018, 102) ;
COMMIT;

REM POPULATING STAFF TABLE
INSERT INTO STAFF VALUES(101, 'Kamalkant Marathe', 'CSE', 'Professor', '12-Jun-2005'); 
INSERT INTO STAFF VALUES(102, 'Adishesh Vidyarthi', 'AIML', 'Associate', '22-Jul-2006');
INSERT INTO STAFF VALUES(103, 'Manishi Singh', 'DAT', 'Professor', '10-Nov-2007'); 
INSERT INTO STAFF VALUES(104, 'Aasawari Deodhar', 'CSE', 'Associate', '13-Oct-2008'); 
INSERT INTO STAFF VALUES(105, 'Geetika Goenka', 'CSEC', 'Professor', '15-Nov-2009');
-- INSERT INTO STAFF VALUES(106, 'Deo Narayan Mishra', 'DAT', 'Assistant', '13-Oct-2013'); 
-- INSERT INTO STAFF VALUES(107, 'Sanjeev Bamireddy', 'CSEC', 'Associate', '12-May-2018'); 
-- INSERT INTO STAFF VALUES(108, 'Jasmine Arora', 'CSE', 'Assistant', '11-Aug-2017'); 
-- INSERT INTO STAFF VALUES(109, 'Vallabh Pai', 'CSE', 'Assistant', '17-Sep-2018');
-- INSERT INTO STAFF VALUES(110, 'Harmeet Khullar', 'AIML', 'Assistant', '17-Mar-2019');
COMMIT;


ALTER TABLE DEPT
	ADD FOREIGN KEY(HOD) REFERENCES STAFF(SID);
    
REM POPULATING STUDENT TABLE
INSERT INTO STUDENT VALUES (1, 'Mujumdar', 'Aarya', 'mujumdaraa@rknec.edu', '20CSU1001CSU1', 101, 8329957655, '08-JAN-2021');
INSERT INTO STUDENT VALUES (2, 'Tiwari', 'Aditi', 'tiwarias_1@rknec.edu', '20CSU1002CSU1', 102, 9975451622, '08-JAN-2021');
INSERT INTO STUDENT VALUES (3, 'Shukla', 'Anushka', 'shuklaad@rknec.edu', '20CSU1003CSU1', 103, 8956797306, '08-JAN-2021');
INSERT INTO STUDENT VALUES (4, 'Jha', 'Aparna', 'jhaak_2@rknec.edu', '20CSU1004CSU1', 104, 8767573346, '08-JAN-2021');
INSERT INTO STUDENT VALUES (5, 'Soni', 'Ayushi', 'sonia@rknec.edu', '20CSU1005CSU1', 105, 7587237906, '08-JAN-2021');
INSERT INTO STUDENT VALUES (6, 'Dhakate', 'Harshada', 'dhakatehr@rknec.edu', '20CSU1006CSU1', 106, 7083071615, '08-JAN-2021');
INSERT INTO STUDENT VALUES (7, 'Barkhade', 'Hrishita', 'barkhadehp@rknec.edu', '20CSU1007CSU1', 107, 8080214199, '11-JAN-2021');
INSERT INTO STUDENT VALUES (8, 'Sah', 'Neha', 'sahna@rknec.edu', '20CSU1008CSU1', 108, 8766960979, '11-JAN-2021');
INSERT INTO STUDENT VALUES (9, 'Roy', 'Oshika', 'royos@rknec.edu', '20CSU1009CSU1', 109, 8208626447, '11-JAN-2021');
INSERT INTO STUDENT VALUES (10, 'Mohabansi', 'Pakhee', 'mohabansipp@rknec.edu', '20CSU1010CSU1', 110, 9021641344, '11-JAN-2021');
INSERT INTO STUDENT VALUES (11, 'Akre', 'Prachiti', 'akrepp_1@rknec.edu', '20CSU1011CSU1', 101, 8446057549, '11-JAN-2021');
INSERT INTO STUDENT VALUES (12, 'Mundhada', 'Pranjal', 'mundhadapd_1@rknec.edu', '20CSU1012CSU1', 102, 7517857251, '08-JAN-2021');
INSERT INTO STUDENT VALUES (13, 'Joshi', 'Pranjali', 'joshipu_1@rknec.edu', '20CSU1013CSU1', 103, 9767125986, '08-JAN-2021');
INSERT INTO STUDENT VALUES (14, 'Sharma', 'Rajshree', 'sharmarh_1@rknec.edu', '20CSU1014CSU1', 104, 8668246399, '08-JAN-2021');
INSERT INTO STUDENT VALUES (15, 'Tiwari', 'Rashmi', 'tiwarirs@rknec.edu', '20CSU1015CSU1', 105, 8600001678, '08-JAN-2021');
INSERT INTO STUDENT VALUES (16, 'Khandelwal', 'Reema', 'khandelwalrr_1@rknec.edu', '20CSU1016CSU1', 106, 9405700956, '11-JAN-2021');
INSERT INTO STUDENT VALUES (17, 'Jain', 'Riya', 'jainrv_1@rknec.edu', '20CSU1017CSU1', 107, 9373139193, '08-JAN-2021');
INSERT INTO STUDENT VALUES (18, 'Anasane', 'Samiksha', 'anasanesk@rknec.edu', '20CSU1018CSU1', 108, 8767513810, '08-JAN-2021');
INSERT INTO STUDENT VALUES (19, 'Asati', 'Samiksha', 'asatisp_1@rknec.edu', '20CSU1019CSU1', 109, 7499303234, '08-JAN-2021');
INSERT INTO STUDENT VALUES (20, 'Tatiwar', 'Samruddhi', 'tatiwarsv@rknec.edu', '20CSU1020CSU1', 110, 9130172067, '09-JAN-2021');
INSERT INTO STUDENT VALUES (21, 'Balpande', 'Sanskruti', 'balpandesp@rknec.edu', '20CSU1021CSU1', 101, 8329475463, '08-JAN-2021');
INSERT INTO STUDENT VALUES (22, 'Mahajan', 'Shradha', 'mahajanss_1@rknec.edu', '20CSU1022CSU1', 102, 9529935790, '08-JAN-2021');
INSERT INTO STUDENT VALUES (23, 'Gupta', 'Shristi', 'guptass_7@rknec.edu', '20CSU1023CSU1', 103, 9371860624, '08-JAN-2021');
INSERT INTO STUDENT VALUES (24, 'Jain', 'Shruti', 'jainsp_2@rknec.edu', '20CSU1024CSU1', 104, 7709456823, '09-JAN-2021');
INSERT INTO STUDENT VALUES (25, 'Dhakate', 'Srushti', 'dhakatesr_1@rknec.edu', '20CSU1025CSU1', 105, 7448131512, '08-JAN-2021');
INSERT INTO STUDENT VALUES (26, 'Valecha', 'Varsha', 'valechavd@rknec.edu', '20CSU1026CSU1', 106, 9172893028, '09-JAN-2021');
INSERT INTO STUDENT VALUES (27, 'Gupta', 'Diksha', 'guptadr4@rknec.edu ', '21CSU1126CSU1', 107, 9911111111, '11-NOV-2021');
INSERT INTO STUDENT VALUES (28, 'Sayyed', 'Juhie', 'sayyedjj@rknec.edu', '21CSU1127CSU1', 108, 9922222222, '11-NOV-2021');
INSERT INTO STUDENT VALUES (31, 'Rocque', 'Aaron', 'rocqueae@rknec.edu', '20CSU1027CSU1', 109, 8007445511, '08-JAN-2021');
INSERT INTO STUDENT VALUES (32, 'Warkad', 'Adwait', 'warkadad@rknec.edu', '20CSU1028CSU1', 110, 9158325413, '08-JAN-2021');
INSERT INTO STUDENT VALUES (33, 'Kumar', 'Ajay', 'kumara3@rknec.edu', '20CSU1029CSU1', 101, 6006196624, '08-JAN-2021');
INSERT INTO STUDENT VALUES (34, 'Surana', 'Akshat', 'suranaas@rknec.edu', '20CSU1030CSU1', 102, 9552743375, '11-JAN-2021');
INSERT INTO STUDENT VALUES (35, 'Singh', 'Amish', 'singhak_2@rknec.edu', '20CSU1031CSU1', 103, 7719015180, '08-JAN-2021');
INSERT INTO STUDENT VALUES (36, 'Thakur', 'Arpit', 'thakuray@rknec.edu', '20CSU1032CSU1', 104, 7030823952, '08-JAN-2021');
INSERT INTO STUDENT VALUES (37, 'Wanjari', 'Bhushan', 'wanjaribl@rknec.edu', '20CSU1033CSU1', 105, 7709317844, '11-JAN-2021');
INSERT INTO STUDENT VALUES (38, 'Chandan', 'Darshan', 'chandandb@rknec.edu', '20CSU1034CSU1', 106, 7841043757, '08-JAN-2021');
INSERT INTO STUDENT VALUES (39, 'Dongare', 'Divesh', 'dongaredv@rknec.edu', '20CSU1035CSU1', 107, 8554889714, '08-JAN-2021');
INSERT INTO STUDENT VALUES (40, 'Pathak', 'Gaurav', 'pathakgs@rknec.edu', '20CSU1036CSU1', 108, 9890343593, '09-JAN-2021');
INSERT INTO STUDENT VALUES (41, 'Nimbalkar', 'Gunjan', 'nimbalkargd@rknec.edu', '20CSU1037CSU1', 109, 9322053686, '08-JAN-2021');
INSERT INTO STUDENT VALUES (42, 'Sherekar', 'Harsh', 'sherekarhp@rknec.edu', '20CSU1038CSU1', 110, 9834341350, '09-JAN-2021');
INSERT INTO STUDENT VALUES (43, 'Mandavgade', 'Janak', 'chaudharijr@rknec.edu', '20CSU1039CSU1', 101, 9156998394, '15-JAN-2021');
INSERT INTO STUDENT VALUES (44, 'Jibhakate', 'Jayesh', 'mandavgadejd@rknec.edu', '20CSU1040CSU1', 102, 9518524078, '15-JAN-2021');
INSERT INTO STUDENT VALUES (45, 'Chaudhari', 'Jaiwin', 'jibhakatejt@rknec.edu', '20CSU1041CSU1', 103, 7666548980, '15-JAN-2021');
INSERT INTO STUDENT VALUES (46, 'Jora', 'Kunwar', 'jorakr@rknec.edu', '20CSU1042CSU1', 104, 7507066263, '08-JAN-2021');
INSERT INTO STUDENT VALUES (47, 'Munot', 'Kush', 'munotkg@rknec.edu', '20CSU1043CSU1', 105, 9574132346, '08-JAN-2021');
INSERT INTO STUDENT VALUES (48, 'Chowdhury', 'Mihir', 'chowdhuryms@rknec.edu', '20CSU1044CSU1', 106, 9130119452, '09-JAN-2021');
INSERT INTO STUDENT VALUES (49, 'Dudhbade', 'Mrugal', 'dudhbademr@rknec.edu', '20CSU1045CSU1', 107, 7410724752, '08-JAN-2021');
INSERT INTO STUDENT VALUES (50, 'Morayya', 'Nipun', 'morayyana@rknec.edu', '20CSU1046CSU1', 108, 8329173678, '08-JAN-2021');
INSERT INTO STUDENT VALUES (51, 'Nandha', 'Piyush', 'nandhapk@rknec.edu', '20CSU1047CSU1', 109, 9359639870, '09-JAN-2021');
INSERT INTO STUDENT VALUES (52, 'Gujar', 'Prathamesh', 'gujarpa@rknec.edu', '20CSU1048CSU1', 110, 9923505391, '08-JAN-2021');
INSERT INTO STUDENT VALUES (53, 'Rajbhoj', 'Prathamesh', 'rajbhojpr@rknec.edu', '20CSU1049CSU1', 101, 8767268173, '09-JAN-2021');
INSERT INTO STUDENT VALUES (54, 'Thakare', 'Rajesh', 'thakarerd@rknec.edu', '20CSU1050CSU1', 102, 9022476812, '08-JAN-2021');
INSERT INTO STUDENT VALUES (55, 'Khatod', 'Raman', 'khatodrn@rknec.edu', '20CSU1051CSU1', 103, 8149050111, '15-JAN-2021');
INSERT INTO STUDENT VALUES (56, 'Dubey', 'Rishabh', 'dubeyrm_1@rknec.edu', '20CSU1052CSU1', 104, 9022895795, '15-JAN-2021');
INSERT INTO STUDENT VALUES (57, 'Bhojwani', 'Rohit', 'bhojwanirs@rknec.edu', '20CSU1053CSU1', 105, 7058644880, '15-JAN-2021');
INSERT INTO STUDENT VALUES (58, 'Malu', 'Rushikesh', 'malurr@rknec.edu', '20CSU1054CSU1', 106, 9119498168, '08-JAN-2021');
INSERT INTO STUDENT VALUES (59, 'Hablani', 'Sachal', 'hablanisr_1@rknec.edu', '20CSU1055CSU1', 107, 8600670248, '08-JAN-2021');
INSERT INTO STUDENT VALUES (60, 'Mandal', 'Sagar', 'mandalss@rknec.edu', '20CSU1056CSU1', 108, 7385943527, '08-JAN-2021');
INSERT INTO STUDENT VALUES (61, 'Chharra', 'Sahil', 'chharrasr@rknec.edu', '20CSU1057CSU1', 109, 9370002313, '08-JAN-2021');
INSERT INTO STUDENT VALUES (62, 'Suchak', 'Saurabh', 'suchaksb@rknec.edu', '20CSU1058CSU1', 110, 9325992396, '15-JAN-2021');
INSERT INTO STUDENT VALUES (63, 'Baghele', 'Shivam', 'baghelesp@rknec.edu', '20CSU1059CSU1', 101, 9322165074, '15-JAN-2021');
INSERT INTO STUDENT VALUES (64, 'Shah', 'Siddharth', 'shahss_2@rknec.edu', '20CSU1060CSU1', 102, 7887439043, '15-JAN-2021');
INSERT INTO STUDENT VALUES (65, 'Thakre', 'Sopan', 'thakresp_1@rknec.edu', '20CSU1061CSU1', 103, 7263872577, '11-JAN-2021');
INSERT INTO STUDENT VALUES (66, 'Pandey', 'Sudhanshu', 'pandeysv@rknec.edu', '20CSU1062CSU1', 104, 8104847161, '09-JAN-2021');
INSERT INTO STUDENT VALUES (67, 'Laira', 'Swyam', 'lairas@rknec.edu', '20CSU1063CSU1', 105, 8825092091, '11-JAN-2021');
INSERT INTO STUDENT VALUES (68, 'Sathawane', 'Utkarsh', 'sathawaneua@rknec.edu', '20CSU1064CSU1', 106, 8484054214, '11-JAN-2021');
INSERT INTO STUDENT VALUES (69, 'Singh', 'Varunpreet', 'singhv1@rknec.edu', '20CSU1065CSU1', 107, 9469746624, '15-JAN-2021');
INSERT INTO STUDENT VALUES (70, 'Khergade', 'Vedant', 'khergadevs@rknec.edu', '20CSU1066CSU1', 108, 7030298602, '15-JAN-2021');
INSERT INTO STUDENT VALUES (71, 'Kashyap', 'Vikram', 'kashyapvs@rknec.edu', '20CSU1067CSU1', 109, 7028276772, '15-JAN-2021');
INSERT INTO STUDENT VALUES (72, 'Tiwari', 'Vinit', 'tiwarivv_3@rknec.edu', '20CSU1068CSU1', 110, 8446152563, '11-JAN-2021');
INSERT INTO STUDENT VALUES (73, 'Agrawal', 'Yash', 'agrawalys_2@rknec.edu', '20CSU1069CSU1', 101, 7709660269, '11-JAN-2021');
INSERT INTO STUDENT VALUES (74, 'Tekade', 'Yash', 'tekadeys@rknec.edu', '20CSU1070CSU1', 104, 8857074204, '09-JAN-2021');
INSERT INTO STUDENT VALUES (75, 'Baser', 'Rahul', 'baserrd1@rknec.edu', '21CSU1128CSU1', 109, 9933333333, '11-NOV-2021');
INSERT INTO STUDENT VALUES (77, 'Wankhedkar', 'Yash', 'wankhedkaryn@rknec.edu', '21CSU1129CSU1', 108, 9944444444, '10-NOV-2021');
INSERT INTO STUDENT VALUES (78, 'Joshi', 'Varun', 'joshivk2@rknec.edu ', '21CSU1130CSU1', 110, 9955555555, '10-NOV-2021');
COMMIT;

PROMPT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
PROMPT |                                                                             |
PROMPT |                       ACADEMIC SCHEMA IS UP FOR USE                         |
PROMPT |                                                                             |
PROMPT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
PROMPT
PROMPT

PAUSE PRESS ANY KEY TO CONTINUE.

CLEAR SCR;

PROMPT DATABASE CONTAINS..
PROMPT

SELECT COUNT(*) "DEPT#" FROM DEPT;
SELECT COUNT(*) "STAFF#" FROM STAFF;
SELECT COUNT(*) "STUDENT#" FROM STUDENT;
SELECT COUNT(*) "CSE STUDENT#" FROM STUDENT WHERE ADVISOR IN (101, 104, 108, 109);
SELECT COUNT(*) "AIML STUDENT#" FROM STUDENT WHERE ADVISOR IN (102, 110);
SELECT COUNT(*) "CYBER STUDENT#" FROM STUDENT WHERE ADVISOR IN (105, 107);
SELECT COUNT(*) "DATA STUDENT#" FROM STUDENT WHERE ADVISOR IN (103, 106);


SET FEEDBACK ON
SET VERIFY ON
SET ECHO ON 
