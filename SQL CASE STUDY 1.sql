CREATE DATABASE [CASE_STUDY1]
USE [CASE_STUDY1]


SELECT*FROM DBO.FACT
SELECT*FROM DBO.PRODUCT
SELECT*FROM DBO.LOCATION

--1. Display the number of states present in the LocationTable.
SELECT COUNT (DISTINCT STATE) AS COUNT_STATE FROM DBO.LOCATION


--2. How many products are of regular type?
SELECT COUNT (PRODUCT) AS COUNT_PRODUCT FROM DBO.PRODUCT WHERE TYPE ='REGULAR'

--3. How much spending has been done on marketing of product ID 1?
SELECT SUM (MARKETING) AS SUM_MAEKETING FROM DBO.FACT WHERE ProductId = '1'

--4. What is the minimum sales of a product?
SELECT MIN (SALES) AS MIN_SALES FROM DBO.FACT

--5. Display the max Cost of Good Sold (COGS).
SELECT Max (COGS) as COST_SOLD FROM DBO.FACT


--6. Display the details of the product where product type is coffee.
SELECT * FROM PRODUCT WHERE Product_Type='COFFEE'

--7. Display the details where total expenses are greater than 40.
SELECT * FROM FACT WHERE Total_Expenses>40

--8. What is the average sales in area code 719?
select AVG (sales) as AVG_SALES from fact where Area_Code ='719'


--9. Find out the total profit generated by Colorado state.
SELECT SUM(V.PROFIT) AS TOTAL_PROFIT FROM FACT v
INNER JOIN LOCATION l
ON v.AREA_CODE =l.AREA_CODE
WHERE L.STATE='Colorado '


--10. Display the average inventory for each product ID.
SELECT PRODUCTID , AVG (INVENTORY) AS AVG_INVENTORY FROM FACT GROUP BY ProductId ORDER BY ProductId


--11. Display state in a sequential order in a Location Table.
SELECT STATE FROM LOCATION ORDER BY STATE
SELECT STATE FROM LOCATION ORDER BY STATE DESC


--12. Display the average budget of the Product where the average budget
--margin should be greater than 100.
SELECT PRODUCTID, AVG(BUDGET_MARGIN) AS AVG_BUDGET FROM FACT GROUP BY ProductId HAVING AVG(BUDGET_MARGIN)>100

--13. What is the total sales done on date 2010-01-01?
SELECT DATE, SUM(SALES)  SALES_DONE FROM FACT WHERE DATE ='2010-01-01' GROUP BY DATE


--14. Display the average total expense of each product ID on an individual date.
select productid, date, avg(total_expenses) as Avg_exp from fact group by ProductId ,date orDER BY ProductId


--15. Display the table with the following attributes such as date, productID,
--product_type, product, sales, profit, state, area_code.
SELECT F.DATE ,F.PRODUCTID,P.PRODUCT_TYPE,P.PRODUCT,F.SALES,F.PROFIT,L.STATE,L.AREA_CODE FROM FACT F INNER JOIN LOCATION L ON F.AREA_CODE=L.AREA_CODE INNER JOIN PRODUCT P ON F.PRODUCTID=P.PRODUCTID


--16. Display the rank without any gap to show the sales wise rank.
SELECT SALES,DENSE_RANK () OVER (ORDER BY SALES) AS SALES_RANK FROM fact

--17. Find the state wise profit and sales.
SELECT L.STATE ,sum(f.profit)as profit ,sum(f.sales) as sales from fact f inner join Location l on f.Area_Code =l.Area_Code group by State

--18. Find the state wise profit and sales along with the product name.
SELECT L.STATE ,sum(f.profit)as Profit ,sum(f.sales) as Sales from fact f  inner join Location l on f.Area_Code =l.Area_Code 
inner join product p on f.ProductId=p.productid
group by State,Product


--19. If there is an increase in sales of 5%, calculate the increasedsales.
SELECT SALES,(SALES*1.05) AS INC_SALES FROM FACT

--20. Find the maximum profit along with the product ID and producttype.
SELECT P.PRODUCTID,P.PRODUCT_TYPE, MAX (F.PROFIT) AS MAX_PROFIT FROM FACT F
INNER JOIN PRODUCT P ON F.PRODUCTID=P.PRODUCTID GROUP BY P.PRODUCTID,P.PRODUCT_TYPE 


--21. Create a stored procedure to fetch the result according to the product type
--from Product Table.
create procedure store_product (@x varchar(50))
as
select * from product where Product_Type=@x;

exec store_product 'coffee'


--22. Write a query by creating a condition in which if the total expenses is less than
--60 then it is a profit or else loss.
SELECT TOTAL_EXPENSES , IIF (TOTAL_EXPENSES>60,'PROFIT','LOSS') AS STATUS FROM FACT


--23. Give the total weekly sales value with the date and product ID details. Use
--roll-up to pull the data in hierarchical order.
SELECT DATEPART(WEEK,DATE) AS WEEK_DATE,PRODUCTID, SUM (SALES) AS SUM_SALES FROM FACT GROUP BY DATEPART(WEEK,DATE),PRODUCTID WITH ROLLUP



--24. Apply union and intersection operator on the tables which consist of
--attribute area code.
SELECT AREA_CODE FROM FACT
UNION
SELECT AREA_CODE FROM LOCATION

SELECT AREA_CODE FROM FACT
INTERESECT
SELECT AREA_CODE FROM LOCATION





--25. Create a user-defined function for the product table to fetch a particular
--product type based upon the user�s preference.
CREATE FUNCTION FUN_PRODUCT(@X VARCHAR(50))
RETURNS TABLE 
AS
RETURN SELECT * FROM PRODUCT WHERE PRODUCT_TYPE=@X

SELECT* FROM DBO.FUN_PRODUCT('TEA')


--26. Change the product type from coffee to tea where product ID is 1 and undo
--it.

BEGIN TRANSACTION
UPDATE PRODUCT SET PRODUCT_TYPE='TEA' WHERE PRODUCTID=1
ROLLBACK TRANSACTION

SELECT* FROM PRODUCT


--27. Display the date, product ID and sales where total expenses are
--between 100 to 200.
SELECT DATE ,PRODUCTID,SALES,TOTAL_EXPENSES FROM FACT WHERE TOTAL_EXPENSES BETWEEN 100 AND 200


--28. Delete the records in the Product Table for regular type.
DELETE FROM PRODUCT WHERE TYPE='REGULAR'


--29. Display the ASCII value of the fifth character from the columnProduct
SELECT PRODUCT,(ASCII(SUBSTRING(product,5,1))) AS fifth_ascii from product