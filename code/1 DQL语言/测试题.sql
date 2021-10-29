#测试题
/*
已知表 stuinfo
id 学号
name 姓名
email 邮箱  如：john@126.com
gradeId 年级编号
sex 性别  男 女
age 年龄

已知表 grade
id 年级编号
gradeName 年级名称
*/

#1.查询 所有学员的邮箱的用户名（注：邮箱中@前面的字符）
SELECT SUBSTR(email, 0, INSTR(email, '@') - 1)
FROM stuinfo;


#2.查询男生和女生的个数
SELECT sex, COUNT(*) 个数
FROM stunifo
GROUP BY sex;


#3.查询年龄>18岁的所有学生的姓名和年级名称
SELECT NAME, gradeName
FROM stuinfo s
INNER JOIN gradeName g
ON s.gradeId = g.id
WHERE age > 18;


#4.查询哪个年级的学生最小年龄>20岁
SELECT gradeId, MIN(age)
FROM stuinfo
GROUP BY gradeID
HAVING MIN(age)>20;

#5.说出查询列表中各关键字，及执行顺序
SELECT 查询列表		7
FROM 表			1
连接类型 JOIN 表2	2
ON 连接条件		3
WHERE 筛选条件		4
GROUP BY 分组		5
HAVING 分组后的筛选	6
ORDER BY 排序列表	8
LIMIT 起始索引，条目数	9





