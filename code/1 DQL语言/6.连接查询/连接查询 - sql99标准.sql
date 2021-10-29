#sq199标准
/*
语法：
	select 查询列表
	from 表1 别名 【连接类型】
	join 表2 别名（join替换了，）
	on 连接条件（on替代了where）
		92的连接条件放在where中（可读性低）
	【where 筛选条件】
	【group by 分组】
	【having 筛选条件】
	【order by 排序列表】
	

内连接（重要）：inner
外连接
	左外（重要）:left【outer】
	右外（重要，和左外很相似2）:right【outer】
	全外：full【outer】
交叉连接：cross
*/

#一）内连接
/*
语法：
	select 查询列表
	from 表1 别名
	inner join 表2 别名
	on 连接条件;
	
分类：等值、非等值、自连接
特点：
1.添加排序、分组、筛选
2.inner可以省略
3.连接条件放在on后，筛选条件放在where后 —— 提高分离性，便于阅读
4.inner join连接和sql92语法中的等值连接效果是一样的，都是查询多表的交集
*/

#1、等值连接
#案例1：查询员工名、部门名
SELECT last_name, department_name
FROM employees e
INNER JOIN departments d
ON e.`department_id` = d.`department_id`;

#案例2：查询名字中包含e的员工名和工种名（添加筛选）
SELECT last_name, job_title	
FROM employees e
INNER JOIN jobs j
ON e.`job_id` = j.`job_id`
WHERE last_name LIKE '%e%';

#案例3：查询部门个数>3的城市名和部门个数（添加分组+筛选）
SELECT city 城市, COUNT(*) 部门个数
FROM locations l
INNER JOIN departments d
ON l.`location_id` = d.`location_id`
GROUP BY city
HAVING COUNT(*)>3;

#案例4：查询哪个部门的部门员工个数>3的部门名和员工个数，并按个数进行降序（排序）
SELECT department_name 部门名, COUNT(*) 员工个数
FROM departments d
INNER JOIN employees e
ON d.`department_id` = e.`department_id`
GROUP BY d.`department_id`
HAVING COUNT(*)>3
ORDER BY COUNT(*) DESC;

#案例5：查询员工名、部门名、工种名，并按部门名降序（添加三表连接）
SELECT 
    last_name 员工名,
    department_name 部门名,
    job_title 工种名 
FROM
    employees e 
    INNER JOIN departments d 
        ON e.`department_id` = d.`department_id` 
    INNER JOIN jobs j 
        ON e.`job_id` = j.`job_id` 
ORDER BY department_name ;


#2、非等值连接
#案例1：查询员工的工资级别
SELECT 
    salary,
    grade_level 
FROM
    employees e 
    JOIN job_grades g 
        ON e.`salary` BETWEEN g.`lowest_sal` 
        AND g.`highest_sal` ;

#案例2：查询每个工资级别>20的个数，并且按工资级别降序
SELECT 
    salary,
    grade_level,
    COUNT(*) 个数 
FROM
    employees e 
    JOIN job_grades g 
        ON e.`salary` BETWEEN g.`lowest_sal` 
        AND g.`highest_sal` 
GROUP BY grade_level 
HAVING COUNT(*) > 20 
ORDER BY grade_level DESC ;


#3、自连接
#案例1：查询员工的员工号、名字，上级的员工号、名字
SELECT e.employee_id 员工号, e.last_name 员工名,
	m.employee_id 领导工号, m.last_name 领导名
FROM employees e
JOIN employees m
ON e.`manager_id` = m.`employee_id`;

#案例2：查询员工的员工号、名字，上级的员工号、名字
#添加筛选：姓名中含d的
SELECT e.employee_id 员工号, e.last_name 员工名,
	m.employee_id 领导工号, m.last_name 领导名
FROM employees e
JOIN employees m
ON e.`manager_id` = m.`employee_id`
WHERE e.`last_name` LIKE '%d%';




#二）外连接
/*
应用场景：用于查询一个表中有，另一个表没有的记录

特点：
1、外连接的查询结果为主表中的所有记录
	从表中有和它匹配的，则显示匹配的值
	如果从表中没有和它匹配的，则显示null
	外连接查询结果=内连接结果+主表中有而从表没有的
2、左外连接，left join左边的是主表
   右外连接，right join右边的是主表
3、左外和右外交换两个表的顺序，可以实现同样的效果
4、全外连接 = 内连接结果+表1中有表2无的+表2中有表1中没有的
*/

#引入：查询男朋友 不在男神表的女神名
#用左外连接实现
SELECT b.id, b.name, bo.boyName
FROM beauty b
LEFT JOIN boys bo
ON b.`boyfriend_id` = bo.`id`
WHERE bo.`id` IS NULL;  

#用右外连接实现
SELECT b.id, b.name, bo.boyName
FROM boys bo
RIGHT JOIN beauty b
ON b.`boyfriend_id` = bo.`id`
WHERE bo.`id` IS NULL; 


#案例1：查询哪个部门没有员工
#左外
SELECT d.*, e.employee_id
FROM departments d
LEFT JOIN employees e
ON d.`department_id` = e.`department_id`
WHERE e.`employee_id` IS NULL;

#右外
SELECT d.*, e.employee_id
FROM employees e
RIGHT JOIN departments d
ON d.`department_id` = e.`department_id`
WHERE e.`employee_id` IS NULL;

#全外：mysql不支持


#三）交叉连接
SELECT b.*, bo.*
FROM beauty b
CROSS JOIN boys bo;



#sql92 PK sql99
#功能：sql99支持的较多
#可读性：sql99实现连接条件和筛选条件的分离，可读性较高










