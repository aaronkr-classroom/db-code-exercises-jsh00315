/*

--문화 센터 예시

--릴레이션 스키마
    강사(강사번호(Pk), 이름, 전문분야, 연락처)
    강좌(강좌번호(PK), 강좌명, 수강료, 최대인원, 강사번호(FK))
    회원(회원번호(PK), 이름, 전화번호, 가입일)
    수강신천(회원번호(FK),강좌번호(FK),신청일)

-- 간단한 ERD

    강사 ---1:N--- 강좌 ---N:M--- 회원 (기존)
    강사 ---1:N--- 강좌 ---1:N--- 수강신청 --- N:1 --- 회원
*/

create table instructors(
    instructor_id int primary key ,
    name varchar(30) not null ,
    specialty varchar(50),
    contact varchar(13)
);

create table classes(
    --최대인원은 5-50면, CHECK 필수
    class_id int primary key , --자동 인덱스
    class_name varchar(50) not null,
    fee int check (fee>=0),
    max_students int check (max_students between  5 and 50),
    instructor_id int, -- FK
    foreign key (instructor_id) references instructors(instructor_id)
);

create table members(
    member_id int primary key ,
    name varchar(30) not null,
    phone varchar(13),
    join_date date
);

create table registrations(
    member_id int,
    class_id int,
    register_date date,
    primary key (member_id,class_id),
    foreign key (member_id)
                          references members(member_id)
                          on delete cascade ,
    foreign key (class_id)
                          references classes(class_id)
                          on delete cascade
);


-- INSERT

insert into instructors values
                            (1,'김영희','요가','010-1111-1111'),
                            (2,'박민수','드로잉','010-2222-2222'),
                            (3,'이지은','영어회화','010-3333-3333');

insert into classes values
                        (101,'아침 요가',50000,20,1),
                        (102,'수채화 기초',70000,15,2),
                        (103,'영어 회화',60000,25,3);
insert into members values
                        (1001, '홍길동','010-9999-9999','2026-03-01'),
                        (1002, '김철수','010-8888-8888','2026-03-02'),
                        (1003, '이영희','010-7777-7777','2026-03-03');

insert into registrations values
                              (1001,101,'2026-03-04'),
                              (1001,103,'2026-03-05'),
                              (1002,101,'2026-03-06'),
                              (1003,102,'2026-03-07');


-- JOIN
select m.name,
       c.class_name
from registrations r
join members m on r.member_id = m.member_id
join classes c on r.class_id = c.class_id;


-- INDEX
-- mambers에서 100,000명 추가
drop table members;

create table members(
                        member_id serial primary key , --자동 인덱스
                        name varchar(30) not null,
                        phone varchar(13),
                        join_date date
);


insert into members(name,phone,join_date)
select
    'Member_' || g,
    '010' || lpad((random()*9999)::int::text,4,'0'),
    || '-'
        || lpad((random()*9999)::int::text,4,'0'),
    current_date - ((random()*1000)::int)
from generate_series(1,100000) g;


--검색
-- INDEX
-- members에서 100,000명 추가

drop table members2;
CREATE TABLE members2 (
                          member_id SERIAL PRIMARY KEY, -- 자동 인덱스
                          name VARCHAR(30) NOT NULL,
                          phone VARCHAR(13),
                          join_date DATE
);
TABLE members2;

-- 검색 시간 확인하기
EXPLAIN ANALYZE
SELECT * FROM members2
WHERE name = '홍길동';
-- Planning Time: 0.052s
-- Execution Time: 11.921ms

-- INDEX 추가
CREATE TABLE idx_members_name
    ON members2(name);
--INDEX 추가
create index idx_members_name2
on members2(name);


-- VIEW 추가

create view registration_view as
    select m.name as 회원명,
           c.class_name as 강좌명,
           r.register_date as 신청일
from registrations r
join members m on r.member_id = m.member_id
join classes c on r.class_id = c.class_id;

select * from registrations;