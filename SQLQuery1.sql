/* Q.N0.1 Give an SQL schema denition for the employee database of Figure 5. Choose an appropriate
primary key for each relation schema, and insert any other integrity constraints (for example,
foreign keys) you nd necessary.*/

--Integrity Constraints in SQL(ensure accuracy and consistency in the data)

--1. NOT NULL (specifies that a column cannot contain a NULL value)
--2. UNIQUE (ensures that all values in a column are unique)
--3. PRIMARY KEY (uniquely identifies each row in the table, cannot contain NULL values and must be unique)
/*4. FOREIGN KEY (specifies column in a table (the child table) references a column in another table (the parent table). 
                This is used to enforce referential integrity between the two tables.)*/
--5. CHECK (pecify a condition that must be met by the data in a column)
--6. DEFAULT (specifies a default value for a column, 
--             If no value is provided for the column when a new row is inserted, the default value will be used)

CREATE DATABASE Employee_database;

CREATE TABLE employee (
  employee_name		CHAR(50) PRIMARY KEY,
  street			VARCHAR(40) NOT NULL,
  city				char(50) NOT NULL	,
  UNIQUE (city)
);

CREATE TABLE company (
  company_name	CHAR(40) PRIMARY KEY,
  city			VARCHAR(40) NOT NULL
);

CREATE TABLE work (
  employee_name     CHAR(50) ,
  FOREIGN KEY (employee_name) REFERENCES employee(employee_name),

  company_name		CHAR(40) NOT NULL,
  FOREIGN KEY (company_name) REFERENCES company(company_name) ,
  salary			VARCHAR(50),
  
  CHECK (salary>0)
);

CREATE TABLE manager (
  employee_name CHAR(50)
  FOREIGN KEY (employee_name) REFERENCES employee(employee_name) ,
  manager		VARCHAR(40) NOT NULL
);

DROP TABLE manager,employee,company,work;

SELECT * FROM employee;