#TCL（Transaction Control Language）- 事务控制语言
/*
事务：
一个或一组sql语句组成一个执行单元，这个执行单元要么全部执行，要么全部不执行。
若某条sql语句执行失败或产生错误，整个单元将会回滚，所有受影响的数据将返回事务开始前的状态;
如果单元中所有sql语句执行成功，则事务被顺利执行。


事务的ACID属性：
1.原子性(Atomicity)：
	指事务是一个不可分割的工作单位(事务中的操作要么都执行，要么都不执行)
2.一致性(Consistency)：
	事务从数据库的一个一致性状态变换到另一个一致性状态
3.隔离性(Isolation)：
	指一个事务的执行不能被其他事务干扰（并发执行的各个事务之间不能互相干扰）
4.持久性(Durability)：
	指一个事务一旦提交，它对数据库中数据的改变就是永久性的


事务的创建
隐式事务：事务没有明显的开启和结束的标记
如：insert、update、delete语句

显示事务：事务具有明显的开启和结束的标记
前提：必须先设置自动提交功能为禁用
set autocommit=0;(只对当前连接有效)

步骤1：开启事务
set autocommit=0;
start transaction; 可选的(可不写)

步骤2：编写事务中的sql语句(select、insert、update、delete)
语句1;
语句2；
...

步骤3：结束事务
commit; 提交事务
rollback; 回滚事务

savepoint 节点名; 设置保存点(搭配rollback使用)



事务的隔离级别：
			脏读	不可重复读	幻读
read uncommitted	√	√		√
read committed		×	√		√
repeatable read		×	×		√
serializable(串行化)	×	×		×
	mysql中默认 - 第三个隔离级别（repeatable read）
	oracle中默认 - 第二个隔离级别（read committed）

相关命令：
查看隔离级别：select @@tx_isolation;
设置隔离级别：
set session|global transaction isolation level 隔离级别;


*/
#查看自动提交变量
SHOW VARIABLES LIKE '%autocommit%';

#查看mysql支持的存储引擎
SHOW ENGINES;
#其中innodb支持事务，而myisam、而memory不支持


DROP TABLE IF EXISTS account;
CREATE TABLE account(
	id INT PRIMARY KEY AUTO_INCREMENT,
	username VARCHAR(20),
	balance DOUBLE
);
INSERT INTO account(username, balance) 
VALUES ('张无忌',1000),('赵敏',1000);


#事务的步骤
#1.开启事务
SET autocommit=0;
START TRANSACTION;
#2.编写一组事务的语句
UPDATE account SET balance=1000 WHERE username='张无忌';
UPDATE account SET balance=1000 WHERE username='赵敏';
#3.结束事务
ROLLBACK;
#commit;

SELECT * FROM account;


#二、delete和truncate在事务使用中的区别

#演示delete

SET autocommit=0;
START TRANSACTION;
DELETE FROM account;
ROLLBACK; #成功回滚


#演示truncate

SET autocommit=0;
START TRANSACTION;
TRUNCATE TABLE account;
ROLLBACK; #不支持回滚



#三、演示savepoint的使用
SET autocommit=0;
START TRANSACTION;
DELETE FROM account WHERE id=6;
SAVEPOINT a; #设置保存点
DELETE FROM account WHERE id=5;
ROLLBACK TO a; #回滚到保存点





