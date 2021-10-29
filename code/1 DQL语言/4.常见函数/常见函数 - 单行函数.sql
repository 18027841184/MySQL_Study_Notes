#进阶4：常见函数
/*
单行函数的分类：
	1.字符函数
	2.数学函数
	3.日期函数
	4.其他函数【补充】
	5.流程控制函数【补充】
*/

#一、字符函数
#1.length 获取参数值的字节个数
SELECT LENGTH('john');
SELECT LENGTH('张三丰hahaha');

SHOW VARIABLES LIKE '%char%'; #查看当前字符集


#2.concat 拼接字符串
SELECT CONCAT(last_name,'_',first_name)  姓名
FROM employees;


#3.upper、lower
SELECT UPPER('john');
SELECT LOWER('JOHN');
#示例：将姓变大写，名变小写  再拼接（函数嵌套调用）
SELECT CONCAT(UPPER(last_name),' ',LOWER(first_name)) 姓名
FROM employees;


#4.substr、substring  一样，截取字符
#SQL中  索引从1开始
SELECT SUBSTR('李莫愁爱上了陆展元', 7) out_put; #substr(str, pos)
SELECT SUBSTR('李莫愁爱上了陆展元', 1, 3) out_put; #substr(str, pos, len)

#案例：姓名中首字符大写，其他字符小写然后用_拼接，显示出来
SELECT CONCAT(UPPER(SUBSTR(last_name,1,1)),LOWER(SUBSTR(last_name,2)),'_',
UPPER(SUBSTR(first_name,1,1)),LOWER(SUBSTR(first_name,2))) 姓名
FROM employees;


#5.instr  返回子串第一次出现的索引，找不到返回0
SELECT INSTR('杨不悔爱上了殷六侠', '殷六侠') AS out_put;
SELECT INSTR('杨不悔爱上了', '殷六侠') AS out_put;


#6.trim  删除前后字符，默认空格、可指定
SELECT  LENGTH(TRIM('   张翠山   ')) AS out_put;
SELECT  TRIM('a' FROM 'aaaaaaaa张aaaa翠山aaaaaaaaaaaaaaaa') AS out_put;


#7.lpad  用指定的字符实现左填充指定长度（中间的参数为总长度）
#  rpad  右填充
SELECT LPAD('殷素素', 10, '*') AS out_put;
SELECT RPAD('殷素素', 12, 'ab') AS out_put;


#8.replace 替换
SELECT REPLACE('张无忌爱上了周芷若周芷若周芷若','周芷若','赵敏') AS out_put;



#二、数学函数
#1.round 四舍五入
SELECT ROUND(1.56);
SELECT ROUND(1.657, 2); #小数点后保留两位

#2.ceil 向上取整,返回>=该参数的最小整数
SELECT CEIL(1.02);
SELECT CEIL(-1.02);

#3.floor 向下取整，返回<=该参数的最大整数
SELECT FLOOR(-9.99);
SELECT FLOOR(9.99);

#4.truncate 截断
SELECT TRUNCATE(1.65431, 2); #第二个参数表小数点后保留几位

#5.mod取余
/* mod(a,b): a-a/b*b
   mod(-10,-3):-10-(-10)/(-3)*(-3) = -1
*/
SELECT MOD(10, -3); #被除数为正，结果为正；反之为负
SELECT 10%3;



#三、日期函数
#1.now 返回当前系统 日期+时间
SELECT NOW();

#2.curdate 返回当前系统日期，不包含时间
SELECT CURDATE();

#3.curtime 返回当前时间，不包含日期
SELECT CURTIME();

#4.可以获取指定的部分：年、月、日、小时、分钟、秒
SELECT YEAR(NOW()) 年;
SELECT YEAR('1998-08-24');
#案例：员工入职年份
SELECT DISTINCT(YEAR(hiredate)) 年 FROM employees;

SELECT MONTH(NOW()) 月;
SELECT MONTHNAME(NOW()) 月;

#5.str_to_date 将字符转换成指定格式的日期
#输入：STR_TO_DATE('9-13-1999', '%m-%d-%Y')  输出：1999-09-13
SELECT STR_TO_DATE('08-24-1998','%m-%d-%Y') AS out_put;

#案例：查询入职日期为1992-4-3的员工信息
SELECT * FROM employees WHERE hiredate = '1992-4-3';
SELECT * FROM employees WHERE hiredate = STR_TO_DATE('4-3 1992','%c-%d %Y');

#6.date_format 将日期转换成字符
#输入：DATE_FORMAT('2018/6/6', '%Y年%m月%d日')  输出：2018年06月06日
SELECT DATE_FORMAT(NOW(),'%Y年%m月%d日') AS out_put;

#案例：查询有奖金的员工名和入职日期（xx月/xx日 xx年）
SELECT 
  last_name,
  DATE_FORMAT(hiredate, '%m月/%d日 %Y年') 
FROM
  employees 
WHERE commission_pct IS NOT NULL ;



#四、其他函数
SELECT VERSION(); #版本号
SELECT DATABASE(); #当前数据库
SELECT USER(); #当前用户



#五、流程控制函数
#1.if函数： 类似if else的效果（true返回参数2，false返回参数3）
SELECT IF(10>5,'大','小');

SELECT last_name, commission_pct, IF(commission_pct IS NULL,'没奖金呵呵','有奖金嘻嘻') 备注
FROM employees;

#2.1 case函数 使用一：switch case的效果
/*
C++中：
switch(变量或表达式) {
	case 常量1：语句1; break;
	...
	default: 语句n; break;
}

mysql中：
case 要判断的字段或表达式
when 常量1 then 要显示的值1或语句1;
...
else 要显示的值n或语句n;
end
*/

/*案例：查询员工的工资，要求：
	部门号=30，显示工资为1.1倍
	部门号=40，显示的工资为1.2倍
	部门号=50，显示的工资为1.3倍
	其他部门，显示的工资为原工资
*/
SELECT 
  salary 原始工资,
  department_id,
  CASE
    department_id 
    WHEN 30 
    THEN salary * 1.1 
    WHEN 40 
    THEN salary * 1.2 
    WHEN 50 
    THEN salary * 1.3 
    ELSE salary 
  END AS 新工资 
FROM
  employees ;

#2.2 case函数 使用二：类似于 多重if
/*
C++中：
if(条件1) {
	语句1;
}
else if(条件2) {
	语句2;
}
...
else {
	语句n;
}

mysql中：
case
when 条件1 then 要显示的值1或语句1;
when 条件2 then 要显示的值2或语句2;
...
else 要显示的值n或语句n
end
*/
/*查询员工工资的情况
	如果工资>20000，显示A级别
	如果工资>15000，显示B级别
	如果工资>10000，显示C级别
	否则，显示D级别
*/
SELECT 
  salary,
  CASE
    WHEN salary > 20000 
    THEN 'A' 
    WHEN salary > 15000 
    THEN 'B' 
    WHEN salary > 10000 
    THEN 'c' 
    ELSE 'D' 
  END AS 工资级别 
FROM
  employees ;

/*常见函数总结：
	字符函数：length、concat、substr、instr、trim、upper、lower、lpad、rpad、replace
	数学函数：round、ceil、floor、truncate、mod
	日期函数：now、curdate、curtime、year、month、monthname、day、hour、minute、second
		  str_to_date、date_format
	其他函数：version、database、user
	控制函数：if、case
*/
