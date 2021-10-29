#1.查询工资最低的员工信息：last_name，salary
SELECT last_name, salary
FROM employees
WHERE salary = (
	SELECT MIN(salary)
	FROM employees
);



#2.查询平均工资最低的部门信息
#解法一
#①各部门的平均工资
SELECT AVG(salary), department_id
FROM employees
GROUP BY department_id;
#②查询①结果上的最低平均工资
SELECT MIN(ag_dep.ag)
FROM (
	SELECT AVG(salary) ag, department_id
	FROM employees
	GROUP BY department_id
) ag_dep;
#③查询哪个部门的平均工资=②
SELECT department_id
FROM employees
GROUP BY department_id
HAVING AVG(salary) = (
SELECT MIN(ag_dep.ag)
	FROM (
		SELECT AVG(salary) ag, department_id
		FROM employees
		GROUP BY department_id
	) ag_dep
);
#④查询部门信息，部门编号=③
SELECT *
FROM departments
WHERE department_id = (
SELECT department_id
FROM employees
GROUP BY department_id
HAVING AVG(salary) = (
	SELECT MIN(ag_dep.ag)
		FROM (
			SELECT AVG(salary) ag, department_id
			FROM employees
			GROUP BY department_id
		) ag_dep
	)
);

#解法二：简单做法
#①获得各部门的平均工资
SELECT AVG(salary), department_id
FROM employees
GROUP BY department_id;

#②求出最低平均工资的部门编号
SELECT department_id
FROM employees
GROUP BY department_id
ORDER BY AVG(salary)
LIMIT 1;

#③查询部门信息,部门id = ②
SELECT * 
FROM departments
WHERE department_id = (
	SELECT department_id
	FROM employees
	GROUP BY department_id
	ORDER BY AVG(salary)
	LIMIT 1
);



#3.查询平均工资最低的部门信息和该部门的平均工资
#①求出最低平均工资的部门编号
SELECT AVG(salary), department_id
FROM employees
GROUP BY department_id
ORDER BY AVG(salary)
LIMIT 1;
#②查询部门信息
SELECT d.*, ag_dep.ag
FROM departments d
INNER JOIN (
	SELECT AVG(salary) ag, department_id
	FROM employees
	GROUP BY department_id
	ORDER BY AVG(salary)
	LIMIT 1
) ag_dep
ON d.`department_id` = ag_dep.department_id;



#4.查询平均工资最高的job信息
#①查询各job的平均工资
SELECT AVG(salary) ag, job_id
FROM employees
GROUP BY job_id;

#②获得平均工资最高的job
SELECT AVG(salary) ag, job_id
FROM employees
GROUP BY job_id
ORDER BY AVG(salary) DESC
LIMIT 1;

#③查询job信息
SELECT *
FROM jobs
WHERE job_id = (
	SELECT job_id
	FROM employees
	GROUP BY job_id
	ORDER BY AVG(salary) DESC
	LIMIT 1
);



#5.查询平均工资高于公司平均工资的部门有哪些？
#①查询公司的平均工资
SELECT AVG(salary)
FROM employees;

#②查询平均工资高于①的部门id
SELECT department_id, AVG(salary)
FROM employees
GROUP BY department_id
HAVING AVG(salary) > (
	SELECT AVG(salary)
	FROM employees
);



#6.查询出公司所有manager的详细信息
SELECT *
FROM employees
WHERE employee_id IN (
	SELECT DISTINCT manager_id
	FROM employees
);



#7.各个部门中，最高工资中最低的那个部门的 最低工资是多少
#解法一
#①查询每个部门的最高工资
SELECT MAX(salary), department_id
FROM employees
GROUP BY department_id;

#②查询①中的最低
SELECT MIN(mx_dep.mx)
FROM (
	SELECT MAX(salary) mx, department_id
	FROM employees
	GROUP BY department_id
) mx_dep;

#③查询最高工资=②的部门id
SELECT department_id
FROM employees
GROUP BY department_id
HAVING MAX(salary) = (
	SELECT MIN(mx_dep.mx)
	FROM (
		SELECT MAX(salary) mx, department_id
		FROM employees
		GROUP BY department_id
	) mx_dep
);

#④查询部门=③的最低工资
SELECT MIN(salary)
FROM employees
WHERE department_id = (
	SELECT department_id
	FROM employees
	GROUP BY department_id
	HAVING MAX(salary) = (
		SELECT MIN(mx_dep.mx)
		FROM (
			SELECT MAX(salary) mx, department_id
			FROM employees
			GROUP BY department_id
		) mx_dep
	)
);

#解法二
#①查询各部门中最高工资中最低的部门ID
SELECT department_id
FROM employees
GROUP BY department_id
ORDER BY MAX(salary)
LIMIT 1;

#②查询部门id=①的最低工资
SELECT MIN(salary) 
FROM employees
WHERE department_id = (
	SELECT department_id
	FROM employees
	GROUP BY department_id
	ORDER BY MAX(salary)
	LIMIT 1
);


#8.查询平均工资最高的部门的manager 的详细信息：last_name, department_id, email, salary
#解法一
SELECT last_name, department_id, email, salary
FROM employees
WHERE employee_id = (
	SELECT manager_id
	FROM departments
	WHERE department_id = (
		SELECT department_id
		FROM employees
		GROUP BY department_id
		ORDER BY AVG(salary) DESC
		LIMIT 1
	)
);

#解法二
SELECT 
    last_name,
    d.department_id,
    email,
    salary 
FROM
    employees e 
    INNER JOIN departments d 
        ON d.`manager_id` = e.`employee_id` 
WHERE d.`department_id` = 
    (SELECT 
        department_id 
    FROM
        employees 
    GROUP BY department_id 
    ORDER BY AVG(salary) DESC 
    LIMIT 1) ;

