USE assignment;
SELECT * FROM employees; 
SELECT salary FROM employees; 
SELECT DISTINCT job_name FROM employees; 
SELECT emp_name, FORMAT(1.15*salary, 'C') AS "Revised Salary" FROM employees;
SELECT CONCAT(emp_name, '    ', job_name) AS "Employee & Job" FROM employees;
SELECT CONCAT(emp_name, '(', LOWER(job_name), ')') AS "Employee" FROM employees;
SELECT emp_name, DATE_FORMAT(hire_date,'%M%d,%Y') AS formated_hire_date FROM employees;
SELECT LENGTH(TRIM(emp_name)) FROM employees;
SELECT emp_id,salary,commission FROM employees;
SELECT DISTINCT dep_id, job_name FROM employees;
SELECT * FROM employees WHERE dep_id NOT IN (2001);
SELECT * FROM employees WHERE hire_date < ('1991-1-1');
SELECT AVG(salary) FROM employees WHERE job_name = 'ANALYST';
SELECT * FROM employees WHERE emp_name = 'BLAZE';
SELECT * FROM employees WHERE commission > salary;
SELECT * FROM employees WHERE (1.25*salary)>3000;
SELECT * FROM employees WHERE LENGTH(emp_name)=6;
SELECT * FROM employees WHERE month(hire_date)=01;
SELECT concat(e.emp_name , ' works for ' , m.emp_name) as result FROM employees e, employees m 
WHERE e.manager_id = m.emp_id;
SELECT * FROM employees WHERE job_name = 'CLERK';
SELECT * FROM employees WHERE DATEDIFF(CURRENT_DATE(), hire_date)>27;
SELECT *FROM employees WHERE salary < 3500;
SELECT emp_name, job_name, salary FROM employees WHERE job_name = 'ANALYST';
SELECT * FROM employees WHERE YEAR(hire_date) = '1991';
SELECT emp_name, emp_id, hire_date, salary FROM employees WHERE hire_date < '1991-04-01';
SELECT emp_name, job_name FROM employees WHERE manager_id IS NULL;
SELECT * FROM employees WHERE hire_date = '1991-05-01';
SELECT emp_id, emp_name, salary, DATEDIFF(CURRENT_DATE(), hire_date)/365 AS Experience FROM employees WHERE 
manager_id = 68319;
SELECT emp_id, emp_name, salary, DATEDIFF(CURRENT_DATE, hire_date) AS Experence FROM employees
WHERE (salary/30)>100;
SELECT emp_name FROM employees WHERE DATEDIFF('1999-12-31', hire_date)/365>8;
SELECT * FROM employees WHERE salary % 2 != 0;
select * from employees where (salary/10)>=10 and ((salary/10)/10)<10;
SELECT * FROM employees WHERE salary >= 100 AND salary < 1000;
SELECT * FROM employees WHERE Month(hire_date) = 04;
SELECT * FROM employees WHERE Day(hire_date) < '19';
SELECT *FROM employees WHERE job_name = 'SALESMAN' AND DATEDIFF(CURRENT_DATE, hire_date)/30 > 10;
SELECT * FROM employees WHERE dep_id IN (3001,1001) AND YEAR(hire_date) = '1991';
SELECT * FROM employees WHERE dep_id IN (1001,2001);
SELECT * FROM employees WHERE job_name = 'CLERK' AND dep_id = 2001;
SELECT emp_id, emp_name, salary, job_name FROM employees WHERE job_name = 'SALESMAN' AND dep_id = 3001
AND 12*(salary + commission) < 34000 AND commission IS NOT NULL AND commission < salary;
SELECT * FROM employees WHERE job_name IN ('CLERK','MANAGER');
SELECT * FROM employees WHERE MONTH(hire_date) != 02;
SELECT * FROM employees WHERE hire_date BETWEEN '1991-01-01' AND '1991-12-31';
SELECT * FROM employees WHERE hire_date BETWEEN '1991-06-01' AND '1991-06-30';
SELECT * FROM employees WHERE 12*salary BETWEEN 24000 AND 50000;
SELECT * FROM employees WHERE DATE_FORMAT(hire_date, '%d-%b-%y') IN ('01-MAY-91', '20-FEB-91', '03-DEC-91');
SELECT * FROM employees WHERE manager_id IN (63679,68319,66564,69000);
SELECT * FROM employees WHERE hire_date BETWEEN '1992-07-01' AND '1992-12-31';
SELECT * FROM employees WHERE YEAR(hire_date) BETWEEN '1990' AND '1999';
SELECT * FROM employees WHERE job_name = 'MANAGER' AND dep_id IN (1001,2001);
SELECT * FROM employees WHERE MONTH(hire_date) = 02 AND salary BETWEEN 1001 AND 2000;
SELECT * FROM employees WHERE YEAR(hire_date) NOT IN ('1991');
SELECT e.emp_id, e.emp_name, e.job_name, e.manager_id, e.hire_date, e.salary, e.commission, e.dep_id, d.dep_name
FROM employees e, department d WHERE e.dep_id = d.dep_id;
SELECT e.emp_name, e.job_name, (12*e.salary)"Annual Salary", e.dep_id, d.dep_name, s.grade 
FROM employees e, department d, salary_grade s WHERE e.dep_id = d.dep_id AND e.salary BETWEEN
s.min_salary AND s.max_salary AND (((12*e.salary)>=60000) or (e.job_name != 'ANALYST'));
SELECT w.emp_name, w.job_name, w.manager_id, w.salary, m.emp_name "MANAGER", m.emp_id, m.salary "MANAGER-Salary"
FROM employees w, employees m WHERE w.manager_id AND w.salary > m.salary;
SELECT e.emp_name, e.dep_id, e.salary, e.commission FROM employees e, department d WHERE e.dep_id = d.dep_id
AND d.dep_location = 'PERTH' AND e.salary BETWEEN 2000 AND 5000;
SELECT s.grade, e.emp_name FROM employees e, salary_grade s WHERE e.dep_id IN (1001, 3001) AND
hire_date < ('1992-12-31') AND (e.salary BETWEEN s.min_salary AND s.max_salary AND s.grade NOT IN (4));
SELECT w.emp_id, w.emp_name, w.job_name, w.manager_id, w.hire_date, w.salary, w.dep_id, m.emp_name
FROM employees w, employees m WHERE w.manager_id = m.emp_id AND m.emp_name = 'JONAS';
SELECT e.emp_name, e.salary FROM employees e, salary_grade s WHERE e.emp_name = 'FRANK' AND e.salary
BETWEEN s.min_salary AND s.max_salary AND e.salary = s.max_salary;
SELECT * FROM employees WHERE job_name IN ('MANAGER', 'ANALYST') AND salary BETWEEN 2000 AND 5000
AND commission IS NULL;
SELECT e.emp_id, e.emp_name, e.dep_id,e.salary, d.dep_location FROM employees e, department d 
WHERE e.dep_id = d.dep_id AND d.dep_location IN ('PERTH', 'MELBOURNE') AND DATEDIFF(CURRENT_DATE, hire_date)/365 > 10;
SELECT e.emp_id, e.emp_name, e.dep_id, e.salary, d.dep_location FROM employees e, department d WHERE
e.dep_id = d.dep_id AND d.dep_location IN ('SYDNEY', 'MELBOURNE') AND YEAR(e.hire_date) = '1991'
AND e.salary BETWEEN 2000 AND 5000;
SELECT e.dep_id, e.emp_id, e.emp_name, e.salary, d.dep_name, d.dep_location, s.grade FROM employees e, 
department d, salary_grade s WHERE e.dep_id = d.dep_id AND d.dep_name = 'MARKETING' AND d.dep_location IN 
('MELBOURNE', 'PERTH') AND e.salary BETWEEN s.min_salary AND s.max_salary AND s.grade IN (3,4,5) AND
DATEDIFF(CURRENT_DATE, hire_date)/356 > 5;
SELECT * FROM employees w, employees m WHERE w.manager_id = m.emp_id AND w.hire_date < m.hire_date;
SELECT * FROM employees e, salary_grade s WHERE e.salary BETWEEN s.min_salary AND s.max_salary AND s.grade = 4;
SELECT e.emp_name FROM employees e, department d, salary_grade s WHERE e.dep_id = d.dep_id AND
d.dep_name IN ('PRODUCTION', 'AUDIT') AND e.emp_name NOT IN ('MARKER', 'ADELYN') AND YEAR(hire_date) = '1991'
AND e.salary BETWEEN s.min_salary AND s.max_salary;
SELECT * FROM employees ORDER BY salary ASC;
SELECT * FROM employees ORDER BY dep_id ASC, job_name DESC;
SELECT DISTINCT job_name FROM employees ORDER BY job_name DESC;
SELECT emp_id, emp_name, salary Monthly_Salary, salary/30 Daily_Salary, 12*salary Annual_Salary FROM employees
ORDER BY Annual_Salary ASC;
SELECT * FROM employees WHERE job_name IN ('CLERK','ANALYST') ORDER BY job_name DESC;
SELECT dep_location FROM department d, employees e WHERE e.dep_id = d.dep_id AND e.emp_name ='CLARE';
SELECT * FROM employees WHERE hire_date IN ('1991-05-01','1991-12-03','1990-01-19') ORDER BY hire_date ASC; 
SELECT * FROM employees WHERE salary < 1000 ORDER BY salary;
SELECT * FROM employees ORDER BY salary ASC;
SELECT * FROM employees ORDER BY job_name ASC, emp_id DESC;
SELECT DISTINCT job_name FROM employees WHERE dep_id IN (2001,3001) ORDER BY job_name DESC;
SELECT * FROM employees WHERE job_name NOT IN ('PRESIDENT', 'MANAGER') ORDER BY salary ASC;
SELECT * FROM employees WHERE (12*salary) < 25000 ORDER BY salary ASC;
SELECT e.emp_id, e.emp_name, (12*salary) "Annual_Salary", salary/30 "Daily_Salary" FROM employees e WHERE 
e.job_name = 'SALESMAN' ORDER BY "Annual_Salary" ASC;
SELECT emp_id, emp_name, hire_date, current_date(), DATEDIFF(CURRENT_DATE(), hire_date)/365 AS 'Experience' 
FROM employees ORDER BY 'Experience' ASC;
SELECT * FROM employees WHERE hire_date > ('1991-06-30') AND YEAR(hire_date) = '1991' ORDER BY job_name ASC;
SELECT * FROM employees e, department d WHERE e.dep_id = d.dep_id AND dep_name IN ('FINANCE', 'AUDIT') ORDER BY
e.dep_id ASC;
SELECT e.emp_name, e.job_name, e.dep_id, e.salary, d.dep_name, s.grade FROM employees e, department d, salary_grade s
WHERE e.dep_id = d.dep_id AND e.salary BETWEEN s.min_salary AND s.max_salary ORDER BY dep_id ASC;
SELECT e.emp_name, e.job_name, e.salary, e.dep_id, d.dep_name, s.grade FROM employees e, department d, salary_grade s
WHERE e.dep_id = d.dep_id AND e.salary BETWEEN s.min_salary AND s.max_salary AND job_name != 'CLERK' 
ORDER BY e.salary DESC;
SELECT e.emp_id, e.emp_name, e.salary, d.dep_name, s.grade, DATEDIFF(CURRENT_DATE(), hire_date)/362 AS 
"EXPERIENCE", 12*e.salary "Annual Salary" FROM employees e, department d, salary_grade s WHERE e.dep_id = d.dep_id
AND e.dep_id IN (1001,2001) AND e.salary BETWEEN s.min_salary AND s.max_salary;
SELECT * FROM employees e, department d WHERE e.dep_id = d.dep_id;
SELECT * FROM employees w, employees m WHERE w.emp_id= m.manager_id AND w.hire_date> m.hire_date;
SELECT emp_id, emp_name, salary, dep_id FROM employees WHERE dep_id = 1001 ORDER BY salary ASC;
SELECT MAX(salary) FROM employees;
SELECT job_name, AVG(salary), AVG(salary + commission) FROM employees GROUP BY job_name;
SELECT job_name, SUM(12*salary) FROM employees WHERE YEAR(hire_date) = '1991' GROUP BY job_name;
SELECT e.emp_id, e.emp_name, d.dep_id, d.dep_location FROM employees e, department d WHERE e.dep_id = d.dep_id;
SELECT e.emp_id, e.emp_name, e.dep_id, d.dep_name, d.dep_location FROM employees e, department d 
WHERE e.dep_id = d.dep_id AND e.dep_id IN (1001,2001);
SELECT e.emp_id, e.emp_name, e.salary, s.grade FROM employees e, salary_grade s WHERE e.salary BETWEEN 
s.min_salary AND s.max_salary;
SELECT w.manager_id, count(*) FROM employees w, employees m WHERE w.manager_id = m.emp_id GROUP BY w.manager_id
ORDER BY w.manager_id ASC;
SELECT dep_id, job_name, COUNT(*) FROM employees GROUP BY dep_id, job_name;
SELECT dep_id, COUNT(*) FROM employees GROUP BY dep_id HAVING COUNT(*) >= 2;
SELECT s.grade, COUNT(*), MAX(salary) FROM employees e, salary_grade s WHERE e.salary BETWEEN s.min_salary
AND s.max_salary GROUP BY s.grade;
SELECT d.dep_name, s.grade, count(*) FROM employees e, department d, salary_grade s WHERE e.dep_id = d.dep_id
AND e.salary BETWEEN s.min_salary AND s.max_salary AND e.job_name = 'SALESMAN' GROUP BY d.dep_name, s.grade
HAVING COUNT(*) >= 2;
SELECT dep_id, COUNT(*) FROM employees GROUP BY dep_id HAVING COUNT(*) < 4;
SELECT d.dep_name, COUNT(*) FROM employees e, department d WHERE e.dep_id = d.dep_id GROUP BY 
d.dep_name HAVING COUNT(*) >= 2;
SELECT emp_id, COUNT(*) FROM employees GROUP BY emp_id;
SELECT dep_id, COUNT(*), AVG(salary), job_name FROM employees GROUP BY dep_id, job_name;
SELECT emp_name FROM employees WHERE emp_name LIKE 'A%' AND LENGTH(TRIM(emp_name)) = 6;
SELECT emp_name FROM employees WHERE emp_name LIKE '__R%' AND LENGTH(TRIM(emp_name)) = 6;
SELECT * FROM employees WHERE emp_name LIKE 'A%N' AND LENGTH(TRIM(emp_name)) = 6;
SELECT * FROM employees WHERE FORMAT(hire_date, 'MMM') LIKE '_a%';
SELECT * FROM employees WHERE emp_name LIKE '%AR%';
SELECT * FROM employees WHERE YEAR(hire_date) LIKE '199%';
SELECT * FROM employees WHERE emp_id NOT LIKE '68%';
SELECT * FROM employees WHERE emp_name LIKE '%A%';
SELECT * FROM employees WHERE emp_name LIKE '%S' AND LENGTH(TRIM(emp_name)) = 6;
SELECT * FROM employees WHERE MONTHNAME(hire_date)  LIKE '%A%';
SELECT * FROM employees WHERE SUBSTRING(MONTHNAME(hire_date), 1, 3) LIKE '%A%';
SELECT * FROM employees WHERE MONTHNAME(hire_date) LIKE '_A%';