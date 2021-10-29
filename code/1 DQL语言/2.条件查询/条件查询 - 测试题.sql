#条件查询 - 测试题
#一、查询没有奖金，且工资小于18000的salary, last_name
SELECT
	last_name, salary, commission_pct
FROM
	employees
WHERE
	salary < 18000 AND commission_pct IS NULL;
	
#二、查询employees表中，job_id不为‘IT’ 或者 工资为12000的员工信息
SELECT
	CONCAT(first_name, last_name) AS 姓名,
	job_id, salary, department_id
FROM
	employees
WHERE
	job_id <> 'IT_PROG' OR salary = 12000;
	
#三、查看部门departments表的结构
DESC departments;

#四、查询部门departments表中涉及到了哪些位置编号
SELECT
	DISTINCT location_id
FROM
	departments;
	
#五、经典面试题
/*问：  select * from employees; 和
	select * from employees where commission_pct like '%%' and last_name like '%%';
结果是否一样？ 并说明原因*/
#答：不一样！ 如果判断的字段有null值，则使用'%%'会去掉含null值的数据

