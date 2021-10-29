#视图
/*
含义：虚拟表，和普通表一样使用
mysql5.1版本出现的新特性，是通过表动态生成的数据

	创建语法的关键字	是否实际占用物理空间	使用
视图	create view		几乎没(只保存sql逻辑)	增删改查（一般不能增删改）
表	create table		占用			增删改查

*/

#案例：查询姓张的学生名和专业名(包装成视图)
CREATE VIEW v1
AS
SELECT stuname, majorname
FROM stuinfo s
INNER JOIN major m
ON s.`majorid` = m.`id`;

SELECT * FROM v1
WHERE stuname LIKE '张%';


#一、创建视图
/*
语法：
create view 视图名
as
复杂查询语句;
*/
#1.查询姓名中包含a字符的员工名、部门名和工种信息
#①创建视图
CREATE VIEW test1
AS
SELECT e.last_Name, d.department_name, j.job_title
FROM employees e
INNER JOIN departments d
ON e.`department_id` = d.`department_id`
INNER JOIN jobs j
ON e.`job_id` = j.`job_id`;

#②使用
SELECT * FROM test1
WHERE last_name LIKE '%a%';


#2.查询各部门的平均工资级别
#①创建视图 查看每个部门的平均工资
CREATE VIEW test2
AS
SELECT department_id dId, AVG(salary) ag
FROM employees
GROUP BY department_id;

#②使用
SELECT test2.ag, g.grade_level
FROM test2
INNER JOIN job_grades g
ON test2.ag BETWEEN g.`lowest_sal` AND g.`highest_sal`;


#3.查询平均工资最低的部门信息
#使用视图
SELECT *
FROM test2
ORDER BY ag
LIMIT 1;


#4.查询平均工资最低的部门名和工资
#使用视图
SELECT test2.*, d.department_name
FROM test2
INNER JOIN departments d
ON test2.dId = d.`department_id`
ORDER BY test2.ag ASC
LIMIT 1;

#解法②
CREATE VIEW test3
AS
SELECT *
FROM test2
ORDER BY ag
LIMIT 1;

SELECT d.*, t.ag
FROM departments d
INNER JOIN test3 t
ON d.`department_id` = t.dId;



#二、视图的修改
#方式一：
/*
语法：(存在就修改，不存在则创建)
create or replace view 视图名
as
查询语句;
*/
SELECT * FROM test3;

CREATE OR REPLACE VIEW test3
AS 
SELECT AVG(salary), job_id
FROM employees
GROUP BY job_id;


#方式二：
/*
语法：
alter view 视图名
as
查询语句;

*/
ALTER VIEW test3
AS
SELECT * FROM employees;



#三、删除视图
/*
语法：drop view 视图名1，视图名2...;
*/
DROP VIEW test1, test2, test3;


#四、查看视图
DESC test3;
SHOW CREATE VIEW test3;


#五、视图的更新
CREATE OR REPLACE VIEW myv1
AS
SELECT last_name, email, 
	salary*12*(1+IFNULL(commission_pct,0)) 年薪
FROM employees;

CREATE OR REPLACE VIEW myv1
AS
SELECT last_name, email
FROM employees;


SELECT * FROM myv1;
SELECT * FROM employees;

#1.插入数据(会插入原始表中)
INSERT INTO myv1 VALUES('张飞','zf@qq.com');

#2.修改(原始表也更更新)
UPDATE myv1 
SET last_name='张无忌' 
WHERE last_name='张飞';

#3.删除(原始表也删除了)
DELETE FROM myv1
WHERE last_name='张无忌';



#具备以下特点的视图，不允许更新
#①包含以下关键字的sql语句：分组函数、distinct、group by、having、union或者union all
CREATE OR REPLACE VIEW myv1
AS 
SELECT MAX(salary) m, department_id
FROM employees
GROUP BY department_id;

SELECT * FROM myv1;
#更新(不可行，不允许更新)
UPDATE myv1
SET m=9000 
WHERE department_id = 10;


#②常量视图
CREATE OR REPLACE VIEW myv2
AS
SELECT 'john' NAME;

SELECT * FROM myv2;
#更新(不可行，不允许更新)
UPDATE myv2
SET NAME='lucy';


#③Select中包含子查询
CREATE OR REPLACE VIEW myv3
AS
SELECT (
	SELECT MAX(salary)
	FROM employees
) 最高工资;

SELECT * FROM myv3;
#更新(不可行)
UPDATE myv3 SET 最高工资=10000;



#④join(包括所有连接)
CREATE OR REPLACE VIEW myv4
AS
SELECT last_name, department_name
FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id;

SELECT * FROM myv4;
#更新(可行)、插入等不可行
UPDATE myv4 SET last_name='张飞'
WHERE last_name='whalen';

INSERT INTO myv4 VALUES('陈真','xxx');



#⑤FROM一个不能更新的视图
CREATE OR REPLACE VIEW myv5
AS
SELECT * FROM myv1;

SELECT * FROM myv5;
#更新
UPDATE myv5 SET m=100000 
WHERE department_id=60;



#⑥WHERE子句的子查询引用了FROM子句中的表
CREATE OR REPLACE VIEW myv6
AS
SELECT last_name, email, salary
FROM employees
WHERE employee_id IN(
	SELECT manager_id
	FROM employees
	WHERE manager_id IS NOT NULL
);

SELECT * FROM myv6;
#更新(不可行)
UPDATE myv6 SET salary=10000
WHERE last_name = 'k_ing';





