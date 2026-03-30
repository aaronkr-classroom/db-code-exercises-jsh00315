## 요구사항 작성 (동아리 관리)

1. 회원 가입 및 관리
   - 사용자는 이름, 학번, 연락처를 입력하여 회원으로 등록해야 한다.

2. 동아리 개설 
   - 운영진은 동아리 이름, 카테고리, 설립일 정보를 포함하는 동아리를 생성할 수 있다.

3. 가입 신청
   - 사용자는 특정 동아리에 가입 신청을 할 수 있으며, 신청일 정보가 기록되어야 한다.

4. 역할 구분
   - 사용자는 일반 회원과 운영진으로 구분되며, 운영진만 동아리 정보를 수정할 수 있다.

5. 활동 상태 추적
   - 각 회원은 특정 동아리 내에서 '활동 중', '탈퇴', '대기' 등의 상태를 가진다.


## 데이터 설계(엔티티 정의)
   
- `User` (사용자): 시스템을 이용하는 개별 주체

    - `user_id` (PK): 고유 식별자 (Integer, Serial)

    - `student_no` (학번): 중복 불가 (Varchar)

    - `name` (이름): (Varchar)

    - `email` (이메일): (Varchar)

    - `phone` (연락처): (Varchar)

- `club` (동아리): 학교 내에 존재하는 동아리 단체

    - `club_id` (PK): 고유 식별자 (Integer, Serial)

    - `club_name` (동아리명): (Varchar)

    - `created_at` (설립일): (Date)


```postgresqlsql
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


```