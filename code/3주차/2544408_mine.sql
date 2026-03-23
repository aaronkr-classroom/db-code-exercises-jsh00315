---- 엔티티, 속성 나열 밎 정의
/*
[Entity: Student]
id (PK)
name
major
grade

[Entity: Club]
id (PK)
name

[Entity: Student_Club] (관계 엔티티)
student_id (PK, FK -> Student.id)
club_id (PK, FK -> Club.id)
*/

--각 테이블 생성
CREATE TABLE club (
                      id INT PRIMARY KEY,
                      name VARCHAR(50)
);

CREATE TABLE student (
                         id INT PRIMARY KEY,
                         name VARCHAR(50),
                         major VARCHAR(50),
                         grade INT
);

CREATE TABLE student_club (
                              student_id INT NOT NULL,
                              club_id INT NOT NULL,

                              CONSTRAINT pk_student_club PRIMARY KEY (student_id, club_id),

                              CONSTRAINT fk_student
                                  FOREIGN KEY (student_id)
                                      REFERENCES student(id)
                                      ON DELETE CASCADE,

                              CONSTRAINT fk_club
                                  FOREIGN KEY (club_id)
                                      REFERENCES club(id)
                                      ON DELETE CASCADE
);

----데이터 5개 이상 입력
INSERT INTO club (id, name) VALUES
                                (1, 'Soccer'),
                                (2, 'Basketball'),
                                (3, 'Reading'),
                                (4, 'Gaming'),
                                (5, 'Music'),
                                (6, 'Art');

INSERT INTO student (id, name, major, grade) VALUES
                                                 (1, 'John', 'Computer Science', 2),
                                                 (2, 'Emma', 'Business', 3),
                                                 (3, 'Mike', 'Electrical Engineering', 1),
                                                 (4, 'Sophia', 'Design', 4),
                                                 (5, 'David', 'Mechanical Engineering', 2),
                                                 (6, 'Olivia', 'Psychology', 3);

INSERT INTO student_club (student_id, club_id) VALUES
-- John
(1, 1),
(1, 4),
(1, 5),

-- Emma
(2, 3),
(2, 5),

-- Mike
(3, 1),
(3, 2),
(3, 6),

-- Sophia
(4, 4),
(4, 6),

-- David
(5, 2),
(5, 5),

-- Olivia
(6, 3),
(6, 4),
(6, 6);


---- 조회 ------
SELECT * FROM student;
SELECT * FROM club;
SELECT * FROM student_club;

SELECT s.name AS student, c.name AS club --전체 조회
FROM student s
         JOIN student_club sc ON s.id = sc.student_id
         JOIN club c ON sc.club_id = c.id;

-- order by
SELECT * FROM student --학년 높은 순
ORDER BY grade DESC;

--축구 동아리 소속 학생 조회
SELECT s.name
FROM student s
         JOIN student_club sc ON s.id = sc.student_id
         JOIN club c ON sc.club_id = c.id
WHERE c.name = 'Soccer';