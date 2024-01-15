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