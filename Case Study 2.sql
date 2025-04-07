CREATE DATABASE CASE_STUDY_2;
USE CASE_STUDY_2;

CREATE TABLE LOCATION (
  Location_ID INT PRIMARY KEY,
  City VARCHAR(50)
);

INSERT INTO LOCATION (Location_ID, City)
VALUES (122, 'New York'),
       (123, 'Dallas'),
       (124, 'Chicago'),
       (167, 'Boston');

CREATE TABLE DEPARTMENT (
  Department_Id INT PRIMARY KEY,
  Name VARCHAR(50),
  Location_Id INT,
  FOREIGN KEY (Location_Id) REFERENCES LOCATION(Location_ID)
);

INSERT INTO DEPARTMENT (Department_Id, Name, Location_Id)
VALUES (10, 'Accounting', 122),
       (20, 'Sales', 124),
       (30, 'Research', 123),
       (40, 'Operations', 167);

CREATE TABLE JOB (
  Job_ID INT PRIMARY KEY,
  Designation VARCHAR(50)
);

INSERT INTO JOB (Job_ID, Designation)
VALUES (667, 'CLERK'),
       (668, 'STAFF'),
       (669, 'ANALYST'),
       (670, 'SALES_PERSON'),
       (671, 'MANAGER'),
       (672, 'PRESIDENT');

CREATE TABLE EMPLOYEE (
  EMPLOYEE_ID INT,
  LAST_NAME VARCHAR(20),
  FIRST_NAME VARCHAR(20),
  MIDDLE_NAME CHAR(1),
  JOB_ID INT,
  MANAGER_ID INT,
  HIRE_DATE DATE,
  SALARY INT,
  COMM INT,
  DEPARTMENT_ID INT,
  FOREIGN KEY (JOB_ID) REFERENCES JOB(Job_ID),
  FOREIGN KEY (DEPARTMENT_ID) REFERENCES DEPARTMENT(Department_Id)
);

INSERT INTO EMPLOYEE VALUES
(7369, 'SMITH', 'JOHN', 'Q', 667, 7902, '17-DEC-84', 800, NULL, 20),
(7499, 'ALLEN', 'KEVIN', 'J', 670, 7698, '20-FEB-84', 1600, 300, 30),
(7505, 'DOYLE', 'JEAN', 'K', 671, 7839, '04-APR-85', 2850, NULL, 30),
(7506, 'DENNIS', 'LYNN', 'S', 671, 7839, '15-MAY-85', 2750, NULL, 30),
(7507, 'BAKER', 'LESLIE', 'D', 671, 7839, '10-JUN-85', 2200, NULL, 40),
(7521, 'WARK', 'CYNTHIA', 'D', 670, 7698, '22-FEB-85', 1250, 500, 30);


--SIMPLE QUERIES
-- 1. List all the employee details.
SELECT * FROM EMPLOYEE;

-- 2. List all the department details.
SELECT * FROM DEPARTMENT;

-- 3. List all job details.
SELECT * FROM JOB;

-- 4. List all the locations.
SELECT * FROM LOCATION;

-- 5. List out the First Name, Last Name, Salary, Commission for all Employees.
SELECT FIRST_NAME, LAST_NAME, SALARY, COMM FROM EMPLOYEE;

-- 6. List out the Employee ID, Last Name, Department ID for all employees and alias Employee ID as "ID of the Employee",
--Last Name as "Name of the Employee", Department ID as "Dep_id".
SELECT EMPLOYEE_ID AS "ID of the Employee", LAST_NAME AS "Name of the Employee", DEPARTMENT_ID AS "Dep_id" FROM EMPLOYEE;

-- 7. List out the annual salary of the employees with their names only.
SELECT FIRST_NAME, LAST_NAME, SALARY * 12 AS "Annual Salary" FROM EMPLOYEE;

--WHERE Condition:
-- 1. List the details about "Smith".
SELECT * FROM EMPLOYEE WHERE LAST_NAME = 'SMITH';

-- 2. List out the employees who are working in department 20.
SELECT * FROM EMPLOYEE WHERE DEPARTMENT_ID = 20;

-- 3. List out the employees who are earning salaries between 3000 and 4500.
SELECT * FROM EMPLOYEE WHERE SALARY BETWEEN 3000 AND 4500;

-- 4. List out the employees who are working in department 10 or 20.
SELECT * FROM EMPLOYEE WHERE DEPARTMENT_ID IN (10, 20);

-- 5. Find out the employees who are not working in department 10 or 30.
SELECT * FROM EMPLOYEE WHERE DEPARTMENT_ID NOT IN (10, 30);

-- 6. List out the employees whose name starts with 'S'.
SELECT * FROM EMPLOYEE WHERE FIRST_NAME LIKE 'S%';

-- 7. List out the employees whose name starts with 'S' and ends with 'H'.
SELECT * FROM EMPLOYEE WHERE FIRST_NAME LIKE 'S%H';

-- 8. List out the employees whose name length is 4 and start with 'S'.
SELECT * FROM EMPLOYEE WHERE FIRST_NAME LIKE 'S__';

-- 9. List out employees who are working in department 10 and draw salaries more than 3500.
SELECT * FROM EMPLOYEE WHERE DEPARTMENT_ID = 10 AND SALARY > 3500;

-- 10. List out the employees who are not receiving commission.
SELECT * FROM EMPLOYEE WHERE COMM IS NULL;

--ORDER BY Clause:
-- 1. List out the Employee ID and Last Name in ascending order based on the Employee ID.
SELECT EMPLOYEE_ID, LAST_NAME 
FROM EMPLOYEE 
ORDER BY EMPLOYEE_ID ASC;

-- 2. List out the Employee ID and Name in descending order based on salary.
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME
FROM EMPLOYEE 
ORDER BY SALARY DESC;


-- 3. List out the employee details according to their Last Name in ascending-order.
SELECT * 
FROM EMPLOYEE 
ORDER BY LAST_NAME ASC;

-- 4. List out the employee details according to their Last Name in ascending order and then Department ID in descending order.
SELECT * 
FROM EMPLOYEE 
ORDER BY LAST_NAME ASC, DEPARTMENT_ID DESC;

--GROUP BY and HAVING Clause:
-- 1. How many employees are in different departments in the organization?
SELECT DEPARTMENT_ID, COUNT(*) AS NumEmployees
FROM EMPLOYEE
GROUP BY DEPARTMENT_ID;

-- 2. List out the department-wise maximum salary, minimum salary, and average salary of the employees.
SELECT DEPARTMENT_ID, MAX(SALARY) AS MaxSalary, MIN(SALARY) AS MinSalary, AVG(SALARY) AS AvgSalary
FROM EMPLOYEE
GROUP BY DEPARTMENT_ID;

-- 3. List out the job-wise maximum salary, minimum salary, and average salary of the employees.
SELECT JOB_ID, MAX(SALARY) AS MaxSalary, MIN(SALARY) AS MinSalary, AVG(SALARY) AS AvgSalary
FROM EMPLOYEE
GROUP BY JOB_ID;

-- 4. List out the number of employees who joined each month in ascending order.
SELECT DATEPART(MONTH, HIRE_DATE) AS JoinMonth, COUNT(*) AS NumEmployees
FROM EMPLOYEE
GROUP BY DATEPART(MONTH, HIRE_DATE)
ORDER BY JoinMonth ASC;

-- 5. List out the number of employees for each month and year in ascending order based on the year and month.
SELECT DATEPART(YEAR, HIRE_DATE) AS JoinYear, DATEPART(MONTH, HIRE_DATE) AS JoinMonth, COUNT(*) AS NumEmployees
FROM EMPLOYEE
GROUP BY DATEPART(YEAR, HIRE_DATE), DATEPART(MONTH, HIRE_DATE)
ORDER BY JoinYear ASC, JoinMonth ASC;

-- 6. List out the Department ID having at least four employees.
SELECT DEPARTMENT_ID
FROM EMPLOYEE
GROUP BY DEPARTMENT_ID
HAVING COUNT(*) >= 4;

-- 7. How many employees joined in the month of January?
SELECT COUNT(*) AS NumEmployees
FROM EMPLOYEE
WHERE DATEPART(MONTH, HIRE_DATE) = 1;

-- 8. How many employees joined in the month of January or September?
SELECT COUNT(*) AS NumEmployees
FROM EMPLOYEE
WHERE DATEPART(MONTH, HIRE_DATE) IN (1, 9);

-- 9. How many employees joined in 1985?
SELECT COUNT(*) AS NumEmployees
FROM EMPLOYEE
WHERE DATEPART(YEAR, HIRE_DATE) = 1985;

-- 10. How many employees joined each month in 1985?
SELECT DATEPART(MONTH, HIRE_DATE) AS JoinMonth, COUNT(*) AS NumEmployees
FROM EMPLOYEE
WHERE DATEPART(YEAR, HIRE_DATE) = 1985
GROUP BY DATEPART(MONTH, HIRE_DATE)
ORDER BY JoinMonth ASC;

-- 11. How many employees joined in March 1985?
SELECT COUNT(*) AS NumEmployees
FROM EMPLOYEE
WHERE DATEPART(MONTH, HIRE_DATE) = 3 AND DATEPART(YEAR, HIRE_DATE) = 1985;

-- 12. Which is the Department ID having greater than or equal to 3 employees joining in April 1985?
SELECT DEPARTMENT_ID
FROM EMPLOYEE
WHERE DATEPART(MONTH, HIRE_DATE) = 4 AND DATEPART(YEAR, HIRE_DATE) = 1985
GROUP BY DEPARTMENT_ID
HAVING COUNT(*) >= 3;

--Joins:
-- 1. List out employees with their department names.
SELECT E.*, D.Name AS Department_Name
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPARTMENT_ID = D.Department_Id;

-- 2. Display employees with their designations.
SELECT E.*, J.Designation
FROM EMPLOYEE E
JOIN JOB J ON E.JOB_ID = J.Job_ID;

-- 3. Display the employees with their department names and regional groups.
SELECT E.*, D.Name AS Department_Name, L.City AS Regional_Group
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPARTMENT_ID = D.Department_Id
JOIN LOCATION L ON D.Location_Id = L.Location_ID;

-- 4. How many employees are working in different departments? Display with department names.
SELECT D.Name AS Department_Name, COUNT(*) AS NumEmployees
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPARTMENT_ID = D.Department_Id
GROUP BY D.Name;

-- 5. How many employees are working in the sales department?
SELECT COUNT(*) AS NumEmployees
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPARTMENT_ID = D.Department_Id
WHERE D.Name = 'Sales';

-- 6. Which is the department having greater than or equal to 5 employees? Display the department names in ascending order.
SELECT D.Name AS Department_Name
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPARTMENT_ID = D.Department_Id
GROUP BY D.Name
HAVING COUNT(*) >= 5
ORDER BY D.Name ASC;

-- 7. How many jobs are there in the organization? Display with designations.
SELECT COUNT(*) AS NumJobs
FROM JOB;

-- 8. How many employees are working in "New York"?
SELECT COUNT(*) AS NumEmployees_NewYork
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPARTMENT_ID = D.Department_Id
JOIN LOCATION L ON D.Location_Id = L.Location_ID
WHERE L.City = 'New York';

-- 9. Display the employee details with salary grades. Use conditional statement to create a grade column.
SELECT E.*, 
    CASE 
        WHEN SALARY >= 5000 THEN 'A' 
        WHEN SALARY >= 4000 AND SALARY < 5000 THEN 'B' 
        WHEN SALARY >= 3000 AND SALARY < 4000 THEN 'C' 
        ELSE 'D' 
    END AS Salary_Grade
FROM EMPLOYEE E;

-- 10. List out the number of employees grade wise. Use conditional statement to create a grade column.
SELECT 
    CASE 
        WHEN SALARY >= 5000 THEN 'A' 
        WHEN SALARY >= 4000 AND SALARY < 5000 THEN 'B' 
        WHEN SALARY >= 3000 AND SALARY < 4000 THEN 'C' 
        ELSE 'D' 
    END AS Salary_Grade,
    COUNT(*) AS NumEmployees
FROM EMPLOYEE
GROUP BY Salary_Grade;

-- 11. Display the employee salary grades and the number of employees between 2000 to 5000 range of salary.
SELECT 
    CASE 
        WHEN SALARY >= 5000 THEN 'A' 
        WHEN SALARY >= 4000 AND SALARY < 5000 THEN 'B' 
        WHEN SALARY >= 3000 AND SALARY < 4000 THEN 'C' 
        ELSE 'D' 
    END AS Salary_Grade,
    COUNT(*) AS NumEmployees
FROM EMPLOYEE
WHERE SALARY BETWEEN 2000 AND 5000
GROUP BY Salary_Grade;

-- 12. Display all employees in sales or operation departments.
SELECT E.*
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPARTMENT_ID = D.Department_Id
WHERE D.Name IN ('Sales', 'Operations');

--SET Operators:
-- 1. List out the distinct jobs in sales and accounting departments.
SELECT DISTINCT J.Designation
FROM JOB J
INNER JOIN EMPLOYEE E ON J.Job_ID = E.JOB_ID
INNER JOIN DEPARTMENT D ON E.DEPARTMENT_ID = D.Department_Id
WHERE D.Name IN ('Sales', 'Accounting');

-- 2. List out all the jobs in sales and accounting departments.
SELECT J.Designation
FROM JOB J
INNER JOIN EMPLOYEE E ON J.Job_ID = E.JOB_ID
INNER JOIN DEPARTMENT D ON E.DEPARTMENT_ID = D.Department_Id
WHERE D.Name IN ('Sales', 'Accounting');

-- 3. List out the common jobs in research and accounting departments in ascending order.
SELECT J.Designation
FROM JOB J
INNER JOIN EMPLOYEE E ON J.Job_ID = E.JOB_ID
INNER JOIN DEPARTMENT D ON E.DEPARTMENT_ID = D.Department_Id
WHERE D.Name = 'Research'
AND J.Designation IN (
    SELECT J.Designation
    FROM JOB J
    INNER JOIN EMPLOYEE E ON J.Job_ID = E.JOB_ID
    INNER JOIN DEPARTMENT D ON E.DEPARTMENT_ID = D.Department_Id
    WHERE D.Name = 'Accounting'
)
ORDER BY J.Designation ASC;

--Subqueries
-- 1. Display the employees list who got the maximum salary.
SELECT *
FROM EMPLOYEE
WHERE SALARY = (SELECT MAX(SALARY) FROM EMPLOYEE);

-- 2. Display the employees who are working in the sales department.
SELECT *
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPARTMENT_ID = D.Department_Id
WHERE D.Name = 'Sales';

-- 3. Display the employees who are working as 'Clerk'.
SELECT *
FROM EMPLOYEE E
JOIN JOB J ON E.JOB_ID = J.JOB_ID
WHERE J.Designation = 'Clerk';

-- 4. Display the list of employees who are living in "New York".
SELECT *
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPARTMENT_ID = D.Department_Id
JOIN LOCATION L ON D.Location_Id = L.Location_ID
WHERE L.City = 'New York';

-- 5. Find out the number of employees working in the sales department.
SELECT COUNT(*) AS NumEmployees
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPARTMENT_ID = D.Department_Id
WHERE D.Name = 'Sales';

-- 6. Update the salaries of employees who are working as clerks on the basis of 10%.
UPDATE EMPLOYEE
SET SALARY = SALARY * 1.1
WHERE JOB_ID IN (SELECT JOB_ID FROM JOB WHERE Designation = 'Clerk');

-- 7. Delete the employees who are working in the accounting department.
DELETE FROM EMPLOYEE
WHERE DEPARTMENT_ID IN (SELECT Department_Id FROM DEPARTMENT WHERE Name = 'Accounting');

-- 8. Display the second highest salary drawing employee details.
SELECT TOP 1 *
FROM (
    SELECT DISTINCT TOP 2 *
    FROM EMPLOYEE
    ORDER BY SALARY DESC
) AS SecondHighestSalary
ORDER BY SALARY ASC;

-- 9. Display the nth highest salary drawing employee details.
DECLARE @N INT = 3; -- Specify the value of N
SELECT TOP 1 *
FROM (
    SELECT DISTINCT TOP (@N) *
    FROM EMPLOYEE
    ORDER BY SALARY DESC
) AS NthHighestSalary
ORDER BY SALARY ASC;

-- 10. List out the employees who earn more than every employee in department 30.
SELECT *
FROM EMPLOYEE
WHERE SALARY > ALL (SELECT SALARY FROM EMPLOYEE WHERE DEPARTMENT_ID = 30);

-- 11. List out the employees who earn more than the lowest salary in department. Find out whose department has no employees.
SELECT *
FROM EMPLOYEE
WHERE SALARY > (SELECT MIN(SALARY) FROM EMPLOYEE WHERE DEPARTMENT_ID = EMPLOYEE.DEPARTMENT_ID);

-- 12. Find out which department has no employees.
SELECT *
FROM DEPARTMENT
WHERE Department_Id NOT IN (SELECT DISTINCT DEPARTMENT_ID FROM EMPLOYEE);

-- 13. Find out the employees who earn greater than the average salary for their department.
SELECT *
FROM EMPLOYEE E
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEE WHERE DEPARTMENT_ID = E.DEPARTMENT_ID);












