#二、分组函数
/*
功能：用作统计使用，又称为聚合函数、统计函数、组函数

分类：
max 最大值、min 最小值、sum 和、avg 平均值、count 计算个数

特点：
1.sum、avg一般用于处理数值型
  max、min、count可以处理任何类型

2.以上分组函数都忽略null值

3.可以和distinct搭配实现去重

4.count函数的单独使用：
一般使用count(*)用作统计行数

5.和分组函数一同查询的字段要求是group by后的字段
*/

#1、简单的使用
SELECT SUM(salary) FROM employees;
SELECT AVG(salary) FROM employees;
SELECT MIN(salary) FROM employees;
SELECT MAX(salary) FROM employees;
SELECT COUNT(salary) FROM employees; #非空的值


SELECT SUM(salary) 和, ROUND(AVG(salary),2) 平均, MAX(salary) 最高,MIN(salary) 最低, COUNT(salary) 个数
FROM employees;


#2、参数支持哪些类型
#sum、avg一般适合用于处理数值类型
SELECT SUM(last_name), AVG(last_name) FROM employees;
SELECT SUM(hiredate), AVG(hiredate) FROM employees;

SELECT MAX(last_name), MIN(last_name) FROM employees;

SELECT MAX(hiredate), MIN(hiredate) FROM employees;

#count() 只计算非空的值
SELECT COUNT(commission_pct) FROM employees;
SELECT COUNT(last_name) FROM employees;


#3、是否忽略null
SELECT 
    SUM(commission_pct),
    AVG(commission_pct),
    SUM(commission_pct) / 35,
    SUM(commission_pct) / 107 
FROM
    employees ;
    
SELECT MAX(commission_pct), MIN(commission_pct) FROM employees;
SELECT COUNT(commission_pct) FROM employees;


#4、和distinct搭配
SELECT SUM(DISTINCT salary), SUM(salary) FROM employees;
SELECT COUNT(DISTINCT salary), COUNT(salary) FROM employees;


#5.count函数的详细介绍
SELECT COUNT(salary) FROM employees;
SELECT COUNT(*) FROM employees;

#计数同时，给表加了一列1（count参数可填一个常量）
SELECT COUNT(1) FROM employees;  

/*
MYISAM存储引擎下，count(*)的效率高
INNODB存储引擎下，count(*)和count(1)的效率差不多，比count(字段)要高一些
一般使用count(*)
*/


#6.和分组函数一同查询的字段有限制
SELECT AVG(salary), employee_id FROM employees;  #不能这样用
