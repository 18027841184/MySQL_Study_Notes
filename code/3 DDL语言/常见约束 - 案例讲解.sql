
#1.向表 emp2 的 id 列中添加 PRIMARY KEY 约束（my_emp_id_pk）
ALTER TABLE emp2 MODIFY COLUMN id INT PRIMARY KEY;   #不支持起名字
ALTER TABLE emp2 ADD CONSTRAINT my_emp_id_pk PRIMARY KEY(id);  #主键起名字也没效果


#2. 向表 dept2 的 id 列中添加 PRIMARY KEY 约束（my_dept_id_pk）
ALTER TABLE dept2 ADD CONSTRAINT my_dept_id_pk PRIMARY KEY(id);


#3. 向表 emp2 中添加列 dept_id，并在其中定义 FOREIGN KEY 约束，与之相关联的列是dept2 表中的 id 列。
ALTER TABLE emp2 ADD COLUMN dept_id INT;
ALTER TABLE emp2 ADD CONSTRAINT fk_emp2_dept2 FOREIGN KEY(dept_id) REFERENCES dept2(id);


/*
		位置		支持的约束类型			是否可以起约束名
列级约束	列的后面	语法都支持，但外键没有效果	不可以
表级约束	所有列的下面	默认和非空不支持，其他支持	可以（主键没有效果）

*/