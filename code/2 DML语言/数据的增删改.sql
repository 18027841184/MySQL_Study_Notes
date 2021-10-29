#DML语言  数据操作语言
/*
插入：insert
修改：update
删除：delete
*/

#一、插入语句
#方式1：经典的插入
/*
语法：
insert into 表名(列名,...)
values(值1,...);
*/

SELECT * FROM beauty;

#1.插入的值得类型要与列的类型一致或兼容
INSERT INTO beauty(id, NAME, sex, borndate, phone, photo, boyfriend_id)
VALUES(13, '唐艺昕', '女', '1990-4-23', '189878888888', NULL, 2);


#2.不可为null的列必须插入值，可以为null的列如何插入值？(Nullable的列)
#方式一： 列名写上，值写null
INSERT INTO beauty(id, NAME, sex, borndate, phone, photo, boyfriend_id)
VALUES(13, '唐艺昕', '女', '1990-4-23', '189878888888', NULL, 2);

#方式二：列名+值  都为空
INSERT INTO beauty(id, NAME, sex, borndate, phone, boyfriend_id)
VALUES(14, '金星', '女', '1980-4-23', '1389878888', 9);

INSERT INTO beauty(id, NAME, sex, phone)
VALUES(15, '娜扎', '女', '1389878558');


#3.列的顺序可以调换（但要与值一一对应）
INSERT INTO beauty(NAME, sex, id, phone)
VALUES('蒋欣', '女', 16, '13576218756');


#4.列数和值的个数必须一致
INSERT INTO beauty(NAME, sex, id, phone， boyfriend_id)
VALUES('关晓彤', '女', 17, '13412112656'); #此处不对应，故不行


#5.可以省略列名，默认所有列，而且列的顺序和表中列的顺序一致
INSERT INTO beauty
VALUES(17, '紫萱', '女', '1992-04-23', '135495264512', NULL, 5);


#方式二：
/*
语法：
insert into 表名
set 列名=值, 列名=值, ...
*/

INSERT INTO beauty
SET id=19, NAME='刘涛', phone='12312456499';


#两种插入方式比较（一般用方式一）
#1.方式一支持插入多行,方式二不支持
INSERT INTO beauty
VALUES(21, '唐艺昕1', '女', '1990-4-23', '189878888888', NULL, 2),
(22, '唐艺昕2', '女', '1990-4-23', '189878888888', NULL, 2),
(23, '唐艺昕3', '女', '1990-4-23', '189878888888', NULL, 2);

#2.方式一支持子查询，方式二不支持
INSERT INTO beauty(id, NAME, phone)
SELECT 26, '宋茜', '12353549388';

INSERT INTO beauty(id, NAME, phone)
SELECT id, boyname, '112325428854' 
FROM boys WHERE id<3;




#二、修改语句
/*
1.修改单表的记录
语法：
update 表名
set 列=新值, 列=新值,...
where 筛选条件;


2.修改多表的记录【补充】
语法：
2.1 SQL92语法
update 表1 别名，表2 别名
set 列=值,...
where 连接条件
and 筛选条件;

2.2SQL99语法
update 表1 别名
inner|left|right join 表2 别名
on 连接条件
set 列=值,...
where 筛选条件
*/

#1.修改单表的记录
#案例1：修改beauty表中 姓唐的女神的电话为13888899999
UPDATE beauty 
SET phone='13888899999'
WHERE NAME LIKE '唐%';

#案例2.修改boys表中id为2的 名为：张飞，魅力值 10
UPDATE boys
SET boyName='张飞', userCP=10
WHERE id=2;


#2.修改多表的记录
#案例1：修改张无忌的女朋友的手机号为114
UPDATE boys bo
INNER JOIN beauty b
ON bo.`id` = b.`boyfriend_id`
SET phone='114'
WHERE bo.`boyName`='张无忌';

#案例2：修改没有男朋友的女神的男朋友编号都为2号
UPDATE boys bo
RIGHT JOIN beauty b
ON bo.`id` = b.`boyfriend_id`
SET b.`boyfriend_id`=2
WHERE bo.`id` IS NULL;



#三、删除语句
/*
方式一：delete
语法：
1.单表的删除
delete from 表名 where 筛选条件

2.多表的删除【补充】
sql92语法：
delete 表1的别名, 表2的别名(要删哪个写哪个)
from 表1 别名, 表2 别名
where 连接条件
and 筛选条件;

sql99语法：
delete 表1的别名, 表2的别名(要删哪个写哪个)
from 表1 别名
inner|left|right join 表2 别名
on 连接条件
where 筛选条件;


方式二：truncate
语法：truncate table 表名;
注意：整个表都删了，该方式不能加筛选条件
*/

#方式一：delete
#1.单表的删除
#案例1：删除手机号以9结尾的女神信息
DELETE FROM beauty WHERE phone LIKE '%9';


#2.：多表的删除
#案例1：删除张无忌的女朋友的信息
DELETE b
FROM beauty b
INNER JOIN boys bo
ON b.`boyfriend_id` = bo.`id`
WHERE bo.`boyName`='张无忌';

#案例2：删除黄晓明的信息以及他女朋友的信息
DELETE b, bo
FROM beauty b
INNER JOIN boys bo
ON b.`boyfriend_id` = bo.`id`
WHERE bo.`boyName` = '黄晓明';


#方式二：truncate(不能加筛选条件)
TRUNCATE TABLE boys;


#delete和truncate的区别【面试题】
/*
1.delete 可以加where条件， truncate不能加

2.truncate删除，效率高一点点

3.假如要删除的表中有自增长列，
如果用delete删除后，再插入数据，自增长列的值从断点开始
而truncate删除后，再插入数据，自增长列的值从1开始

4.truncate删除没有返回值，delete删除有返回值（删除行数）

5.truncate删除不能回滚，delete删除可以回滚
*/

SELECT * FROM boys;

DELETE FROM boys;
#自增长列的值从断点开始
INSERT INTO boys(boyname, usercp)
VALUES('张飞', 100), ('刘备', 30), ('关云长', 200);

#自增长列的值从1开始
TRUNCATE TABLE boys;
