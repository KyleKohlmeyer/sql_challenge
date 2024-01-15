-- Reset tables in case they already exist
DROP TABLE IF EXISTS employees, departments, dept_emp, dept_manager, salaries, titles;

-- Create the new tables using the Entity Relationship Diagram
-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/2JWmAI
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

-- Edited export of ERD to simplified primary and foreign key designations
-- Added composite keys to tables without previous primary keys
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

-- The data was imported after this step
-- Make sure to check if it was imported correctly