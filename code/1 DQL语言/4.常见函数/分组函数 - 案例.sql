#1. 查询公司员工工资的最大值，最小值，平均值，总和
SELECT 
    MAX(salary),
    MIN(salary),
    AVG(salary),
    SUM(salary) 
FROM
    employees ;


#2. 查询员工表中的最大入职时间和最小入职时间的相差天数 （别名DIFFRENCE）
SELECT 
    DATEDIFF(MAX(hiredate), MIN(hiredate)) DIFFRENCE 
FROM
    employees ;

#datediff函数，两个参数分别放时间，计算相差的天数
SELECT DATEDIFF(NOW(),'1998-8-24');


#3. 查询部门编号为 90 的员工个数
SELECT 
    COUNT(*) 
FROM
    employees 
WHERE department_id = 90 ;

