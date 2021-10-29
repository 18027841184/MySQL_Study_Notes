#标识列
/*
又称为自增长列
含义：可以不用手动插入值，系统提供默认的序列值

特点：
1.标识列必须和主键搭配吗？
答：不一定，但要求是一个key(主键、唯一、外键)

2.一个表至多一个自增长列
3.标识列的类型只能是数值型(一般为int)
4.标识列可通过 SET auto_increment_increment=3; 设置步长
  也可以通过手动插入值，设置起始值

*/

#一、创建表时设置标识列
DROP TABLE IF EXISTS tab_identity;
CREATE TABLE tab_identity(
	id INT,
	NAME VARCHAR(20),
	seat INT
);
TRUNCATE TABLE tab_identity;
INSERT INTO tab_identity VALUES(NULL, 'john'); #id列自增长
INSERT INTO tab_identity(NAME) VALUES('lucy');

SELECT * FROM tab_identity;

#修改自增长的步长，一般不会改（影响所有表）
SHOW VARIABLES LIKE '%auto_increment%';
SET auto_increment_increment=3;



#二、修改表时设置标识列
ALTER TABLE tab_identity MODIFY COLUMN id INT PRIMARY KEY AUTO_INCREMENT;

#三、修改表时删除标识列
ALTER TABLE tab_identity MODIFY COLUMN id INT;










