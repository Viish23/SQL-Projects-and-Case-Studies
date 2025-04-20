use AdventureWorks2012


---- QUESTION 1 -Get all the details from the person table including email ID, phone number and phone number type

SELECT 
    p.BusinessEntityID,
    p.FirstName,
    p.MiddleName,
    p.LastName,
    e.EmailAddress,
    ph.PhoneNumber,
    pnt.Name AS PhoneNumberType
FROM 
    Person.Person AS p
LEFT JOIN 
    Person.EmailAddress AS e ON p.BusinessEntityID = e.BusinessEntityID
LEFT JOIN 
    Person.PersonPhone AS ph ON p.BusinessEntityID = ph.BusinessEntityID
LEFT JOIN 
    Person.PhoneNumberType AS pnt ON ph.PhoneNumberTypeID = pnt.PhoneNumberTypeID;

--- Question 2 -Get the details of the sales header order made in May 2011
SELECT *
FROM Sales.SalesOrderHeader
WHERE OrderDate >= '2011-05-01' AND OrderDate < '2011-06-01';

---- QUESTION 3--Get the details of the sales details order made in the month of May 2011
SELECT 
    soh.SalesOrderID,
    soh.OrderDate,
    soh.CustomerID,
    sod.ProductID,
    sod.OrderQty,
    sod.UnitPrice,
    sod.LineTotal
FROM 
    Sales.SalesOrderHeader AS soh
JOIN 
    Sales.SalesOrderDetail AS sod
    ON soh.SalesOrderID = sod.SalesOrderID
WHERE 
    YEAR(soh.OrderDate) = 2011 AND MONTH(soh.OrderDate) = 5;

---QUESTION 4--Get the total sales made in May 2011

SELECT 
    SUM(SubTotal) AS TotalSales
FROM 
    Sales.SalesOrderHeader
WHERE 
    OrderDate >= '2011-05-01' 
    AND OrderDate < '2011-06-01';

---QUESTION 5--Get the total sales made in the year 2011 by month order by increasing sales

SELECT 
    DATENAME(MONTH, OrderDate) AS MonthName,
    MONTH(OrderDate) AS MonthNumber,
    SUM(TotalDue) AS TotalSales
FROM 
    Sales.SalesOrderHeader
WHERE 
    YEAR(OrderDate) = 2011
GROUP BY 
    MONTH(OrderDate), DATENAME(MONTH, OrderDate)
ORDER BY 
    TotalSales ASC;

---QUESTION 6--Get the total sales made to the customer with FirstName='Gustavo'and LastName ='Achong'

SELECT 
    c.FirstName,
    c.LastName,
    SUM(soh.TotalDue) AS TotalSales
FROM 
    Sales.SalesOrderHeader soh
JOIN 
    Sales.Customer sc ON soh.CustomerID = sc.CustomerID
JOIN 
    Person.Person c ON sc.PersonID = c.BusinessEntityID
WHERE 
    c.FirstName = 'Gustavo' AND c.LastName = 'Achong'
GROUP BY 
    c.FirstName, c.LastName;







