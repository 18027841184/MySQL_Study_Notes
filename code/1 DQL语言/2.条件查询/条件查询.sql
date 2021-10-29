#2.条件查询
/*
语法：
	select 查询列表 from 表名
	where 筛选条件；
	
分类：
	一、按条件表达式筛选
	条件运算符：> < =(判断等于) !=或<>（不等于） >= <=
	二、按逻辑表达式筛选
	逻辑运算符： 
		&& || !
		and or not
	三、模糊查询(有些书归为条件运算符)
		like、 between and、 in、 is null
*/
#一、按条件表达式筛选
#案例1：查询工资 > 12000的员工
SELECT 
  * 
FROM
  employees 
WHERE salary > 12000 ;

#案例2：查询部门编号不等于90号的员工名和部门编号
SELECT 
  last_name,
  department_id 
FROM
  employees 
WHERE department_id <> 90 ;


#二、按逻辑表达式筛选
#案例1：查询工资在1W到2W之间的员工名、工资以及奖金
SELECT 
  last_name,
  salary,
  commission_pct 
FROM
  employees 
WHERE 
  salary > 10000 AND salary < 20000 ;

#案例2：部门编号不是在90到110之间，或者工资高于15000的员工信息
SELECT 
  * 
FROM
  employees 
WHERE 
  department_id < 90 OR department_id > 110 OR salary > 15000 ;
#或： NOT(department_id>=90 AND department_id<=110) OR salary > 15000 


#三、模糊查询
/*
1.like:一般与通配符搭配使用
	通配符：% (百分号)，表任意个字符，包含0个
		_ (下划线)，任意单个字符
*/
#案例1：查询员工名中包含字符a的员工信息
SELECT 
  * 
FROM
  employees 
WHERE 
  last_name LIKE '%a%' ;

#案例2：查询员工名中第三个字符为n，第五个字符为l的员工名和工资
SELECT
  last_name, salary
 FROM
  employees
WHERE
  last_name LIKE '__n_l%';

#案例3：查询员工名中第二个字符为_的员工名
/*转义字符：
	①\ 与C++一样，可直接使用
	②自己指定一个  如用$，并在后面加上 ESCAPE '$'(推荐)
*/
SELECT 
  last_name 
FROM
  employees 
WHERE 
  last_name LIKE '_$_%' ESCAPE '$';

#2.between and
/*①使用between and可以提高语句的简洁度
  ②包含临界值
  ②两个临界值不要调换顺序(左<右)
*/
#案例1：查询员工编号在100到120之间的
SELECT 
  * 
FROM
  employees 
WHERE 
  employee_id >= 100 AND employee_id <= 120 ;
 #--------简洁做法-----------
SELECT 
  * 
FROM
  employees 
WHERE 
  employee_id BETWEEN 100 AND 120 ;

#3.in
/*
含义：判断某字段的值是否属于in列表中的一项
特点：
	①使用in提高语句简洁度
	②in列表的值类型必须一致或兼容(隐式转换)
	③in列表中的字段，不支持使用通配符_和%
*/

#案例：查询员工的工种编号是 IT_PROG、 AD_VP、 AD_PRES中的一个员工名和工种编号
SELECT
	last_name, job_id
FROM
	employees
WHERE
	job_id = 'IT_PROG' OR job_id = 'AD_VP' OR job_id = 'AD_PRES';
#------------使用in------------------------
SELECT
	last_name, job_id
FROM
	employees
WHERE
	job_id IN('IT_PROG','AD_VP','AD_PRES') ;

#4.is null
/*
=或<>不能用于判断null值
is null或is not null 可以判断null值
*/
#案例：查询没有奖金的员工名和奖金率
SELECT
	last_name,
	commission_pct
FROM
	employees
WHERE
	commission_pct IS NULL;  # =号不能判断null
#-------查询有奖金的-------------------
SELECT
	last_name,
	commission_pct
FROM
	employees
WHERE
	commission_pct IS NOT NULL;



#补充：安全等于<=>
#案例1：查询没有奖金的员工名和奖金率
SELECT
	last_name,
	commission_pct
FROM
	employees
WHERE
	commission_pct <=> NULL; 

#案例2：查询工资为12000的员工信息
SELECT
	last_name,
	commission_pct,
	salary
FROM
	employees
WHERE
	salary <=> 12000;


/*is null 和 <=> 比较
is null:仅可以判断NULL值，可读性高
<=>:可以判断null值和普通值，可读性低
*/


