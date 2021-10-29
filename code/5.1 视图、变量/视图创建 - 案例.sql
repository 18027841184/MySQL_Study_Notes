#一、创建视图emp_v1,要求查询电话号码以'011'开头的员工姓名和工资、邮箱
CREATE VIEW OR REPLACE emp_v1
AS
SELECT last_name, salary, email
FROM employees
WHERE phone_number LIKE '011%';

SELECT * FROM emp_v1;


#二、创建视图emp_v2，要求查询部门的最高工资高于12000的部门信息
CREATE OR REPLACE VIEW emp_v2
AS
SELECT MAX(salary) 最高工资, d.*
FROM employees e
INNER JOIN departments d
ON e.`department_id` = d.`department_id`
GROUP BY e.department_id
HAVING 最高工资>12000;

SELECT * FROM emp_v2;


