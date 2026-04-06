create table Professor(
	Professor_id int primary key,
	Professor_name varchar(30),
	department varchar(100),
	salary numeric,
	salary_level numeric,
	hire_date date
);
drop table Student cascade;
create table Student(
	student_id int PRIMARY KEY,
	student_name varchar(100),
	major varchar(100)
);


create table Course(
	course_id int,
	section_id int,
	professor_id int,
	course_name varchar(100),
	PRIMARY KEY(course_id,section_id), -- 복합키
	FOREIGN KEY(professor_id) references Professor(professor_id)
);


create table Enrollment(
	student_id int,
	course_id int,
	grade varchar(2),
	points numeric,
	enrolled_at DATE,
	PRIMARY KEY (student_id, course_id),
	FOREIGN KEY (student_id) references Student(student_id)
	--FOREIGN KEY (course_id) references Course(course_id)
);