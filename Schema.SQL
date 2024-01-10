mployees
-
Emp_no INTEGER PK
Emp_title_id VARCHAR FK >- titles.Title_id
Birth_date VARCHAR
First_name VARCHAR
Last_name VARCHAR
Sex VARCHAR
Hire_date VARCHAR

departments
-
Dept_no VARCHAR PK
Dept_name VARCHAR

dept_emp
-
Emp_no INTEGER FK >- employees.EMP_no
Dept_no VARCHAR FK >- departments.Dept_no

dept_manager
-
Dept_no VARCHAR FK >- departments.Dept_no
Emp_no INTEGER FK >- employees.EMP_no

salaries
-
Emp_no INTEGER FK - employees.EMP_no
Salary INTEGER

titles
-
Title_id VARCHAR PK
Title VARCHAR