DELIMITER $

#1.创建存储过程或函数实现传入用户名和密码，插入到 admin 表中
CREATE PROCEDURE test_pro1(IN userName VARCHAR(20), IN loginPwd VARCHAR(20))
BEGIN
	INSERT INTO admin(admin.username, PASSWORD)
	VALUES(userName, loginPwd);
END $

#调用
CALL test_pro1('admin', '0000')$
SELECT * FROM admin$


#2.创建存储过程或函数实现传入女神编号，返回女神名称和女神电话
CREATE PROCEDURE test_pro2(IN id INT, OUT beautyName VARCHAR(20), OUT phone VARCHAR(20))
BEGIN
	SELECT b.name, b.phone INTO beautyName, phone
	FROM beauty b
	WHERE b.id = id;
END $

#调用
CALL test_pro2(1, @btName, @phone)$
SELECT @btName, @phone$


#3.创建存储存储过程或函数实现传入两个女神生日，返回大小
CREATE PROCEDURE test_pro3(IN birth1 DATETIME, IN birth2 DATETIME, OUT ret INT)
BEGIN
	#birth1>birth2 返回大于0，反之返回小于0
	SELECT DATEDIFF(birth1, birth2) INTO ret;
END $

#调用
CALL test_pro3('1998-1-1',NOW(),@result)$
SELECT @result$


#4、创建存储过程或函数实现传入一个日期，格式化成 xx 年 xx 月 xx 日并返回
CREATE PROCEDURE test_pro4(IN mydate DATETIME, OUT strDate VARCHAR(20))
BEGIN
	SELECT DATE_FORMAT(mydate, '%Y年%m月%d日') INTO strDate;
END $

#调用
CALL test_pro4(NOW(), @str)$
SELECT @str$


#5、创建存储过程或函数实现传入女神名称，返回：女神 and 男神 格式的字符串
/*如 传入 ：小昭
返回： 小昭 and 张无忌*/
CREATE PROCEDURE test_pro5(IN btName VARCHAR(20), OUT str VARCHAR(20))
BEGIN
	SELECT CONCAT(btName, ' and ', IFNULL(boyName, 'NULL')) INTO str
	FROM beauty b
	LEFT JOIN boys bo
	ON b.boyfriend_id = bo.id
	WHERE b.name = btName;
END $

#调用
CALL test_pro5('柳岩', @str)$
SELECT @str$


#6、创建存储过程或函数，根据传入的条目数和起始索引，查询 beauty 表的记录
CREATE PROCEDURE test_pro6(IN startIndex INT, IN size INT)
BEGIN
	SELECT *
	FROM beauty
	LIMIT startIndex, size;
END $

#调用
CALL test_pro6(3, 5)$


