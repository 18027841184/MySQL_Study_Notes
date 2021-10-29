#进阶6：连接查询
/*
含义：又称多表查询，当查询字段来自多个表时，就会用到连接查询

笛卡尔乘积现象：表1m行，表2n行，结构=m*n行
发生原因：没有有效的连接条件
如何避免：添加有效的连接条件

分类：
	按年代分类：
		sql92标准：仅支持内连接
		sql99标准(推荐)：支持内连接+外连接(左外和右外)+交叉连接
	按功能分类：
		内连接：
			等值连接
			非等值
			自连接
		外连接：
			左外连接
			右外连接
			全外连接
		交叉连接

*/

SELECT * FROM beauty;
SELECT * FROM boys;

SELECT NAME, boyName FROM boys, beauty	
WHERE beauty.boyfriend_id = boys.id;


#sql92标准
#一、等值连接
/*
①多表等值连接的结果为多表的交集部门
②n表连接，至少需要n-1个连接条件
③多表的顺序没有要求
④一般需要为表起别名
⑤可以搭配前面介绍的所有子句使用
*/

#1、简单尝试
#案例1：查询女神名和对应的男神名
SELECT 
    NAME,
    boyName 
FROM
    boys,
    beauty 
WHERE beauty.boyfriend_id = boys.id ;

#案例2：查询员工名和对应的部门名
SELECT last_name, department_name
FROM employees, departments
WHERE employees.`department_id` = departments.`department_id`;


#2、为表起别名(和字段起别名一样)
/*
①提高语句的简洁点
②区分多个重名的字段
注意：若为表起了别名，则查询字段不能用原来的字段去限定
*/
#查询员工号、工种号、工种名
SELECT last_name, e.job_id, job_title
FROM employees AS e, jobs AS j
WHERE e.`job_id` = j.`job_id`;


#3、两个表的顺序可以调换
#同上一案例
SELECT e.last_name, e.job_id, j.job_title
FROM jobs AS j, employees AS e
WHERE e.`job_id` = j.`job_id`;


#4、可以加筛选
#案例：查询有奖金的员工名、部门名字
SELECT last_name, department_name, commission_pct
FROM employees e, departments d
WHERE e.`department_id` = d.`department_id`
AND e.`commission_pct` IS NOT NULL;

#案例2：查询城市名中第二个字符为o的部门名和城市名
SELECT department_name, city
FROM departments d, locations l
WHERE d.`location_id` = l.`location_id`
AND city LIKE '_o%';


#5、可以加分组
#案例1:：查询每个城市的部门个数
SELECT city, COUNT(*) 部门个数
FROM departments d, locations l
WHERE d.`location_id` = l.`location_id`
GROUP BY city;

#案例2：查询有奖金的每个部门的部门名和部门的领导编号和该部门的最低工资
SELECT department_name, d.manager_id, MIN(salary)
FROM departments d, employees e
WHERE d.`department_id` = e.`department_id`
AND commission_pct IS NOT NULL
GROUP BY department_name, d.`manager_id`;

#6、可以加排序
#案例：查询每个工种的工种名和员工的个数，且按员工个数降序
SELECT job_title, COUNT(*) 个数
FROM jobs j, employees e
WHERE j.`job_id` = e.`job_id`
GROUP BY job_title
ORDER BY 个数 DESC;


#7、可以实现三表连接、多表连接
#案例：查询员工名、部门名和所在的城市
SELECT last_name, department_name, city
FROM employees e, departments d, locations l
WHERE e.`department_id` = d.`department_id`
AND d.`location_id` = l.`location_id`;



#二、非等值连接
#即将等值连接的=号换位其它比较运算符

#案例1：查询员工的工资和工资级别
SELECT salary, grade_level
FROM employees e, job_grades g
WHERE salary BETWEEN g.`lowest_sal` AND g.`highest_sal`
ORDER BY grade_level ASC;


#三、自连接
#即在同一表内比较
#案例：查询员工名和上级的名称
SELECT e.employee_id, e.last_name, m.employee_id, m.last_name
FROM employees e, employees m
WHERE e.`manager_id` = m.`employee_id`;













