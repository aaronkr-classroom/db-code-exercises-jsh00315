# 12장 연습문제

## 개념퍼즐

### 가로
가로

1 CURRVAL
2 ALTER SEQUENCE
3 DROP SEQUENCE
4 CREATE INDEX
10 TRUNCATE TABLE
12 ALTER TABLE
13 CREATE VIEW
14 DROP TABLE
15 임시테이블
16 INSERT
19 의사열
20 가상테이블
22 단순뷰
23 UPDATE

세로

1 CREATE SEQUENCE
5 DROP VIEW
6 INSERT
7 DELETE
8 CREATE TABLE
9 NEXTVAL
11 CHAR
17 SELECT
18 기본테이블
21 복합뷰

## 연습문제

### 1. DB 구현 단계의 주요 업무가 아닌 것은?

**정답: ②**

생성된 DB 구조가 설계된 DB 구조와 정확히 일치하는지 확인한다.

---

### 2. 다음과 같은 내부 스키마를 기초로 하여 lab 테이블을 생성하는 SQL 문을 작성하시오.

```sql
CREATE TABLE lab (
    lab_num NUMBER(3),
    name VARCHAR2(50) NOT NULL UNIQUE,
    building VARCHAR2(50) NOT NULL,
    room_id CHAR(4),
    dept_id CHAR(4),

    CONSTRAINT lab_pk PRIMARY KEY (lab_num),

    CONSTRAINT lab_fk
        FOREIGN KEY (dept_id)
        REFERENCES dept(id)
);
```

---

### 3. 02번 문제에서 생성한 lab 테이블에 숫자 타입 (4바이트)의 ‘면적(lab_size)’ 열을 추가하고, 디폴트 값을 '50'으로 설정하는 SQL 문을 작성하시오.

```sql
ALTER TABLE lab
ADD lab_size NUMBER(4) DEFAULT 50;
```

---

### 4. 02번 문제에서 생성한 lab 테이블의 ‘호실(room_id)’ 열에 room_id_idx라는 인덱스를 생성하는 SQL 문을 작성하시오.

```sql
CREATE INDEX room_id_idx
ON lab(room_id);
```

---

### 5. 02번 문제에서 생성한 lab 테이블에 다음 데이터를 삽입하는 SQL 문을 작성하시오.

```sql
INSERT INTO lab
VALUES (188, '가상현실', '2공학관', 'B283', 'comp');

INSERT INTO lab
VALUES (118, '인공지능', '2공학관', 'A181', 'comp');
```

---

### 6. 02번 문제에서 생성한 lab 테이블에 건물명이 ‘2공학관’인 모든 실험실의 명칭과 소속학과번호를 검색하는 SQL 문을 작성하시오.

```sql
SELECT name, dept_id
FROM lab
WHERE building = '2공학관';
```

---

### 7. 02번 문제에서 생성한 lab 테이블에 명칭이 ‘인공지능’인 실험실의 호실을 ‘B102’로 변경하는 SQL 문을 작성하시오.

```sql
UPDATE lab
SET room_id = 'B102'
WHERE name = '인공지능';
```

---

### 8. 02번 문제에서 생성한 lab 테이블을 기초로 하여 소속학과 id가 ‘comp’인 모든 실험실의 명칭(name), 호실(room_id), 면적(lab_size)을 포함하는 com_lab_view라는 뷰를 생성하는 SQL 문을 작성하시오.

```sql
CREATE VIEW com_lab_view
AS
SELECT name, room_id, lab_size
FROM lab
WHERE dept_id = 'comp';
```

---

### 9. 02번 문제에서 생성한 lab 테이블의 기본키인 실험실번호(lab_num) 값을 자동으로 생성하는 데 사용할 시퀀스인 lab_num_seq를 생성하려고 한다. 첫 번째 시퀀스 값은 120이고, 최대 990까지 10씩 증가시키고, 최댓값에 도달한 후에 다시 첫 번째 시퀀스 번호부터 생성하지 않고, 시퀀스 값을 미리 생성하지 않도록 시퀀스를 정의하는 SQL 문을 작성하시오.

```sql
CREATE SEQUENCE lab_num_seq
    INCREMENT BY 10
    START WITH 120
    MAXVALUE 990
    NOCYCLE
    NOCACHE;
```

---

### 10. 09번 문제에서 생성한 시퀀스인 lab_num_seq를 이용해서 2번 문제에서 생성한 lab 테이블에 다음과 같은 데이터를 삽입하는 SQL 문을 작성하시오.

```sql
INSERT INTO lab
    (lab_num, name, building, room_id, dept_id)
VALUES
    (lab_num_seq.NEXTVAL,
     '네트워크',
     '2공학관',
     'B281',
     'comp');
```

---

### 11. 앞에서 생성한 테이블과 인덱스, 뷰, 시퀀스를 모두 삭제하는 SQL 문을 작성하시오.

```sql
DROP INDEX room_id_idx;

DROP VIEW com_lab_view;

DROP SEQUENCE lab_num_seq;

DROP TABLE lab;
```
