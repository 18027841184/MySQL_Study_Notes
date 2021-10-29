#1. 查询各 job_id 的员工工资的最大值，最小值，平均值，总和，并按 job_id 升序
SELECT 
    job_id 职工编号,
    MAX(salary) 最大值,
    MIN(salary) 最小值,
    AVG(salary) 平均值,
    SUM(salary) 总数 
FROM
    employees 
GROUP BY 职工编号 
ORDER BY 职工编号 ASC ;


#2. 查询员工最高工资和最低工资的差距（DIFFERENCE）
SELECT 
    MAX(salary) - MIN(salary) DIFFRENCE 
FROM
    employees ;


#3. 查询各个管理者手下员工的最低工资，其中最低工资不能低于 6000，没有管理者的员工不计算在内
SELECT 
    manager_id,
    MIN(salary) 最小值 
FROM
    employees 
WHERE manager_id IS NOT NULL 
GROUP BY manager_id 
HAVING MIN(salary) >= 6000;


#4. 查询所有部门的编号，员工数量和工资平均值,并按平均工资降序
SELECT department_id 部门编号, COUNT(*) 员工数量, AVG(salary) 平均工资
FROM employees
WHERE department_id IS NOT NULL
GROUP BY department_id
ORDER BY 平均工资 DESC;


#5. 选择具有各个 job_id 的员工人数
SELECT COUNT(*) 个数, job_id
FROM employees
GROUP BY job_id;

