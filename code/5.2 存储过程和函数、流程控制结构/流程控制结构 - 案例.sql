/*一、已知表stringcontent
其中字段：
id 自增长
content varchar(20)

向该表插入指定个数的，随机的字符串
*/
DROP TABLE IF EXISTS stringcontent;
CREATE TABLE stringcontent(
	id INT PRIMARY KEY AUTO_INCREMENT,
	content VARCHAR(20)
);


CREATE PROCEDURE pro_randstr_insert(IN insertCount INT)
BEGIN
	DECLARE i INT DEFAULT 1; #定义一个循环变量，表示插入次数
	DECLARE str VARCHAR(26) DEFAULT 'abcedfghijklmnopqrstuvwxyz';
	DECLARE startIndex INT DEFAULT 1; #代表起始索引
	DECLARE len INT DEFAULT 1; #截取字符长度
	
	WHILE i<=insertCount DO
		SET startIndex = FLOOR(RAND()*26+1); #产生一个随机整数，代表起始索引1-26
		SET len = FLOOR(RAND()*(20-startIndex+1)+1); #产生随机整数，表截取长度，1——(26-startIndex+1)
		INSERT INTO stringcontent(content)
		VALUES(SUBSTR(str, startIndex, len));
		SET i=i+1; #循环变量更新		
	END WHILE;
END $

CALL pro_randstr_insert(10)$



