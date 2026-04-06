-- dbdiagram.io 로 그려보기



table Professor{
	Professor_id int [pk]
	Professor_name varchar
	department varchar
	salary numeric
	salary_level numeric
	hire_date date
}
table Student{
	student_id int [pk]
	student_name varchar
	major varchar
}


table Course{
	course_id int
	section_id int
	professor_id int
	course_name varchar
  Indexes{
        (section_id,course_id)
        }
    }


table Enrollment{
	student_id int
	course_id int
	grade varchar(2)
	points numeric
	enrolled_at DATE
  indexes{
        (student_id,course_id)
  }
}

ref: Enrollment.studeunt_id > Student.student_id
ref: Course.professor_id > Professor.professor_id

ref: Enrollment.studeunt_id > Student.student_id
ref: Course.professor_id > Professor.professor_id
