CREATE DATABASE Assignment;
SHOW DATABASES;
USE Assignment;
CREATE TABLE Department(
dep_id INT PRIMARY KEY,
dep_name VARCHAR(20),
dep_location VARCHAR(15));
CREATE TABLE Employees(
emp_id INT PRIMARY KEY,
emp_name VARCHAR(15) NOT NULL,
job_name VARCHAR(10) NOT NULL,
manager_id INT,
hire_date DATE NOT NULL,
salary DECIMAL(10,2),
commission DECIMAL(7,2),
dep_id INT,
FOREIGN KEY (dep_id) REFERENCES Department (dep_id));
CREATE TABLE Salary_grade(
grade INT PRIMARY KEY,
min_salary INT,
max_salary INT);
INSERT INTO Department VALUES(1001, 'Finance', 'SYDNEY');
INSERT INTO Department VALUES(2001, 'Audit', 'MELBOURNE');
INSERT INTO Department VALUES(3001, 'Marketing', 'PERTH');
INSERT INTO Department VALUES(4001, 'Production', 'BRISBANE');
SELECT * FROM Department;
INSERT INTO Employees VALUES(68319, 'KAYLING', 'PRESIDENT', NULL, '1991-11-18', 6000, NULL, 1001);
INSERT INTO Employees VALUES(66928, 'BLAZE', 'MANAGER', 68319, '1991-05-01', 2750, NULL, 3001);
INSERT INTO Employees VALUES(67832, 'CLARE', 'MANAGER', 68319, '1991-05-09', 2550, NULL, 1001);
INSERT INTO Employees VALUES(65646, 'JONAS', 'MANAGER', 68319, '1991-04-02', 2957, NULL, 2001);
INSERT INTO Employees VALUES(64989, 'ADELYN', 'SALESMAN', 66928, '1991-02-20', 1700, 400, 3001);
INSERT INTO Employees VALUES(65271, 'WADE', 'SALESMAN', 66928, '1991-02-22', 1350, 600, 3001);
INSERT INTO Employees VALUES(66564, 'MADDEN', 'SALESMAN', 66928, '1991-09-28', 1350, 1500, 3001);
INSERT INTO Employees VALUES(68454, 'TUCKER', 'SALESMAN', 66928, '1991-09-08', 1600, 0, 3001);
INSERT INTO Employees VALUES(68736, 'ADNRES', 'CLERK', 67858, '1997-05-23', 1200, NULL, 2001);
INSERT INTO Employees VALUES(69000, 'JULIUS', 'CLERK', 66928, '1991-12-03', 1050, NULL, 3001);
INSERT INTO Employees VALUES(69324, 'MARKER', 'CLERK', 67832, '1992-01-23', 1400, NULL, 1001);
INSERT INTO Employees VALUES(67858, 'SCARLET', 'ANALYST', 65646, '1997-04-19',3100, NULL, 2001);
INSERT INTO Employees VALUES(69062, 'FRANK', 'ANALYST', 65646, '1991-12-03', 3100, NULL, 2001);
INSERT INTO Employees VALUES(63679, 'SANDRINE', 'CLERK', 69062, '1990-12-18', 900, NULL, 2001);
SELECT * FROM Employees;
INSERT INTO Salary_grade VALUES(1, 800,1300);
INSERT INTO Salary_grade VALUES(2,1301,1500);
INSERT INTO Salary_grade VALUES(3, 1501,2100);
INSERT INTO Salary_grade VALUES(4,2101,3100);
INSERT INTO Salary_grade VALUES(5,3101,9999);
SELECT * FROM Salary_grade;
SHOW TABLES;
SELECT * FROM Employees WHERE job_name = 'manager';
SELECT DISTINCT manager_id from Employees;
SELECT * FROM Employees WHERE emp_id IN (SELECT DISTINCT manager_id FROM Employees);
SELECT * FROM employees WHERE emp_id IN (SELECT manager_id FROM employees); 

SELECT emp_id, emp_name, job_name, hire_date,
(DATEDIFF(CURRENT_DATE(), hire_date)/365) 'Years',
((DATEDIFF(CURRENT_DATE(), hire_date))%365)/30'Months',
((DATEDIFF(CURRENT_DATE(), hire_date))%30) 'Days'
FROM employees WHERE emp_id IN (SELECT manager_id FROM employees);

USE assignment;
SELECT e.emp_id, e.emp_name, e.salary, d.dep_name 
FROM employees e JOIN department d ON e.dep_id = d.dep_id 
WHERE d.dep_location IN ('SYDNEY', 'PERTH')
AND e.job_name IN ('MANAGER', 'ANALYST')
AND(DATEDIFF(current_date(), hire_date)/365 >5)
AND e.commission IS NULL
ORDER BY d.dep_location ASC;

SELECT e.emp_id, e.emp_name, e.salary, d.dep_name FROM employees e JOIN department d ON e.dep_id = d.dep_id 
WHERE d.dep_location IN ('SYDNEY', 'PERTH') AND e.emp_id IN 
(SELECT e.emp_id FROM employees e WHERE e.job_name IN ('MANAGER', 'ANALYST')
AND (DATEDIFF(current_date(), hire_date)/365 >5) AND e.commission IS NULL)
ORDER BY d.dep_location ASC;

SELECT e.emp_id, e.emp_name, e.salary, d.dep_name, d.dep_location, d.dep_id, e.job_name FROM employees e
JOIN department d ON e.dep_id = d.dep_id WHERE (d.dep_location = 'SYDNEY' OR d.dep_name = 'FINANCE')
AND (12*e.salary)>28000 AND e.salary NOT IN (3000, 2800) AND e.job_name != 'MANAGER'
AND (TRIM(CAST(emp_id AS CHAR(50))) LIKE '__3%' OR TRIM(cast(emp_id AS CHAR(50))) LIKE '__7%')
ORDER BY e.dep_id ASC, e.job_name DESC;

SELECT * FROM employees e, salary_grade s WHERE e.salary BETWEEN s.min_salary AND s.max_salary 
AND s.grade IN(2,3)


SELECT * FROM employees e, salary_grade s WHERE e.salary BETWEEN s.min_salary AND s.max_salary
AND s.grade IN(4,5) AND e.job_name IN('MANAGER', 'ANALYST'); 

SELECT * FROM employees e, salary_grade s WHERE e.salary BETWEEN s.min_salary AND s.max_salary
AND s.grade IN(4,5) AND e.emp_id IN (SELECT e.emp_id FROM employees WHERE e.job_name IN('MANAGER', 'ANALYST'));

SELECT * FROM employees WHERE salary > 
(SELECT salary FROM employees WHERE emp_name = 'JONAS');

SELECT * FROM employees WHERE job_name = 
(SELECT job_name FROM employees WHERE emp_name = 'FRANK');

SELECT * FROM employees WHERE hire_date <
(SELECT hire_date FROM employees WHERE emp_name = 'ADELYN');

SELECT * FROM employees e JOIN department d ON d.dep_id = e.dep_id WHERE d.dep_id = 2001
AND e.job_name IN (SELECT e.job_name FROM employees e JOIN department d ON e.dep_id = d.dep_id 
WHERE d.dep_id = 1001);

SELECT * FROM employees WHERE salary IN
(SELECT salary FROM employees e WHERE (emp_name = 'FRANK' OR emp_name = 'BLAZE')
AND employees.emp_id <> e.emp_id) ORDER BY salary DESC;

SELECT * FROM employees WHERE salary IN 
(SELECT salary FROM employees e WHERE (emp_name = 'FRANK' OR emp_name = 'SANDRINE')
AND employees.emp_id <> e.emp_id) ORDER BY salary DESC;

SELECT * FROM employees WHERE job_name = 
(SELECT job_name FROM employees WHERE emp_name = 'MARKER')
OR salary > (SELECT salary FROM employees WHERE emp_name = 'ADELYN'); 

SELECT * FROM employees WHERE salary >
(SELECT max(salary+commission) FROM employees WHERE job_name = 'SALESMAN'); 

SELECT * FROM employees e JOIN department d ON e.emp_id = d.dep_id
WHERE d.dep_location IN ('PERTH','BRISBANE')
AND e.hire_date < (SELECT e.hire_date FROM employees e WHERE e.emp_name = 'BLAZE');
SELECT * FROM employees e, department d WHERE d.dep_location IN ('PERTH','BRISBANE')
AND e.dep_id = d.dep_id AND e.hire_date <
(SELECT e.hire_date FROM employees e WHERE e.emp_name = 'BLAZE') ;

SELECT * FROM employees e WHERE e.dep_id IN
(SELECT d.dep_id FROM department d WHERE d.dep_name IN ('FINANCE','AUDIT'))
AND e.salary > (SELECT salary FROM employees WHERE emp_name = 'ADELYN')
AND e.hire_date < (SELECT hire_date FROM employees WHERE emp_name = 'FRANK')
AND e.emp_id IN (SELECT e.emp_id FROM employees e, salary_grade s WHERE e.salary BETWEEN 
s.min_salary AND s.max_salary AND s.grade IN (3,4)) ORDER BY e.hire_date ASC; 

SELECT * FROM employees WHERE job_name IN (SELECT job_name FROM employees 
WHERE emp_name IN ('SANDRINE','ADELYN'));

SELECT e.job_name FROM employees e WHERE e.dep_id = 1001 AND e.job_name NOT IN
(SELECT job_name FROM employees WHERE dep_id = 2001);

SELECT * FROM employees WHERE salary IN 
(SELECT max(salary) FROM employees);

SELECT * FROM employees WHERE salary IN 
(SELECT MAX(salary) FROM employees WHERE dep_id IN
(SELECT d.dep_id FROM department d WHERE d.dep_name = 'MARKETING'));

SELECT e.emp_id, e.emp_name, e.job_name, e.hire_date, e.salary FROM employees e, department d
WHERE d.dep_location = 'PERTH' AND hire_date IN (SELECT MAX(hire_date) FROM employees e,
salary_grade s WHERE salary BETWEEN min_salary AND max_salary AND grade = 3);

SELECT emp_id, emp_name, job_name, hire_date, salary FROM employees WHERE hire_date <
(SELECT MAX(hire_date) FROM employees WHERE manager_id IN (SELECT emp_id FROM employees
WHERE emp_name = 'KAYLING'));

SELECT * FROM employees WHERE dep_id IN (SELECT dep_id FROM department WHERE dep_location = 'SYDNEY')
AND emp_id IN (SELECT emp_id FROM employees e, salary_grade s WHERE e.salary BETWEEN
s.min_salary AND s.max_salary AND s.grade IN (3,4,5)) AND job_name != 'PRESIDENT'
AND salary > (SELECT MAX(salary) FROM employees WHERE dep_id IN
(SELECT dep_id FROM department WHERE dep_location = 'PERTH') AND job_name IN ('MANAGER', 'SALESMAN')
AND manager_id NOT IN (SELECT emp_id FROM employees WHERE emp_name = 'KAYLING'));

SELECT * FROM employees WHERE hire_date IN (SELECT MIN(hire_date) FROM employees
WHERE YEAR(hire_date) = 1991);

SELECT * FROM employees WHERE job_name IN (SELECT job_name FROM employees WHERE hire_date IN
(SELECT MIN(hire_date) FROM employees WHERE YEAR(hire_date) = 1991));

SELECT * FROM employees WHERE hire_date IN (SELECT MIN(hire_date) FROM employees WHERE emp_id IN
(SELECT emp_id FROM employees e, salary_grade s WHERE e.salary BETWEEN s.min_salary AND 
s.max_salary AND s.grade IN (4,5))) AND manager_id IN (SELECT emp_id FROM employees
WHERE emp_name = 'KAYLING');

SELECT SUM(salary) FROM employees WHERE job_name = 'MANAGER';

SELECT SUM(salary) FROM employees WHERE emp_id IN (SELECT emp_id FROM employees e, salary_grade s
WHERE e.salary BETWEEN s.min_salary AND s.max_salary AND s.grade = 3);

SELECT * FROM employees WHERE dep_id = 1001 AND salary > (SELECT AVG(salary) FROM employees
WHERE dep_id = 2001);

SELECT d.dep_id, d.dep_name, d.dep_location, COUNT(*) FROM employees e, department d
WHERE e.dep_id = d.dep_id GROUP BY d.dep_id HAVING COUNT(*) = (SELECT MAX(MYCOUNT) FROM 
(SELECT COUNT(*) MYCOUNT FROM employees GROUP BY dep_id) a);

SELECT * FROM employees WHERE manager_id IN (SELECT emp_id FROM employees WHERE emp_name = 'JONAS');

SELECT * FROM employees WHERE dep_id NOT IN 
(SELECT dep_id FROM department WHERE dep_name = 'MARKETING');

SELECT e.emp_name, e.job_name, d.dep_name, d.dep_location FROM employees e, department d WHERE
emp_id IN (SELECT manager_id FROM employees);

SELECT * FROM employees WHERE salary IN (SELECT MAX(salary) FROM employees GROUP BY dep_id);
SELECT e.emp_name, e.emp_id FROM employees e WHERE e.salary IN 
(SELECT MAX(salary) FROM employees group by dep_id);

SELECT * FROM employees WHERE salary >= (SELECT (MAX(salary)+MIN(salary))/2 FROM employees);

SELECT * FROM employees WHERE job_name = 'SALESMAN' AND DATEDIFF(CURRENT_DATE, hire_date)/30 > 10;

SELECT * FROM employees w, employees M  WHERE w.manager_id = m.emp_id AND w.salary < m.salary
AND w.salary > ANY (SELECT salary FROM employees WHERE emp_id IN (SELECT manager_id FROM employees));

SELECT e.emp_name, d.maxsal,e.dep_id FROM employees e, (SELECT AVG(salary) maxsal, dep_id FROM 
employees GROUP BY dep_id)d WHERE e.dep_id = d.dep_id;

SELECT * FROM employees e WHERE 5 > (SELECT COUNT(*) FROM employees WHERE e.salary > salary); 

SELECT * FROM employees WHERE emp_id IN (SELECT manager_id FROM employees) AND manager_id NOT IN
(SELECT emp_id FROM employees WHERE job_name = 'PRESIDENT');

SELECT e.emp_name, e.salary, e.commission, (SELECT SUM(salary + commission) FROM employees)NETPAY 
FROM employees e WHERE (SELECT SUM(salary + commission) FROM employees) > ANY 
(SELECT salary FROM employees WHERE emp_id = e.emp_id);

SELECT * FROM department d WHERE LENGTH(dep_name) IN (SELECT COUNT(*) FROM employees e WHERE
e.dep_id = d.dep_id);

SELECT d.dep_name, COUNT(*) FROM employees e, department d WHERE e.dep_id = d.dep_id
GROUP BY d.dep_name HAVING COUNT(*) = LENGTH(d.dep_name);

SELECT dep_name FROM department WHERE dep_id IN (SELECT dep_id FROM employees GROUP BY dep_id
HAVING COUNT(*) IN (SELECT MAX(MYCOUNT) FROM 
(SELECT COUNT(*) MYCOUNT FROM employees GROUP BY dep_id) a));

SELECT * FROM employees e WHERE hire_date IN (SELECT hire_date FROM employees WHERE e.emp_id <> emp_id);

SELECT d.dep_name FROM department d, employees e WHERE e.dep_id = d.dep_id GROUP BY d.dep_name HAVING COUNT(*) >
(SELECT AVG(MYCOUNT) FROM (SELECT COUNT(*) MYCOUNT FROM employees GROUP BY dep_id) a);

SELECT m.emp_name, COUNT(*) FROM employees w, employees m WHERE w.manager_id = m.emp_id GROUP BY m.emp_name
HAVING COUNT(*) = (SELECT MAX(MYCOUNT) FROM (SELECT COUNT(*) MYCOUNT FROM employees GROUP BY manager_id)a);

SELECT * FROM employees w WHERE salary < ANY ( SELECT salary FROM employees WHERE manager_id = w.emp_id);

SELECT * FROM employees WHERE manager_id IN (SELECT emp_id FROM employees WHERE emp_name = 'BLAZE');

SELECT * FROM employees WHERE emp_id IN (SELECT manager_id FROM employees);

SELECT e.emp_name, w.emp_name, m.emp_name FROM employees e, employees w, employees m WHERE e.manager_id = w.emp_id
AND w.emp_name = 'JONAS' AND w.manager_id = m.emp_id;

SELECT * FROM employees WHERE salary IN (SELECT MIN(salary) FROM employees GROUP BY job_name) ORDER BY salary ASC;

SELECT * FROM employees WHERE salary IN (SELECT MAX(salary) FROM employees GROUP BY job_name) ORDER BY salary DESC;

SELECT * FROM employees e WHERE hire_date IN (SELECT MAX(hire_date) FROM employees WHERE e.dep_id = dep_id)
ORDER BY hire_date DESC;

SELECT e.emp_name, e.salary, e.dep_id FROM employees e WHERE salary > (SELECT AVG(salary) FROM employees WHERE
e.dep_id = dep_id) ORDER BY dep_id;

SELECT * FROM employees WHERE salary = (SELECT MAX(salary) FROM employees WHERE commission IS NOT NULL);

SELECT emp_name, job_name, salary FROM employees WHERE dep_id != 1001 AND job_name IN (SELECT job_name FROM
employees WHERE dep_id = 3001) AND salary IN (SELECT salary FROM employees WHERE dep_id = 3001);

SELECT dep_id, emp_name, job_name, salary, salary+commission "Net Salary" FROM employees WHERE job_name = 
'SALESMAN' AND salary+commission IN (SELECT MAX(salary+commission) FROM employees WHERE commission IS NOT NULL);

SELECT dep_id, emp_name, job_name, salary, salary+commission "Net Salary" FROM employees e WHERE 2 - 1 = (SELECT
COUNT(DISTINCT emp.salary+emp.commission) FROM employees emp WHERE emp.salary+emp.commission > e.salary + e.commission);

SELECT dep_id, AVG(salary) FROM employees GROUP BY dep_id HAVING AVG(salary) < (SELECT AVG(salary) FROM employees);

SELECT * FROM department WHERE dep_id IN (SELECT DISTINCT dep_id FROM employees);

SELECT * FROM employees WHERE dep_id IN (SELECT dep_id FROM department WHERE dep_location = 'PERTH');

SELECT * FROM employees WHERE emp_id IN (SELECT emp_id FROM employees e, salary_grade s WHERE e.salary BETWEEN
s.min_salary AND s.max_salary AND s.grade IN (2,3)) AND dep_id IN (SELECT dep_id FROM department WHERE
dep_location = 'PERTH');

SELECT * FROM employees WHERE job_name = (SELECT job_name FROM employees WHERE emp_name = 'ADLYNE') OR salary >
(SELECT salary FROM employees WHERE emp_name = 'WADE');

SELECT * FROM employees WHERE dep_id = 1001 AND salary > (SELECT salary FROM employees WHERE emp_name = 'ADELYN');

SELECT * FROM employees WHERE emp_id IN (SELECT manager_id FROM employees WHERE hire_date < (SELECT hire_date
FROM employees WHERE emp_name = 'KAYLING') AND hire_date > (SELECT hire_date FROM employees WHERE 
emp_name = 'SANDRINE')); 

SELECT e.emp_id, e.emp_name, d.dep_location, e.salary, d.dep_name FROM employees e, department d WHERE
e.dep_id = d.dep_id AND e.dep_id IN (SELECT dep_id FROM employees WHERE emp_name = 'KAYLING'
AND emp_id <> e.emp_id);

SELECT * FROM employees e, salary_grade s WHERE e.salary BETWEEN s.min_salary AND s.max_salary AND s.grade >
(SELECT s.grade FROM employees e, salary_grade s WHERE e.salary BETWEEN s.min_salary AND s.max_salary AND
e.emp_name = 'MARKER');

SELECT * FROM employees e, department d, salary_grade s WHERE e.dep_id = d.dep_id AND d.dep_location IN
('SYDNEY', 'PERTH') AND e.salary BETWEEN s.min_salary AND s.max_salary AND s.grade IN (SELECT s.grade FROM employees e,
salary_grade s WHERE e.salary BETWEEN s.min_salary AND s.max_salary AND e.emp_name = 'TUCKER') OR DATEDIFF
(CURRENT_DATE, hire_date) > (SELECT DATEDIFF(CURRENT_DATE, hire_date) FROM employees WHERE emp_name = 'SANDRINE');

SELECT * FROM employees WHERE salary IN (SELECT salary FROM employees e WHERE emp_id <> e.emp_id);

SELECT * FROM employees WHERE salary+commission IN (SELECT salary+commission FROM employees e, department d WHERE 
e.dep_id = d.dep_id AND d.dep_name = 'MARKETING' AND e.job_name = 'SALESMAN');

SELECT * FROM employees WHERE hire_date IN (SELECT MAX(hire_date) FROM employees WHERE dep_id = 3001) AND dep_id = 3001;

SELECT * FROM employees WHERE salary = (SELECT MAX(salary) FROM employees e, department d WHERE e.dep_id = 
d.dep_id AND dep_location = 'PERTH') AND hire_date < (SELECT MAX(hire_date) FROM employees e, salary_grade s 
WHERE e.salary BETWEEN s.min_salary AND s.max_salary AND s.grade = 2);

SELECT * FROM employees WHERE salary IN (SELECT MAX(salary) FROM employees WHERE manager_id IN (SELECT emp_id
FROM employees WHERE emp_name = 'KAYLING'));

SELECT e.emp_name, e.salary, e.commission FROM employees e WHERE (SELECT MAX(salary+commission) FROM employees) >=
ANY(SELECT salary FROM employees);

SELECT * FROM employees w, employees m WHERE w.manager_id = m.emp_id AND w.salary > m.salary;

SELECT MAX(MYAVG) FROM (SELECT AVG(salary) MYAVG FROM employees WHERE job_name != 'PRESIDENT' GROUP BY job_name)a;

SELECT COUNT(*) FROM employees WHERE emp_id IN (SELECT manager_id FROM employees);

SELECT d.dep_id, COUNT(e.dep_id) FROM department d LEFT OUTER JOIN employees e ON e.dep_id = d.dep_id 
GROUP BY d.dep_id HAVING COUNT(e.dep_id)=0;