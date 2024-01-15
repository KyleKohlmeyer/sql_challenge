-- Reset tables in case they already exist
DROP TABLE IF EXISTS employees, departments, dept_emp, dept_manager, salaries, titles;

-- Create the new tables using the Entity Relationship Diagram
-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/2JWmAI
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

-- Edited export of ERD to simplified primary and foreign key designations
-- Removed quotes from table names and columns

CREATE TABLE titles (
    Title_id VARCHAR(5) NOT NULL,
    Title VARCHAR(30) NOT NULL,
    PRIMARY KEY (Title_id)
);

CREATE TABLE employees (
    Emp_no INTEGER NOT NULL,
    Emp_title_id VARCHAR(10) NOT NULL,
    Birth_date VARCHAR(15) NOT NULL,
    First_name VARCHAR(30) NOT NULL,
    Last_name VARCHAR(30) NOT NULL,
    Sex VARCHAR(1) NOT NULL,
    Hire_date VARCHAR(15) NOT NULL,
	PRIMARY KEY (Emp_no),
	FOREIGN KEY (Emp_title_id) References titles(Title_id)
);

CREATE TABLE departments (
    Dept_no VARCHAR(4) NOT NULL,
    Dept_name VARCHAR(30) NOT NULL,
    PRIMARY KEY (Dept_no)
);

CREATE TABLE dept_emp (
    Emp_no INTEGER NOT NULL,
    Dept_no VARCHAR(4) NOT NULL,
	FOREIGN KEY (Emp_no) References employees(Emp_no),
	FOREIGN KEY (Dept_no) References departments(Dept_no),
	PRIMARY KEY (Emp_no, Dept_no)
);

CREATE TABLE dept_manager (
    Dept_no VARCHAR(4) NOT NULL,
    Emp_no INTEGER NOT NULL,
	FOREIGN KEY (Dept_no) References departments(Dept_no),
	FOREIGN KEY (Emp_no) References employees(Emp_no),
	PRIMARY KEY (Emp_no, Dept_no)
);

CREATE TABLE salaries (
    Salary INTEGER NOT NULL,
	Emp_no INTEGER NOT NULL,
	FOREIGN KEY (Emp_no) References employees(Emp_no),
	PRIMARY KEY (Salary, Emp_no)
);

--This analysis was done using the tables made from the schema

-- Create table with employee info and salary
SELECT employees.emp_no AS "Employee Number", 
  employees.last_name AS "Last Name", 
  employees.first_name AS "First Name", 
  employees.sex AS "Sex", 
  salaries.salary AS "Salary"
FROM employees
INNER JOIN salaries ON
employees.emp_no = salaries.emp_no;

-- Create table for employees hired in 1986
SELECT employees.first_name AS "First Name",  
  employees.last_name AS "Last Name", 
  employees.hire_date AS "Hire Date"
FROM employees
Where hire_date LIKE '%/1986';

-- Make department managers table
SELECT departments.dept_name AS "Department Name",
  dept_manager.dept_no AS "Department Number",
  employees.last_name AS "Last Name", 
  employees.first_name AS "First Name", 
  employees.emp_no AS "Employee Number" 
FROM dept_manager
INNER JOIN employees ON
dept_manager.emp_no = employees.emp_no
INNER JOIN departments ON
dept_manager.dept_no = departments.dept_no;

-- Make employee department table
SELECT employees.emp_no AS "Employee Number" , 
  employees.last_name AS "Last Name", 
  employees.first_name AS "First Name", 
  dept_emp.dept_no AS "Department Number",
  departments.dept_name AS "Department Name"
FROM dept_emp
INNER JOIN employees ON
dept_emp.emp_no = employees.emp_no
INNER JOIN departments ON
dept_emp.dept_no = departments.dept_no;

-- Finding employees named Hercules with last name starting with B
SELECT employees.first_name AS "First Name",
  employees.last_name AS "Last Name", 
  employees.sex AS "Sex"
 FROM employees
 WHere first_name = 'Hercules' AND last_name LIKE 'B%';
 
 -- Finding employees in the sales department
SELECT employees.emp_no AS "Employee Number", 
  employees.last_name AS "Last Name", 
  employees.first_name AS "First Name" 
FROM dept_emp
INNER JOIN employees ON
dept_emp.emp_no = employees.emp_no
INNER JOIN departments ON
dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales' 
 
 -- Finding employees in the sales and development departments
SELECT employees.emp_no AS "Employee Number", 
  employees.last_name AS "Last Name", 
  employees.first_name AS "First Name",  
  departments.dept_name AS "Department Name"
FROM dept_emp
INNER JOIN employees ON
dept_emp.emp_no = employees.emp_no
INNER JOIN departments ON
dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales' OR departments.dept_name = 'Development';

-- Last name frequency counts
SELECT last_name AS "Last Name", COUNT(last_name) AS "Frequency"
FROM employees
GROUP BY last_name
ORDER BY "Frequency" DESC;