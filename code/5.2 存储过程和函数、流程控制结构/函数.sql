#函数
/*
含义：一组预先编译号的SQL语句的集合（批处理语句）
好处：
1、提高代码的重用性
2、简化操作
3、减少了编译次数并减少了和数据库服务器的连接次数，提高了效率

区别：
存储过程：可以有0个返回，或多个返回(适合批量插入、更新)
函数：有且仅有1个返回(适合做处理数据后返回一个结果)
*/

#一、创建语法
CREATE FUNCTION 函数名(参数列表) RETURNS 返回类型
BEGIN
	函数体
END $

/*
注意：
1.参数列表，包含两部分：参数名、参数类型

2.函数体：肯定会有return语句，如果没有会报错
若return语句没有放在函数体的最后也不报错，但不建议

3.函数体只有一句话时，begin end可以省略
4.使用delimiter语句设置结束标记
*/

#二、调用语法
SELECT 函数名(参数列表)


#----------------------------案例演示---------------------

#1.无参有返回
#案例：返回公司的员工个数
CREATE FUNCTION myf1() RETURNS INT
BEGIN
	DECLARE c INT DEFAULT 0; #定义变量
	SELECT COUNT(*) INTO c #赋值
	FROM employees;
	RETURN c;
END $

#调用
SELECT myf1()$


#2.有参数有返回
#案例1：根据员工名，返回工资
CREATE FUNCTION myf2(empName VARCHAR(20)) RETURNS DOUBLE
BEGIN
	SET @sal=0; #定义用户变量
	SELECT salary INTO @sal #赋值
	FROM employees
	WHERE last_name = empName;
	
	RETURN @sal;
END $

#调用
SELECT myf2('Kochhar')$


#案例2：根据部门名，返回该部门的平均工资
CREATE FUNCTION myf3(deptName VARCHAR(20)) RETURNS DOUBLE
BEGIN
	DECLARE sal DOUBLE;
	SELECT AVG(salary) INTO sal
	FROM employees e
	INNER JOIN departments d
	ON d.department_id = e.department_id
	WHERE d.department_name = deptName;
	
	RETURN sal;
END $

#调用
SELECT myf3('IT')$


#三、查看函数
SHOW CREATE FUNCTION myf3;

#四、删除函数
DROP FUNCTION myf3;


#案例：创建函数，实现传入两个float，返回二者之和
CREATE FUNCTION test_fun1(num1 FLOAT, num2 FLOAT) RETURNS FLOAT
BEGIN
	DECLARE SUM FLOAT DEFAULT 0;
	SET SUM = num1 + num2;
	RETURN SUM;
END $

SELECT test_fun1(1.3, 2.5)$










