#1、查询每个专业的学生人数
SELECT majorid 专业, COUNT(*) 人数
FROM student
GROUP BY majorid;


#2、查询参加考试的学生中，每个学生的平均分、最高分
SELECT studentno, AVG(score), MAX(score)
FROM result
GROUP BY studentno;


#3、查询姓张的每个学生的最低分大于60的学号、姓名
#①查询最低分大于60分的学号
SELECT studentno
FROM result
GROUP BY studentno
HAVING MIN(score)>60;

#②查询姓张的且学号在①中的学生  的学号、姓名
#解法一
SELECT studentno, studentname
FROM student
WHERE studentname LIKE '张%'
AND studentno IN (
	SELECT studentno
	FROM result
	GROUP BY studentno
	HAVING MIN(score)>60
);

#解法二
SELECT s.studentno, s.studentname, MIN(score)
FROM student s
INNER JOIN result r
ON s.`studentno` = r.`studentno`
WHERE s.`studentname` LIKE '张%'
GROUP BY s.`studentno`
HAVING MIN(r.`score`) > 60;


#4、查询生日在“1988-1-1”后的学生姓名、专业名称
SELECT s.studentname, m.majorname
FROM student s
INNER JOIN major m
ON s.`majorid` = m.`majorid`
WHERE DATEDIFF(borndate, '1988-1-1') > 0;


#5、查询每个专业的男生人数和女生人数分别是多少
#方式一
SELECT majorid 专业, sex 性别, COUNT(*) 人数
FROM student
GROUP BY majorid, sex;

#方式二
SELECT majorid 专业, 
	(SELECT COUNT(*) FROM student WHERE sex='男' AND majorid = s.`majorid`) 男,
	(SELECT COUNT(*) FROM student WHERE sex='女' AND majorid = s.`majorid`) 女
FROM student s
GROUP BY majorid;


#6、查询专业和张翠山一样的学生的最低分
#解法1：
SELECT MIN(score)
FROM result r
INNER JOIN student s
ON r.`studentno` = s.`studentno`
WHERE s.`majorid` = (
	SELECT majorid
	FROM student
	WHERE studentname = '张翠山'
);

#解法2：
SELECT MIN(score)
FROM result
WHERE studentno IN (
	SELECT studentno
	FROM student
	WHERE majorid = (
		SELECT majorid
		FROM student
		WHERE studentname = '张翠山'
	)
);



#7、查询大于60分的学生的姓名、密码、专业名
SELECT 
    studentname,
    loginpwd,
    majorname 
FROM
    student s 
    INNER JOIN major m 
        ON s.`majorid` = m.`majorid` 
    INNER JOIN result r 
        ON s.`studentno` = r.`studentno` 
WHERE r.`score` > 60 ;



#8、按邮箱位数分组，查询每组的学生个数
SELECT LENGTH(email) 位数, COUNT(*) 个数
FROM student
GROUP BY LENGTH(email);


#9、查询学生名、专业名、分数
#有的人有些课没成绩，用left join
SELECT s.studentname, m.majorname, r.score
FROM student s
INNER JOIN major m
ON s.`majorid` = m.`majorid`
LEFT JOIN result r  
ON s.`studentno` = r.`studentno`;


#10、查询哪个专业没有学生，分别用左连接和右连接实现(感觉有问题)
#左连接
SELECT m.majorid, m.majorname
FROM major m 
LEFT JOIN student s
ON s.`majorid` = m.`majorid`
WHERE s.`studentno` IS NULL; #主键列


#右连接
SELECT m.majorid, m.majorname
FROM student s
RIGHT JOIN major m 
ON s.`majorid` = m.`majorid`
WHERE s.`studentno` IS NULL; #主键列


#11、查询没有成绩的学生人数
SELECT COUNT(*)
FROM student s
LEFT JOIN result r
ON s.`studentno` = r.`studentno`
WHERE r.`score` IS NULL;









