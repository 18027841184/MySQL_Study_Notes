#1.创建表Book表
CREATE TABLE Book(
	bid INT PRIMARY KEY,
	bname VARCHAR(20) UNIQUE NOT NULL,
	price FLOAT DEFAULT 10,
	btypeId INT,
	
	CONSTRAINT fk_Book_btypeId FOREIGN KEY(btypeID) REFERENCES bookType(id)
); 

#2.开启事务
#向表插入1行数据，并结束
SET autocommit=0;
START TRANSACTION;
INSERT INTO Book(1, 'Bryant', 100, 1);
COMMIT;
#或rollback;

#3.创建视图，实现查询价格大于100的书名和类型名
CREATE VIEW myv1
AS 
SELECT bname, NAME
FROM book b
INNER JOIN bookType t
ON b.btypeid = t.id
WHERE price>100;

#4.修改视图，实现查询价格在90-120之间的书名和价格
#或alter view myv1
CREATE OR REPLACE VIEW myv1
AS
SELECT bname, price
FROM book b
INNER JOIN bookType t
ON b.btypeId = t.id
WHERE price BETWEEN 90 AND 120;

#5.删除刚才创建的视图
DROP VIEW myv1;





