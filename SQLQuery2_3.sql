CREATE DATABASE Employee_database;
USE Employee_database;


CREATE TABLE employee (
  employee_name  VARCHAR(255) PRIMARY KEY,
  street         VARCHAR(255) NOT NULL,
  city           VARCHAR(255) NOT NULL
);

CREATE TABLE works (
  employee_name  VARCHAR(255) PRIMARY KEY,
  company_name   VARCHAR(255) NOT NULL,
  salary         INT NOT NULL,
  FOREIGN KEY (employee_name) REFERENCES employee(employee_name) 
);

CREATE TABLE company (
  company_name   VARCHAR(255) PRIMARY KEY,
  city           VARCHAR(255) NOT NULL
);

CREATE TABLE manages (
  employee_name  VARCHAR(255) PRIMARY KEY,
  manager_name   VARCHAR(255) NOT NULL,
  FOREIGN KEY (employee_name) REFERENCES employee(employee_name), 
);

--INSERTING DATAS INTO THE TABLE
INSERT INTO employee (employee_name, street, city)
VALUES ('John', '123 Main St', 'New York'),
       ('Jane', '456 Market St', 'Chicago'),
       ('Bob', '789 Park Ave', 'New York'),
       ('Alice', '321 Maple St', 'Chicago');
       
INSERT INTO works (employee_name, company_name, salary)
VALUES ('John', 'First Bank Corporation', 75000),
       ('Jane', 'First Bank Corporation', 80000),
       ('Bob', 'Second National Bank', 90000),
       ('Alice', 'Chicago Financial Group', 65000);
       
INSERT INTO company(company_name, city)
VALUES ('First Bank Corporation', 'New York'),
       ('Second National Bank', 'New York'),
       ('Chicago Financial Group', 'Chicago');
       
INSERT INTO manages (employee_name, manager_name)
VALUES ('John', 'Jane'),
       ('Bob', 'Jane'),
       ('Alice', 'John');

SELECT * FROM employee;


--2(a) Find the names of all employees who work for First Bank Corporation:
SELECT e.employee_name
FROM employee e
JOIN works w ON e.employee_name = w.employee_name
JOIN company c ON w.company_name = c.company_name
WHERE c.company_name = 'First Bank Corporation';

--(b) Find the names and cities of residence of all employees who work for First Bank Corporation:
SELECT e.employee_name, e.city
FROM employee e
JOIN works w ON e.employee_name = w.employee_name
JOIN company c ON w.company_name = c.company_name
WHERE c.company_name = 'First Bank Corporation';

--(c) Find the names, street addresses, and cities of residence of all employees who work for First Bank Corporation and earn more than $10,000:

SELECT e.employee_name, e.street, e.city
FROM employee e
JOIN works w ON e.employee_name = w.employee_name
JOIN company c ON w.company_name = c.company_name
WHERE c.company_name = 'First Bank Corporation' AND w.salary > 10000;

--2(d) Find all employees in the database who live in the same cities as the companies for which they work:
SELECT e.employee_name
FROM employee e
JOIN works w ON e.employee_name = w.employee_name
JOIN company c ON w.company_name = c.company_name
WHERE e.city = c.city;

--(e) Find all employees in the database who live in the same cities and on the same streets as do their managers:
SELECT e.employee_name
FROM employee e
JOIN manages m ON e.employee_name = m.employee_name
JOIN employee mgr ON m.manager_name = mgr.employee_name
WHERE e.city = mgr.city AND e.street = mgr.street;

--(f) Find all employees in the database who do not work for First Bank Corporation:
SELECT e.employee_name
FROM employee e
JOIN works w ON e.employee_name = w.employee_name
JOIN company c ON w.company_name = c.company_name
WHERE c.company_name != 'First Bank Corporation';

--(g) Find all employees in the database who earn more than each employee of Small Bank Corporation:
SELECT e.employee_name
FROM employee e
JOIN works w ON e.employee_name = w.employee_name
JOIN company c ON w.company_name = c.company_name
WHERE e.salary > (
  SELECT salary
  FROM works
  JOIN company ON works.company_name = company.company_name
  WHERE company.company_name = 'Small Bank Corporation'
);

--(h) Find all companies located in every city in which Small Bank Corporation is located:
SELECT c1.company_name
FROM company c1
JOIN company c2 ON c1.city = c2.city
WHERE c2.company_name = 'Small Bank Corporation';

--(i) Find all employees who earn more than the average salary of all employees of their company:
SELECT e.employee_name
FROM employee e
JOIN works w ON e.employee_name = w.employee_name
WHERE w.salary > (
  SELECT AVG(salary)
  FROM works
  WHERE works.company_name = w.company_name
);

--(j) Find the company that has the most employees:


--(k) Find the company that has the smallest payroll:
SELECT company_name, SUM(salary) AS total_payroll
FROM works
GROUP BY company_name
ORDER BY total_payroll ASC
LIMIT 1;

--(l) Find those companies whose employees earn a higher salary, on average, than the average salary at First Bank Corporation:
SELECT c.company_name
FROM company c
JOIN works w ON c.company_name = w.company_name
GROUP BY c.company_name
HAVING AVG(w.salary) > (
  SELECT AVG(salary)
  FROM works
  JOIN company ON works.company_name = company.company_name
  WHERE company.company_name = 'First Bank Corporation'
);



--3. 

--(a) Modify the database so that Jones now lives in Newtown.
UPDATE employee
SET city = 'Newtown'
WHERE employee_name = 'Jones';

--(b) Give all employees of First Bank Corporation a 10 percent raise:
UPDATE works
SET salary = salary * 1.1
WHERE company_name = 'First Bank Corporation';

--(c) Give all managers of First Bank Corporation a 10 percent raise:
UPDATE works 
SET 
    salary = salary * 1.1
WHERE
    employee_name = ANY (SELECT DISTINCT
            manager_name
        FROM
            manages)
        AND company_name = 'First Bank Corporation';

--(d) Give all managers of First Bank Corporation a 10 percent raise unless the salary becomes greater than $100,000; in such cases, give only a 3 percent raise:
UPDATE employee e
SET e.salary = CASE
  WHEN e.salary <= 100000 THEN e.salary * 1.1
  ELSE e.salary * 1.03
END
FROM works w
WHERE e.employee_name = w.employee_name
AND w.company_name = 'First Bank Corporation'
AND e.employee_name IN (
  SELECT employee_name
  FROM manages
);

--(e) Delete all tuples in the works relation for employees of Small Bank Corporation:
DELETE FROM works
WHERE company_name = 'Small Bank Corporation';


