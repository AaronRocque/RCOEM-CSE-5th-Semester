--QUERY

select v_code, avg(p_price)
	from product 
	group by v_code;
	
--Remove NULL values from above. 
--Use WHERE V_VODE IS NOT NULL
--You should get two rows

select v_code, avg(p_price)
	from product 
	where v_code is not null
	group by v_code;
	
select v_code, p_price *qty t_cost
	from product
	where v_code is not null	
	order by v_code;
--No JOIN required here cause of NOT NULL

select v_code, SUM(p_price *qty) t_cost
	from product
	where v_code is not null	
	group by v_code
	having (sum(p_price*qty) > 400)
	order by sum(p_price * qty) desc;

----------------------------------------------------
--Querey 6

select v_code, p_price, qty from product;

error
create or replace view PRODUCT_STATS as
select v_code, sum(p_price * qty) tot_cost,
		max(qty) mx_qty,
		min(qty) mn_qty,
		avg(qty) av_qty
		from product
		where v_code is not null 
		group by v_code;
		
----------------------------------------------------
--Querey 7

--incomplete
select c_code, balance, sum(l_units * l_price) tot_purchase
	from 
	((select inv_num, sum(l_units * l_price) from invoice group by inv_name)
	join 
	(select inv_num, sum(l_units * l_price)) 
		from
		
select c_code, sum(tot_line) tot_inv
	 from invoice natural join (
		select inv_num, sum(l_units * l_price) tot_line	
			from line
			group by inv_num) tt
	group by (c_code);
--JOIN with CUSTOMER to get customer_name

select c_code, inv_num, tot_inv
	 from invoice natural join (
		select inv_num, sum(l_units * l_price) tot_line	
			from line
			group by inv_num) tt
	group by (c_code);

	

SELECT C_CODE, LNAME, FNAME, TOT_INV, BALANCE
       FROM CUSTOMER NATURAL JOIN (
	       SELECT C_CODE, SUM(TOT_LINE) TOT_INV
		   FROM INVOICE NATURAL JOIN (
		   SELECT INV_NUM, SUM(L_UNITS*L_PRICE) TOT_LINE 
		        FROM LINE
				GROUP BY INV_NUM) TT
		   GROUP BY C_CODE)
	ORDER BY (C_CODE);
	
	
----------------------------------------------------
--Querey 8

--get line_count with inv_num and tot_purchase
----------------------------------------------------
--Querey 9

compare c_code not in 
	(select distinct c_code);

--5 will be the answer
--10, 13, 16, 17, 19

----------------------------------------------------
--Querey 10

----------------------------------------------------
--Querey 11

--create a table, don't populate 
--apply constraints 
--make portid as pk
--create table as select subquerey 
--populate the table
--check constraints if the table
		
CREATE TABLE INV_CUSTOMER AS
	SELECT INV_NUM AS QUOTE_ID, INV_DATE AS QUOTE_DT, FNAME ||' '|| LNAME AS C_NAME 
		FROM INVOICE 
		JOIN CUSTOMER USING (c_code);
		
INSERT INTO INV_CUSTOMER 
	SELECT INV_NUM, INV_DATE, FNAME ||' '|| LNAME FROM INVOICE JOIN CUSTOMER USING (c_code);
	
SELECT INV_NUM AS QUOTE_ID, INV_DATE AS QUOTE_DT, FNAME ||' '|| LNAME AS C_NAME 
		FROM INVOICE 
		JOIN CUSTOMER USING (c_code);
----------------------------------------------------
--Querey 12

CREATE OR REPLACE VIEW INV_CUSTOMER_VW AS
	SELECT INV_NUM AS QUOTE_ID, INV_DATE AS QUOTE_DT, FNAME ||' '|| LNAME AS C_NAME 
		FROM INVOICE 
		JOIN CUSTOMER USING (c_code);
		
INSERT INTO INV_CUSTOMER_VW 
	SELECT INV_NUM, INV_DATE, FNAME ||' '|| LNAME FROM INVOICE JOIN CUSTOMER USING (c_code);
--GIVERS ERROR (IT IS SUPPOSED TO GIVE ERROR)

--Populate view during creation itself

SELECT * FROM INV_CUSTOMER_VW;

CREATE OR REPLACE VIEW INV_CUSTOMER_VW AS
	SELECT INV_NUM AS QUOTE_ID, INV_DATE AS QUOTE_DT, FNAME ||' '|| LNAME AS C_NAME 
		FROM INVOICE 
		JOIN CUSTOMER USING (c_code)
		WHERE (1=1);
		
----------------------------------------------------
--Diksha 11 and 12

CREATE TABLE INV_CUSTOMER AS
SELECT INV_NUM AS QUOTE_ID , INV_DATE AS QUOTE_DT , FNAME||' '||LNAME AS C_NAME FROM INVOICE JOIN CUSTOMER USING(C_CODE) WHERE 1=2;


INSERT INTO INV_CUSTOMER SELECT INV_NUM , INV_DATE , FNAME||' '||LNAME FROM INVOICE JOIN CUSTOMER USING(C_CODE);


CREATE OR REPLACE VIEW INV_CUSTOMER_VW AS
SELECT INV_NUM AS QUOTE_ID , INV_DATE AS QUOTE_DT , FNAME||' '||LNAME AS C_NAME FROM INVOICE JOIN CUSTOMER USING(C_CODE) WHERE 1=2;


CREATE OR REPLACE VIEW INV_CUSTOMER_VW AS
SELECT INV_NUM AS QUOTE_ID , INV_DATE AS QUOTE_DT , FNAME||' '||LNAME AS C_NAME FROM INVOICE JOIN CUSTOMER USING(C_CODE);


INSERT INTO INV_CUSTOMER_VW  SELECT INV_NUM , INV_DATE , FNAME||' '||LNAME FROM INVOICE JOIN CUSTOMER USING(C_CODE);

SELECT * FROM INV_CUSTOMER_VW;

INSERT INTO INV_CUSTOMER_VW VALUES (1011 , '12-MAR-2022' , 'JAGAT NARAYAN');
--virtual column not allowed here

----------------------------------------------------
--Querey 13

SELECT V_CODE, V_NAME FROM VENDOR 
	WHERE V_CODE IN (SELECT DISTINCT (V_CODE) FROM PRODUCT 
		WHERE P_CODE IS NOT NULL);
----------------------------------------------------
--Querey 14

--SELECT DESCRIPT, P_CODE, P_PRICE FROM PRODUCT; 

SELECT avg(p_price) FROM PRODUCT;

SELECT count(p_code) FROM PRODUCT;

SELECT DESCRIPT, COUNT(P_CODE) FROM PRODUCT 
	GROUP BY DESCRIPT 
	HAVING COUNT(P_CODE) > 0;

SELECT DESCRIPT, AVG(P_PRICE) FROM PRODUCT 
	GROUP BY DESCRIPT 
	HAVING COUNT(P_CODE) > 1;	
	
--Now to get sub querey
--Those who can do, do.

----------------------------------------------------
--Querey 15

----------------------------------------------------
--Querey 16

--Opposite of Q13
SELECT V_CODE, V_NAME FROM VENDOR 
	WHERE V_CODE NOT IN (SELECT DISTINCT (V_CODE) FROM PRODUCT 
		WHERE P_CODE IS NOT NULL);
		
----------------------------------------------------
--Querey 17

--You have double subquery here

UPDATE PRODUCT 
	SET P_PRICE = (SELECT AVG(P_PRICE) FROM PRODUCT 
	WHERE V_CODE IN (SELECT V_CODE FROM VENDOR 
	WHERE V_STATE NOT IN ('KY','TN')));
	

----------------------------------------------------
--Querey 18


----------------------------------------------------
--Querey 19

--You can write using OR OR OR, but thats not a subquerey, so use IN.

----------------------------------------------------
--Querey 20

--You will gate average quantity sold from LINE.
--group by p_code for total quantity of every product


----------------------------------------------------
--Querey 21

--Get it from LINE, get invoices from line
--Take out those c_code that have such invoice name


----------------------------------------------------
--Querey 22

--Since 'FOR ALL', this means GROUP BY... HAVING 


----------------------------------------------------
--Querey 23

----------------------------------------------------
--Querey 24