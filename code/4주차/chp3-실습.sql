-- 1. 사용자 테이블 생성
CREATE TABLE users (
                       user_id SERIAL PRIMARY KEY,
                       student_no VARCHAR(20) NOT NULL UNIQUE,
                       name VARCHAR(50) NOT NULL,
                       email VARCHAR(100),
                       phone VARCHAR(20)
);

-- 2. 동아리 테이블 생성
CREATE TABLE club (
                      club_id SERIAL PRIMARY KEY,
                      club_name VARCHAR(100) NOT NULL,
                      created_at DATE NOT NULL
);

-- 3. 사용자_동아리 관계 테이블 생성
CREATE TABLE membership (
                            user_id INTEGER NOT NULL,
                            club_id INTEGER NOT NULL,
                            role VARCHAR(20),
                            joined_date DATE DEFAULT CURRENT_DATE,

                            PRIMARY KEY (user_id, club_id),

                            CONSTRAINT fk_user FOREIGN KEY (user_id)
                                REFERENCES users(user_id) ON DELETE CASCADE,
                            CONSTRAINT fk_club FOREIGN KEY (club_id)
                                REFERENCES club(club_id) ON DELETE CASCADE
);



-- 1. 사용자User 2명 등록
INSERT INTO users (student_no, name, email, phone)
VALUES
    ('2544408', '정석호', 'jsh00315@a.ut.ac.kr', '010-1234-5678'),
    ('2021002', '김철수', 'chulsoo@a.ut.ac.kr', '010-9876-5432');

-- 2. 동아리 2개 생성
INSERT INTO club (club_name, created_at)
VALUES
    ('컴퓨터 알고리즘 스터디', '2025-03-02'),
    ('농구 동아리', '2024-09-15');

-- 3. 관계 연결
INSERT INTO membership (user_id, club_id, role, joined_date)
VALUES
    (1, 1, '회장', '2025-03-05'),
    (1, 2, '일반회원', '2025-03-10'),
    (2, 1, '일반회원', '2025-03-06');