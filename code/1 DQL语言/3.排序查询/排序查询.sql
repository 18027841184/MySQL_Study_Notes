#进阶3：排序查询
/*
语法：
	select 查询列表
	from 表
	【where 筛选条件】
	order by 排序列表 【asc|desc】

特点：
	1、asc代表升序，desc代表降序
	若省略，默认升序
	2、order by子句可以支持单个字段、多个字段、表达式、函数、别名
	3、order by子句一般是放在查询语句的最后面（只有limit子句比它后）
*/

#案例：查询员工信息，工资从高到低排序
SELECT * FROM employees ORDER BY salary DESC;
#降序，且ASC可省略（默认升序）
SELECT * FROM employees ORDER BY salary ASC;
SELECT * FROM employees ORDER BY salary ;

#案例2：查询部门编号>=90的员工信息，按入职时间的先后进行排序【添加了筛选条件】
SELECT * 
FROM employees
WHERE department_id >= 90
ORDER BY hiredate ASC; 

#案例3：按年薪的高低显示员工信息和年薪【按表达式排序】
SELECT *, salary*12*(1+IFNULL(commission_pct,0)) 年薪
FROM employees
ORDER BY salary*12*(1+IFNULL(commission_pct,0)) DESC;

#案例4：按年薪的高低显示员工信息和年薪【按别名排序】
SELECT *, salary*12*(1+IFNULL(commission_pct,0)) 年薪
FROM employees
ORDER BY 年薪 DESC;

#案例5：按姓名的长度显示员工姓名和工资【按函数排序】
SELECT LENGTH(last_name) 字节长度,last_name, salary
FROM employees
ORDER BY LENGTH(last_name) DESC;

#案例6：查询员工信息，先按工资排序，再按员工编号排序【按多个字段排序】
SELECT *
FROM employees
ORDER BY salary ASC, employee_id DESC;



