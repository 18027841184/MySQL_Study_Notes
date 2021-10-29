#流程控制结构
/*
顺序结构：程序从上往下依次执行
分支结构：程序从两条或多条路径中选择一条去执行
循环结构：程序在满足一定条件的基础上，重复执行一段代码

*/

#一、分支结构
#1.if函数
/*
功能：实现简单的双分支
语法：if(表达式1, 表达式2, 表达式3)
注：表达式1为true,返回表达式2，否则返回表达式3的值

应用：任何地方
*/


#2.case结构
#情况1：类似C++的Switch case，一般用于实现等值判断
语法：
	CASE 变量|表达式|字段
	WHEN 要判断的值 THEN 返回的值1或语句1;
	WHEN 要判断的值 THEN 返回的值2或语句2;
	...
	ELSE 要返回的值n或语句n;
	END CASE;


#情况2：类似if、if else、if，一般用于实现区间判断
语法：
	CASE 
	WHEN 要判断的条件1 THEN 返回的值1或语句1;
	WHEN 要判断的条件2 THEN 返回的值2或语句2;
	...
	ELSE 要返回的值n或语句n;
	END CASE;

/*
特点：
1.可以作为表达式，嵌套在其他语句中使用:
	可以放在任何地方，begin end中或外面
  可以作为独立的语句去使用，只能放在 begin end中
  
2.如果when中的值满足或条件成立，则执行对应的then后面的语句，并且结束case
  如果都不满足，则执行else中的语句

3.else可以省略；若else省略，并且所有when都不满足，则返回null
*/


#案例：创建存储过程，根据传入的成绩，显示等级：90-100(A),80-90(B),60-80(C),其余D
CREATE PROCEDURE test_case1(IN score INT)
BEGIN
	CASE 
	WHEN score>=90 THEN SELECT 'A';
	WHEN score>=80 THEN SELECT 'B';
	WHEN score>=60 THEN SELECT 'C';
	ELSE SELECT 'D';
	END CASE; 
END $

CALL test_case1(95)$	


#3.if结构
/*
功能：实现多重分支
语法：
if 条件1 then 语句1;
elseif 条件2 then 语句2;
...
【else 语句n;】
end if;

应用场合：只能用在begin end 中
*/

#案例1：创建存储过程，根据传入的成绩，返回级别：90-100(A),80-90(B),60-80(c),其余D
CREATE FUNCTION test_if1(score INT) RETURNS CHAR
BEGIN
	IF score>=90 THEN RETURN 'A';
	ELSEIF score>=80 THEN RETURN 'B';
	ELSEIF score>=60 THEN RETURN 'C';
	ELSE RETURN 'D';
	END IF;
END $

SELECT test_if1(86);




#二、循环结构
/*
分类：while、loop、repeat

循环控制：
iterate 类似	于 continue(结束)  结束本次循环，继续下一次
leave 类似于 break(跳出) 结束当前所在的循环 

*/

#1.while
/*
语法：
【标签:】while 循环条件 do
	循环体;
end while 【标签】;

类似while，先判断再执行
*/


#2.loop
/*
语法：
【标签:】loop
	循环体;
end loop 【标签】;

可以用来模拟简单的死循环
*/


#3.repeat
/*
语法：
【标签:】repeat
	循环体;
until 结束循环的条件
end repeat【标签】;

类似do..while，先执行一次再判断
*/


#1.无添加循环控制语句
#案例1：批量插入，根据次数插入到admin表中多条记录
CREATE PROCEDURE pro_while1(IN insertCount INT)
BEGIN
	DECLARE i INT DEFAULT 1;
	WHILE i<=insertCount DO
		INSERT INTO admin(username, `password`)
		VALUES(CONCAT('Rose',i), '666');
		SET i = i+1;
	END WHILE;
END $

CALL pro_while1(100)$


#2.添加leave语句
#案例：批量插入，根据次数插入到admin表中多条记录,如果次数>20则停止
CREATE PROCEDURE pro_while1(IN insertCount INT)
BEGIN
	DECLARE i INT DEFAULT 1;
	a:WHILE i <= insertCount DO
		INSERT INTO admin(username,`password`)
		VALUES(CONCAT('xiaohua',i), '0000');
		IF i>=20 THEN LEAVE a;
		END IF;
		SET i=i+1;
	END WHILE a;
END $

CALL pro_while1(100)$


#3.添加iterate语句
#案例：批量插入，根据次数插入到admin表中多条记录,如果次数>20则停止
CREATE PROCEDURE pro_While1(IN insertCount INT)
BEGIN
	DECLARE i INT DEFAULT 0;
	a:WHILE i<=insertCount DO
		SET i=i+1;
		IF MOD(i,2)!=0 THEN ITERATE a;
		END IF;
		
		INSERT INTO admin(username,`password`)
		VALUES(CONCAT('xiaohua',i),'0000');
	END WHILE a;
END $

CALL pro_while1(100)$








